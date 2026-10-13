import '../ai/care_suggestion.dart';
import '../growth/growth_metrics.dart';
import '../models/enums.dart';
import '../reminders/reminder_state.dart';

/// User-configurable thresholds for the deterministic rule engine. Defaults are
/// conservative: they prompt observation, never intervention.
class CareRuleSettings {
  const CareRuleSettings({
    this.significantWeightChangePercent = 10,
    this.measurementGapDays = 30,
    this.substrateIntervalDays,
    this.substrateLeadDays = 2,
    this.prepupaObservationWindowDays = 14,
    this.suggestionExpiryDays = 14,
    this.overdueGraceDays = 7,
  });

  final double significantWeightChangePercent;
  final int measurementGapDays;

  /// Null disables interval-based substrate suggestions (explicit
  /// `next_planned_at` dates on substrate records still apply).
  final int? substrateIntervalDays;
  final int substrateLeadDays;
  final int prepupaObservationWindowDays;
  final int suggestionExpiryDays;
  final int overdueGraceDays;

  CareRuleSettings copyWith({
    double? significantWeightChangePercent,
    int? measurementGapDays,
    int? Function()? substrateIntervalDays,
    int? suggestionExpiryDays,
  }) =>
      CareRuleSettings(
        significantWeightChangePercent:
            significantWeightChangePercent ?? this.significantWeightChangePercent,
        measurementGapDays: measurementGapDays ?? this.measurementGapDays,
        substrateIntervalDays:
            substrateIntervalDays != null ? substrateIntervalDays() : this.substrateIntervalDays,
        substrateLeadDays: substrateLeadDays,
        prepupaObservationWindowDays: prepupaObservationWindowDays,
        suggestionExpiryDays: suggestionExpiryDays ?? this.suggestionExpiryDays,
        overdueGraceDays: overdueGraceDays,
      );

  Map<String, String> toMap() => {
        'rules.weight_change_percent': '$significantWeightChangePercent',
        'rules.measurement_gap_days': '$measurementGapDays',
        'rules.substrate_interval_days': substrateIntervalDays?.toString() ?? '',
        'rules.suggestion_expiry_days': '$suggestionExpiryDays',
      };

  factory CareRuleSettings.fromMap(Map<String, String> m) {
    const d = CareRuleSettings();
    final interval = m['rules.substrate_interval_days'];
    return CareRuleSettings(
      significantWeightChangePercent:
          double.tryParse(m['rules.weight_change_percent'] ?? '') ?? d.significantWeightChangePercent,
      measurementGapDays: int.tryParse(m['rules.measurement_gap_days'] ?? '') ?? d.measurementGapDays,
      substrateIntervalDays:
          (interval == null || interval.isEmpty) ? null : int.tryParse(interval),
      suggestionExpiryDays:
          int.tryParse(m['rules.suggestion_expiry_days'] ?? '') ?? d.suggestionExpiryDays,
    );
  }
}

class ObservationSnap {
  const ObservationSnap({required this.id, required this.observedAt, required this.category});
  final String id;
  final DateTime observedAt;
  final ObservationCategory category;
}

class SubstrateSnap {
  const SubstrateSnap({required this.id, required this.changedAt, this.nextPlannedAt});
  final String id;
  final DateTime changedAt;
  final DateTime? nextPlannedAt;
}

class BeetleCareSnapshot {
  const BeetleCareSnapshot({
    required this.beetleId,
    required this.code,
    required this.status,
    required this.createdAt,
    this.stage,
    this.stageEventId,
    this.stageAt,
    this.weights = const [],
    this.observations = const [],
    this.latestSubstrate,
    this.expectedPupaDaysMin,
    this.expectedPupaDaysMax,
  });

  final String beetleId;
  final String code;
  final BeetleStatus status;
  final DateTime createdAt;
  final LifeStage? stage;
  final String? stageEventId;
  final DateTime? stageAt;
  final List<WeightPoint> weights;
  final List<ObservationSnap> observations;
  final SubstrateSnap? latestSubstrate;
  final int? expectedPupaDaysMin;
  final int? expectedPupaDaysMax;
}

class SensorCareSnapshot {
  const SensorCareSnapshot({
    required this.sensorId,
    required this.name,
    this.minC,
    this.maxC,
    this.latestRecordId,
    this.latestAt,
    this.latestC,
  });

  final String sensorId;
  final String name;
  final double? minC;
  final double? maxC;
  final String? latestRecordId;
  final DateTime? latestAt;
  final double? latestC;
}

class CareText {
  const CareText({
    required this.title,
    required this.message,
    required this.reason,
    required this.recommendation,
  });
  final String title;
  final String message;
  final String reason;
  final String recommendation;
}

/// Localized wording for rule output (implemented over AppLocalizations).
abstract class CareTexts {
  CareText weightChange(
      {required String code, required double percent, required double fromG, required double toG});
  CareText measurementOverdue({required String code, required int? daysSince});
  CareText substrateInspection({required String code, required int daysSinceChange});
  CareText temperatureOutOfRange(
      {required String sensor, required double celsius, double? minC, double? maxC});
  CareText possiblePrepupa({required String code});
  CareText emergenceWindow({required String code, required int minDays, required int maxDays});
}

/// A rule-generated suggestion plus the scheduling metadata needed to store it.
class RuleSuggestion {
  const RuleSuggestion({
    required this.suggestion,
    required this.beetleId,
    required this.sensorId,
    required this.dueAt,
    required this.periodStart,
    required this.periodEnd,
    required this.dedupeKey,
  });

  final CareSuggestion suggestion;
  final String? beetleId;
  final String? sensorId;
  final DateTime dueAt;
  final DateTime periodStart;
  final DateTime? periodEnd;
  final String dedupeKey;
}

/// Deterministic, objective triggers. Every output is a *suggestion* that the
/// user must confirm; nothing here schedules notifications or edits records.
class CareRuleEngine {
  const CareRuleEngine(this.settings, this.texts);

  final CareRuleSettings settings;
  final CareTexts texts;
  static const _validator = CareSuggestionValidator();

  static const _larval = {LifeStage.l1, LifeStage.l2, LifeStage.l3};

  List<RuleSuggestion> evaluate({
    required List<BeetleCareSnapshot> beetles,
    required List<SensorCareSnapshot> sensors,
    required DateTime now,
  }) {
    final out = <RuleSuggestion>[];
    for (final b in beetles) {
      if (b.status != BeetleStatus.active) continue;
      _weightChange(b, now, out);
      _measurementOverdue(b, now, out);
      _substrate(b, now, out);
      _possiblePrepupa(b, now, out);
      _emergenceWindow(b, now, out);
    }
    for (final s in sensors) {
      _temperature(s, now, out);
    }
    return out;
  }

  void _weightChange(BeetleCareSnapshot b, DateTime now, List<RuleSuggestion> out) {
    final m = GrowthMetrics.compute(b.weights);
    final pct = m.percentChangeSincePrevious;
    if (pct == null || pct.abs() < settings.significantWeightChangePercent) return;
    final loss = pct < 0;
    final t = texts.weightChange(
        code: b.code, percent: pct, fromG: m.previous!.grams, toG: m.latest!.grams);
    _add(
      out,
      beetleId: b.beetleId,
      code: b.code,
      event: loss ? CareEventType.weightLoss : CareEventType.significantWeightChange,
      severity: loss ? Severity.warning : Severity.info,
      confidence: Confidence.high,
      basis: SuggestionBasis.calculated,
      evidence: [m.previous!.id, m.latest!.id],
      text: t,
      delayDays: 7,
      now: now,
      anchor: m.latest!.id,
    );
  }

  void _measurementOverdue(BeetleCareSnapshot b, DateTime now, List<RuleSuggestion> out) {
    // Only larvae: weighing a prepupa or pupa risks harming it.
    if (b.stage != null && !_larval.contains(b.stage)) return;
    final m = GrowthMetrics.compute(b.weights);
    final last = m.latest?.measuredAt ?? b.createdAt;
    final days = now.difference(last).inDays;
    if (days < settings.measurementGapDays) return;
    _add(
      out,
      beetleId: b.beetleId,
      code: b.code,
      event: CareEventType.measurementOverdue,
      severity: Severity.info,
      confidence: Confidence.high,
      basis: SuggestionBasis.calculated,
      evidence: [m.latest?.id ?? b.beetleId],
      text: texts.measurementOverdue(code: b.code, daysSince: m.latest == null ? null : days),
      delayDays: 0,
      now: now,
      anchor: m.latest?.id ?? 'none',
    );
  }

  void _substrate(BeetleCareSnapshot b, DateTime now, List<RuleSuggestion> out) {
    final s = b.latestSubstrate;
    if (s == null) return;
    DateTime? due;
    if (s.nextPlannedAt != null) {
      if (s.nextPlannedAt!.difference(now).inDays <= settings.substrateLeadDays) {
        due = s.nextPlannedAt!.isBefore(now) ? now : s.nextPlannedAt!;
      }
    } else if (settings.substrateIntervalDays != null &&
        now.difference(s.changedAt).inDays >= settings.substrateIntervalDays!) {
      due = now;
    }
    if (due == null) return;
    _add(
      out,
      beetleId: b.beetleId,
      code: b.code,
      event: CareEventType.substrateInspection,
      severity: Severity.info,
      confidence: Confidence.high,
      basis: SuggestionBasis.calculated,
      evidence: [s.id],
      text: texts.substrateInspection(code: b.code, daysSinceChange: now.difference(s.changedAt).inDays),
      delayDays: due.difference(now).inDays.clamp(0, 365),
      now: now,
      dueAt: due,
      anchor: s.id,
    );
  }

  void _possiblePrepupa(BeetleCareSnapshot b, DateTime now, List<RuleSuggestion> out) {
    if (b.stage != LifeStage.l3) return;
    final window = now.subtract(Duration(days: settings.prepupaObservationWindowDays));
    final signals = b.observations
        .where((o) =>
            o.observedAt.isAfter(window) &&
            (o.category == ObservationCategory.colorChange ||
                o.category == ObservationCategory.pupalChamber))
        .toList()
      ..sort((a, b) => b.observedAt.compareTo(a.observedAt));
    if (signals.isEmpty) return;
    _add(
      out,
      beetleId: b.beetleId,
      code: b.code,
      event: CareEventType.possiblePrepupa,
      severity: Severity.observation,
      // A single observation category is weak evidence; never more than low.
      confidence: Confidence.low,
      basis: SuggestionBasis.calculated,
      evidence: signals.map((o) => o.id).take(10).toList(),
      text: texts.possiblePrepupa(code: b.code),
      delayDays: 3,
      now: now,
      anchor: signals.first.id,
    );
  }

  void _emergenceWindow(BeetleCareSnapshot b, DateTime now, List<RuleSuggestion> out) {
    final min = b.expectedPupaDaysMin, max = b.expectedPupaDaysMax;
    if (b.stage != LifeStage.pupa || b.stageAt == null || min == null || max == null) return;
    final start = b.stageAt!.add(Duration(days: min));
    final end = b.stageAt!.add(Duration(days: max));
    if (now.isAfter(end)) return;
    _add(
      out,
      beetleId: b.beetleId,
      code: b.code,
      event: CareEventType.expectedEmergenceWindow,
      severity: Severity.observation,
      confidence: Confidence.medium,
      basis: SuggestionBasis.calculated,
      evidence: [b.stageEventId!],
      text: texts.emergenceWindow(code: b.code, minDays: min, maxDays: max),
      delayDays: start.isAfter(now) ? start.difference(now).inDays.clamp(0, 365) : 0,
      now: now,
      dueAt: start.isAfter(now) ? start : now,
      periodEnd: end,
      anchor: b.stageEventId!,
    );
  }

  void _temperature(SensorCareSnapshot s, DateTime now, List<RuleSuggestion> out) {
    final c = s.latestC;
    if (c == null || s.latestRecordId == null) return;
    final below = s.minC != null && c < s.minC!;
    final above = s.maxC != null && c > s.maxC!;
    if (!below && !above) return;
    _add(
      out,
      beetleId: null,
      sensorId: s.sensorId,
      code: null,
      event: CareEventType.temperatureOutOfRange,
      severity: Severity.alert,
      confidence: Confidence.high,
      // Distinguishes a measured threshold violation from AI predictions.
      basis: SuggestionBasis.measured,
      evidence: [s.latestRecordId!],
      text: texts.temperatureOutOfRange(sensor: s.name, celsius: c, minC: s.minC, maxC: s.maxC),
      delayDays: 0,
      now: now,
      anchor: s.latestRecordId!,
    );
  }

  void _add(
    List<RuleSuggestion> out, {
    required String? beetleId,
    String? sensorId,
    required String? code,
    required CareEventType event,
    required Severity severity,
    required Confidence confidence,
    required SuggestionBasis basis,
    required List<String> evidence,
    required CareText text,
    required int delayDays,
    required DateTime now,
    required String anchor,
    DateTime? dueAt,
    DateTime? periodEnd,
  }) {
    final candidate = CareSuggestion(
      beetleCode: code,
      eventType: event,
      severity: severity,
      confidence: confidence,
      basis: basis,
      evidenceRecordIds: evidence.toSet().toList(),
      reason: text.reason,
      recommendation: text.recommendation,
      reminder: SuggestedReminder(
          enabled: true, delayDays: delayDays, title: text.title, message: text.message),
    );
    // Rule output goes through the same strict validator as AI output.
    final validated = _validator.validate(candidate.toJson());
    if (!validated.isValid) return;
    final due = dueAt ?? now.add(Duration(days: delayDays));
    out.add(RuleSuggestion(
      suggestion: validated.value!,
      beetleId: beetleId,
      sensorId: sensorId,
      dueAt: due,
      periodStart: due,
      periodEnd: periodEnd,
      dedupeKey:
          buildDedupeKey(beetleId: beetleId, sensorId: sensorId, eventType: event, anchor: anchor),
    ));
  }
}
