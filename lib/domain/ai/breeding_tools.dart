import 'dart:convert';

import '../growth/growth_metrics.dart';
import '../models/enums.dart';
import 'ai_provider.dart';

/// Read-only view of breeding data exposed to AI tools. Implementations must
/// not offer any write operations; this is the "read-only database tools by
/// default" boundary. Every returned record map contains its `id`.
abstract class BreedingReadModel {
  Future<List<Map<String, Object?>>> beetles({String? speciesCode, BeetleStatus? status});
  Future<Map<String, Object?>?> beetleProfile(String code);
  Future<String?> beetleIdForCode(String code);
  Future<List<WeightPoint>> weights(String beetleId, {DateTime? since});
  Future<List<Map<String, Object?>>> observations(String beetleId, {DateTime? since});
  Future<List<Map<String, Object?>>> substrateChanges(String beetleId);
  Future<List<Map<String, Object?>>> containerChanges(String beetleId);
  Future<List<Map<String, Object?>>> lifeStageEvents(String beetleId);

  /// Readings for the beetle's assigned sensor, or all sensors when null.
  Future<List<Map<String, Object?>>> temperatures({String? beetleId, DateTime? since});
}

/// A reminder the model proposed. It is only shown to the user; nothing is
/// stored or scheduled until the user confirms it.
class ReminderDraft {
  const ReminderDraft({
    required this.beetleCode,
    required this.title,
    required this.message,
    required this.delayDays,
    required this.reason,
  });
  final String beetleCode;
  final String title;
  final String message;
  final int delayDays;
  final String reason;
}

class EvidenceRef {
  const EvidenceRef(this.type, this.id);
  final RecordType type;
  final String id;

  @override
  bool operator ==(Object other) => other is EvidenceRef && other.type == type && other.id == id;

  @override
  int get hashCode => Object.hash(type, id);
}

class ToolResult {
  const ToolResult(this.json, {this.evidence = const {}, this.draft});
  final String json;
  final Set<EvidenceRef> evidence;
  final ReminderDraft? draft;
}

/// Controlled function-calling layer. Every tool is read-only except
/// `propose_reminder_draft`, which only records a draft for user review.
/// Numbers come from deterministic code ([GrowthMetrics]).
class BreedingTools {
  BreedingTools(this.data, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final BreedingReadModel data;
  final DateTime Function() _clock;

  static const _maxRecords = 100;

  static const _beetleIdParam = {
    'type': 'string',
    'description': 'Beetle code such as DHH-001 or CCK-001',
  };
  static const _sinceDaysParam = {
    'type': 'integer',
    'minimum': 1,
    'maximum': 3650,
    'description': 'Only include records from the last N days',
  };

  List<ToolDefinition> get definitions => const [
        ToolDefinition(
          name: 'list_beetles',
          description: 'List beetles with species, sex, current stage and status.',
          parameters: {
            'type': 'object',
            'properties': {
              'species_code': {'type': 'string', 'description': 'e.g. DHH, CCK'},
              'status': {
                'type': 'string',
                'enum': ['active', 'deceased', 'transferred', 'archived'],
              },
            },
          },
        ),
        ToolDefinition(
          name: 'get_beetle_profile',
          description:
              'Profile of one beetle: species, sex, dates, current stage, latest weight, container and substrate.',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'get_weight_history',
          description: 'Recorded weight measurements (grams) for a beetle, oldest first.',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam, 'since_days': _sinceDaysParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'get_growth_metrics',
          description:
              'Deterministically calculated growth metrics: change since previous, percent change, average daily/weekly change, max weight. Use this instead of doing arithmetic yourself.',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam, 'since_days': _sinceDaysParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'compare_growth',
          description: 'Calculated growth metrics for several beetles over the same window.',
          parameters: {
            'type': 'object',
            'properties': {
              'beetle_ids': {
                'type': 'array',
                'items': _beetleIdParam,
                'minItems': 2,
                'maxItems': 10,
              },
              'since_days': _sinceDaysParam,
            },
            'required': ['beetle_ids'],
          },
        ),
        ToolDefinition(
          name: 'get_temperature_history',
          description:
              "Temperature readings (°C) for the beetle's assigned sensor, or all sensors if no beetle is given. Includes the user's configured thresholds.",
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam, 'since_days': _sinceDaysParam},
          },
        ),
        ToolDefinition(
          name: 'get_substrate_changes',
          description: 'Substrate replacement history (brand, batch, quantity, condition).',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'get_container_changes',
          description: 'Container change history (previous and new volume in liters).',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'get_observations',
          description: 'Observation notes recorded by the keeper (color change, activity, pupal chamber, etc.).',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam, 'since_days': _sinceDaysParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'get_life_stage_events',
          description: 'Recorded life-stage transitions (L1, L2, L3, prepupa, pupa, adult).',
          parameters: {
            'type': 'object',
            'properties': {'beetle_id': _beetleIdParam},
            'required': ['beetle_id'],
          },
        ),
        ToolDefinition(
          name: 'propose_reminder_draft',
          description:
              'Propose a reminder for the keeper to review. This does NOT create or schedule anything; the keeper must confirm it.',
          parameters: {
            'type': 'object',
            'properties': {
              'beetle_id': _beetleIdParam,
              'title': {'type': 'string', 'maxLength': 80},
              'message': {'type': 'string', 'maxLength': 500},
              'delay_days': {'type': 'integer', 'minimum': 0, 'maximum': 365},
              'reason': {'type': 'string', 'maxLength': 1000},
            },
            'required': ['beetle_id', 'title', 'message', 'delay_days', 'reason'],
          },
        ),
      ];

  Future<ToolResult> execute(ToolCall call) async {
    try {
      final a = call.arguments;
      return switch (call.name) {
        'list_beetles' => await _listBeetles(a),
        'get_beetle_profile' => await _withBeetle(a, (id, code) async {
            final profile = await data.beetleProfile(code);
            return _result({'as_of': _now(), 'beetle': profile},
                {EvidenceRef(RecordType.beetle, id)});
          }),
        'get_weight_history' => await _withBeetle(a, (id, code) async {
            final w = await data.weights(id, since: _since(a));
            final list = w.length > _maxRecords ? w.sublist(w.length - _maxRecords) : w;
            return _result({
              'as_of': _now(),
              'beetle_id': code,
              'unit': 'g',
              'truncated': w.length > _maxRecords,
              'records': [
                for (final p in list)
                  {'id': p.id, 'measured_at': _iso(p.measuredAt), 'weight_grams': p.grams},
              ],
            }, {for (final p in list) EvidenceRef(RecordType.weight, p.id)});
          }),
        'get_growth_metrics' => await _withBeetle(a, (id, code) async {
            final w = await data.weights(id, since: _since(a));
            final m = GrowthMetrics.compute(w);
            return _result({
              'as_of': _now(),
              'beetle_id': code,
              'window_days': a['since_days'],
              'metrics': m.toJson(),
              'note': 'Averages describe the first and last record only; growth is not linear.',
            }, {for (final p in w) EvidenceRef(RecordType.weight, p.id)});
          }),
        'compare_growth' => await _compare(a),
        'get_temperature_history' => await _temperatures(a),
        'get_substrate_changes' => await _withBeetle(a, (id, code) async {
            final r = await data.substrateChanges(id);
            return _records(code, r, RecordType.substrate);
          }),
        'get_container_changes' => await _withBeetle(a, (id, code) async {
            final r = await data.containerChanges(id);
            return _records(code, r, RecordType.container);
          }),
        'get_observations' => await _withBeetle(a, (id, code) async {
            final r = await data.observations(id, since: _since(a));
            return _records(code, r, RecordType.observation);
          }),
        'get_life_stage_events' => await _withBeetle(a, (id, code) async {
            final r = await data.lifeStageEvents(id);
            return _records(code, r, RecordType.lifeStage);
          }),
        'propose_reminder_draft' => await _proposeDraft(a),
        _ => _error('unknown_tool', 'Tool ${call.name} does not exist.'),
      };
    } on _ToolArgumentError catch (e) {
      return _error('invalid_arguments', e.message);
    }
  }

  Future<ToolResult> _listBeetles(Map<String, Object?> a) async {
    final statusName = a['status'];
    final status = BeetleStatus.values.where((s) => s.name == statusName).firstOrNull;
    final list = await data.beetles(speciesCode: a['species_code'] as String?, status: status);
    return _result({'as_of': _now(), 'beetles': list},
        {for (final b in list) EvidenceRef(RecordType.beetle, b['id']! as String)});
  }

  Future<ToolResult> _compare(Map<String, Object?> a) async {
    final codes = a['beetle_ids'];
    if (codes is! List || codes.length < 2 || codes.length > 10) {
      throw _ToolArgumentError('beetle_ids must be a list of 2-10 beetle codes');
    }
    final since = _since(a);
    final out = <Map<String, Object?>>[];
    final evidence = <EvidenceRef>{};
    for (final c in codes) {
      final code = '$c'.toUpperCase();
      final id = await data.beetleIdForCode(code);
      if (id == null) {
        out.add({'beetle_id': code, 'error': 'not_found'});
        continue;
      }
      final w = await data.weights(id, since: since);
      evidence.addAll(w.map((p) => EvidenceRef(RecordType.weight, p.id)));
      out.add({'beetle_id': code, 'metrics': GrowthMetrics.compute(w).toJson()});
    }
    return _result({'as_of': _now(), 'window_days': a['since_days'], 'comparison': out}, evidence);
  }

  Future<ToolResult> _temperatures(Map<String, Object?> a) async {
    String? beetleId;
    final code = a['beetle_id'];
    if (code != null) {
      beetleId = await data.beetleIdForCode('$code'.toUpperCase());
      if (beetleId == null) return _error('not_found', 'Beetle $code does not exist.');
    }
    final r = await data.temperatures(beetleId: beetleId, since: _since(a));
    final list = r.length > _maxRecords ? r.sublist(r.length - _maxRecords) : r;
    return _result({'as_of': _now(), 'unit': '°C', 'records': list},
        {for (final x in list) EvidenceRef(RecordType.temperature, x['id']! as String)});
  }

  Future<ToolResult> _proposeDraft(Map<String, Object?> a) async {
    return _withBeetle(a, (id, code) async {
      final title = a['title'], message = a['message'], reason = a['reason'];
      final delay = a['delay_days'];
      if (title is! String || title.isEmpty || title.runes.length > 80) {
        throw _ToolArgumentError('title must be 1-80 characters');
      }
      if (message is! String || message.runes.length > 500) {
        throw _ToolArgumentError('message must be at most 500 characters');
      }
      if (delay is! int || delay < 0 || delay > 365) {
        throw _ToolArgumentError('delay_days must be an integer 0-365');
      }
      return ToolResult(
        jsonEncode({
          'status': 'draft_recorded_pending_user_confirmation',
          'note': 'Nothing was scheduled. The keeper will review this draft.',
        }),
        draft: ReminderDraft(
          beetleCode: code,
          title: title,
          message: message,
          delayDays: delay,
          reason: reason is String ? reason : '',
        ),
      );
    });
  }

  Future<ToolResult> _withBeetle(
      Map<String, Object?> a, Future<ToolResult> Function(String id, String code) body) async {
    final raw = a['beetle_id'];
    if (raw is! String || raw.isEmpty) throw _ToolArgumentError('beetle_id is required');
    final code = raw.toUpperCase().trim();
    final id = await data.beetleIdForCode(code);
    if (id == null) return _error('not_found', 'Beetle $code does not exist in the records.');
    return body(id, code);
  }

  ToolResult _records(String code, List<Map<String, Object?>> r, RecordType type) {
    final list = r.length > _maxRecords ? r.sublist(r.length - _maxRecords) : r;
    return _result({'as_of': _now(), 'beetle_id': code, 'records': list},
        {for (final x in list) EvidenceRef(type, x['id']! as String)});
  }

  DateTime? _since(Map<String, Object?> a) {
    final d = a['since_days'];
    if (d == null) return null;
    final days = d is int ? d : (d is num ? d.toInt() : int.tryParse('$d'));
    if (days == null || days < 1 || days > 3650) {
      throw _ToolArgumentError('since_days must be an integer 1-3650');
    }
    return _clock().toUtc().subtract(Duration(days: days));
  }

  String _now() => _iso(_clock());
  static String _iso(DateTime d) => d.toUtc().toIso8601String();

  ToolResult _result(Map<String, Object?> json, Set<EvidenceRef> evidence) =>
      ToolResult(jsonEncode(json), evidence: evidence);

  ToolResult _error(String code, String message) =>
      ToolResult(jsonEncode({'error': code, 'message': message}));
}

class _ToolArgumentError implements Exception {
  _ToolArgumentError(this.message);
  final String message;
}
