import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../data/repositories/ai_memory_repository.dart';
import '../data/repositories/breeding_read_model.dart';
import '../data/repositories/reminder_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../domain/ai/ai_orchestrator.dart';
import '../domain/ai/ai_provider.dart';
import '../domain/ai/ai_router.dart';
import '../domain/ai/breeding_tools.dart';
import '../domain/ai/care_suggestion.dart';
import '../domain/growth/growth_metrics.dart';
import '../domain/models/enums.dart';
import '../domain/proactive/care_rules.dart';
import '../domain/reminders/dedupe.dart';
import '../domain/reminders/reminder_state.dart';

class AiInterpretationResult {
  const AiInterpretationResult({required this.stored, required this.rejected, required this.errors});
  final int stored;
  final int rejected;
  final List<String> errors;
}

/// Proactive care: deterministic rules for objective triggers (always, offline)
/// and optional AI interpretation for context. Both only ever produce
/// `suggested` reminders that the user must confirm.
class ProactiveCareService {
  ProactiveCareService({
    required this.readModel,
    required this.reminders,
    required this.settings,
    required this.memory,
    required this.texts,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final DriftBreedingReadModel readModel;
  final ReminderRepository reminders;
  final SettingsRepository settings;
  final AiMemoryRepository memory;
  final CareTexts Function() texts;
  final DateTime Function() _clock;

  static const _validator = CareSuggestionValidator();

  static RecordType _evidenceType(CareEventType e) => switch (e) {
        CareEventType.significantWeightChange || CareEventType.weightLoss => RecordType.weight,
        CareEventType.measurementOverdue => RecordType.weight,
        CareEventType.substrateInspection => RecordType.substrate,
        CareEventType.containerReview => RecordType.container,
        CareEventType.temperatureOutOfRange => RecordType.temperature,
        CareEventType.possiblePrepupa || CareEventType.possiblePupation => RecordType.observation,
        CareEventType.expectedEmergenceWindow => RecordType.lifeStage,
        _ => RecordType.beetle,
      };

  /// Runs all rules (optionally for one beetle) and expires stale reminders.
  /// Returns the number of new suggestions stored.
  Future<int> evaluate({String? beetleId}) async {
    final now = _clock().toUtc();
    final rules = await settings.careRules();
    final engine = CareRuleEngine(rules, texts());
    final found = engine.evaluate(
      beetles: await readModel.beetleSnapshots(onlyBeetleId: beetleId),
      sensors: await readModel.sensorSnapshots(),
      now: now,
    );
    var stored = 0;
    for (final r in found) {
      final type = _evidenceType(r.suggestion.eventType);
      final id = await reminders.insertSuggestion(SuggestionToStore(
        suggestion: r.suggestion,
        source: ReminderSource.rule,
        beetleId: r.beetleId,
        sensorId: r.sensorId,
        dueAt: r.dueAt,
        periodStart: r.periodStart,
        periodEnd: r.periodEnd,
        dedupeKey: r.dedupeKey,
        evidence: [
          for (final e in r.suggestion.evidenceRecordIds)
            (e == r.beetleId ? RecordType.beetle : type, e),
        ],
      ), now: now);
      if (id != null) stored++;
    }
    final expired = findExpired(await reminders.existingForDedupe(),
        now: now,
        suggestionExpiryDays: rules.suggestionExpiryDays,
        overdueGraceDays: rules.overdueGraceDays);
    await reminders.expire(expired);
    return stored;
  }

  /// Asks the routed AI provider to interpret one beetle's recent records.
  ///
  /// The output is validated against the strict schema; suggestions for a
  /// different beetle or citing record IDs that were not in the provided
  /// context (fabricated evidence) are rejected.
  Future<AiInterpretationResult> interpretWithAi(String beetleId, AiRouter router) async {
    final decision = await router.select({AiCapability.proactiveInterpretation});
    if (decision is NoProviderAvailable) throw NoAiProviderException(decision);
    final routed = decision as RoutedTo;

    final now = _clock().toUtc();
    final (context, allowedIds, code) = await _buildContext(beetleId, now);
    final raw = await routed.provider.interpretProactive(context);
    final batch = _validator.validateBatch(raw);
    final errors = [...batch.errors];
    final accepted = <CareSuggestion>[];
    for (final s in batch.valid) {
      if (s.beetleCode != code) {
        errors.add('beetle_id ${s.beetleCode} does not match $code');
      } else if (!s.evidenceRecordIds.every(allowedIds.contains)) {
        errors.add('evidence not found in provided records: ${s.evidenceRecordIds}');
      } else {
        accepted.add(s);
      }
    }
    final total = (raw is Map && raw['suggestions'] is List) ? (raw['suggestions'] as List).length : 0;
    final rejected = errors.isEmpty ? 0 : (total - accepted.length).clamp(1, 1 << 20);

    final analysisId = await memory.saveAnalysis(
      kind: AnalysisKind.proactive,
      provider: routed.status.kind.name,
      model: routed.status.model,
      beetleId: beetleId,
      response: jsonEncode(raw),
      evidence: {for (final s in accepted) ...s.evidenceRecordIds.map((e) => EvidenceRef(_typeOf(e, context), e))},
    );

    var stored = 0;
    for (final s in accepted) {
      final delay = s.reminder?.delayDays ?? 0;
      final due = now.add(Duration(days: delay));
      // AI output is always a hypothesis-level suggestion, whatever it claims.
      final suggestion = CareSuggestion(
        beetleCode: s.beetleCode,
        eventType: s.eventType,
        severity: s.severity,
        confidence: s.confidence,
        basis: SuggestionBasis.aiInference,
        evidenceRecordIds: s.evidenceRecordIds,
        reason: s.reason,
        recommendation: s.recommendation,
        reminder: s.reminder,
      );
      final anchor = 'ai:${(List.of(s.evidenceRecordIds)..sort()).join(',')}';
      final id = await reminders.insertSuggestion(SuggestionToStore(
        suggestion: suggestion,
        source: ReminderSource.ai,
        beetleId: beetleId,
        sensorId: null,
        dueAt: due,
        periodStart: due,
        periodEnd: null,
        dedupeKey: buildDedupeKey(
            beetleId: beetleId, sensorId: null, eventType: s.eventType, anchor: anchor),
        evidence: [for (final e in s.evidenceRecordIds) (_typeOf(e, context), e)],
        analysisId: analysisId,
      ), now: now);
      if (id != null) stored++;
    }
    if (errors.isNotEmpty) debugPrint('AI interpretation validation: $errors');
    return AiInterpretationResult(stored: stored, rejected: rejected, errors: errors);
  }

  Future<(Map<String, Object?>, Set<String>, String)> _buildContext(
      String beetleId, DateTime now) async {
    final profileRow = await readModel.beetlesRepo.beetleRow(beetleId);
    final code = profileRow.code;
    final profile = await readModel.beetleProfile(code);
    final weights = await readModel.weights(beetleId);
    final recentWeights = weights.length > 20 ? weights.sublist(weights.length - 20) : weights;
    final observations = await readModel.observations(beetleId, since: now.subtract(const Duration(days: 60)));
    final substrate = await readModel.substrateChanges(beetleId);
    final containers = await readModel.containerChanges(beetleId);
    final stages = await readModel.lifeStageEvents(beetleId);
    final temps = await readModel.temperatures(beetleId: beetleId, since: now.subtract(const Duration(days: 14)));
    List<T> last<T>(List<T> l, int n) => l.length > n ? l.sublist(l.length - n) : l;

    final weightJson = [
      for (final w in recentWeights)
        {'id': w.id, 'measured_at': w.measuredAt.toUtc().toIso8601String(), 'weight_grams': w.grams},
    ];
    final context = <String, Object?>{
      'as_of': now.toIso8601String(),
      'beetle': profile,
      'growth_metrics_all': GrowthMetrics.compute(weights).toJson(),
      'growth_metrics_30d':
          GrowthMetrics.compute(weights, from: now.subtract(const Duration(days: 30))).toJson(),
      'weights': weightJson,
      'observations': last(observations, 20),
      'substrate_changes': last(substrate, 5),
      'container_changes': last(containers, 5),
      'life_stage_events': stages,
      'temperatures': last(temps, 50),
    };
    final ids = <String>{
      beetleId,
      for (final w in recentWeights) w.id,
      for (final list in [observations, substrate, containers, stages, temps])
        for (final r in list) r['id']! as String,
    };
    return (context, ids, code);
  }

  static RecordType _typeOf(String id, Map<String, Object?> context) {
    bool inList(String key) =>
        (context[key] as List? ?? const []).any((r) => r is Map && r['id'] == id);
    if (inList('weights')) return RecordType.weight;
    if (inList('observations')) return RecordType.observation;
    if (inList('substrate_changes')) return RecordType.substrate;
    if (inList('container_changes')) return RecordType.container;
    if (inList('life_stage_events')) return RecordType.lifeStage;
    if (inList('temperatures')) return RecordType.temperature;
    return RecordType.beetle;
  }
}
