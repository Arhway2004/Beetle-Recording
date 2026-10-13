import '../models/enums.dart';

/// A care suggestion as defined by
/// `packages/api-contracts/schemas/ai-suggestion.v1.schema.json`.
///
/// Instances can only be obtained through [CareSuggestionValidator.validate]
/// (for untrusted input) or constructed by the deterministic rule engine.
class CareSuggestion {
  const CareSuggestion({
    required this.beetleCode,
    required this.eventType,
    required this.severity,
    required this.confidence,
    required this.basis,
    required this.evidenceRecordIds,
    required this.reason,
    required this.recommendation,
    required this.reminder,
  });

  final String? beetleCode;
  final CareEventType eventType;
  final Severity severity;
  final Confidence confidence;
  final SuggestionBasis? basis;
  final List<String> evidenceRecordIds;
  final String reason;
  final String recommendation;
  final SuggestedReminder? reminder;

  /// Always true; kept explicit so serialized suggestions round-trip the schema.
  bool get requiresUserConfirmation => true;

  Map<String, Object?> toJson() => {
        'beetle_id': beetleCode,
        'event_type': eventType.wire,
        'severity': severity.name,
        'confidence': confidence.name,
        if (basis != null) 'basis': basis!.wire,
        'evidence_record_ids': evidenceRecordIds,
        'reason': reason,
        'recommendation': recommendation,
        'suggested_reminder': reminder?.toJson(),
        'requires_user_confirmation': true,
      };
}

class SuggestedReminder {
  const SuggestedReminder({
    required this.enabled,
    required this.delayDays,
    required this.title,
    required this.message,
  });

  final bool enabled;
  final int delayDays;
  final String title;
  final String message;

  Map<String, Object?> toJson() =>
      {'enabled': enabled, 'delay_days': delayDays, 'title': title, 'message': message};
}

class ValidationResult<T> {
  const ValidationResult._(this.value, this.errors);
  const ValidationResult.ok(T value) : this._(value, const []);
  const ValidationResult.invalid(List<String> errors) : this._(null, errors);

  final T? value;
  final List<String> errors;
  bool get isValid => errors.isEmpty && value != null;
}

/// Strict validator mirroring the JSON schema. Unknown fields, wrong types,
/// missing evidence, or `requires_user_confirmation != true` are all rejected,
/// so no action can ever be derived from malformed model output.
class CareSuggestionValidator {
  const CareSuggestionValidator();

  static final _beetleId = RegExp(r'^[A-Z][A-Z0-9]{1,7}-[0-9]{3,6}$');
  static const _topKeys = {
    'beetle_id',
    'event_type',
    'severity',
    'confidence',
    'basis',
    'evidence_record_ids',
    'reason',
    'recommendation',
    'suggested_reminder',
    'requires_user_confirmation',
  };
  static const _required = {
    'beetle_id',
    'event_type',
    'severity',
    'confidence',
    'evidence_record_ids',
    'reason',
    'recommendation',
    'suggested_reminder',
    'requires_user_confirmation',
  };
  static const _reminderKeys = {'enabled', 'delay_days', 'title', 'message'};

  ValidationResult<CareSuggestion> validate(Object? input) {
    final errors = <String>[];
    if (input is! Map) return const ValidationResult.invalid(['root: expected object']);
    final map = input.cast<Object?, Object?>();

    for (final k in map.keys) {
      if (!_topKeys.contains(k)) errors.add('$k: unknown field');
    }
    for (final k in _required) {
      if (!map.containsKey(k)) errors.add('$k: required');
    }

    final beetleId = map['beetle_id'];
    if (map.containsKey('beetle_id') && beetleId != null) {
      if (beetleId is! String || !_beetleId.hasMatch(beetleId)) {
        errors.add('beetle_id: invalid format');
      }
    }

    final eventType = _enumField(map, 'event_type', CareEventType.fromWire, errors);
    if (eventType == CareEventType.custom) errors.add('event_type: not allowed');
    final severity = _enumField(map, 'severity', _byName(Severity.values), errors);
    final confidence = _enumField(map, 'confidence', _byName(Confidence.values), errors);
    SuggestionBasis? basis;
    if (map.containsKey('basis')) {
      basis = _enumField(map, 'basis', SuggestionBasis.fromWire, errors);
    }

    final evidence = <String>[];
    final rawEvidence = map['evidence_record_ids'];
    if (map.containsKey('evidence_record_ids')) {
      if (rawEvidence is! List) {
        errors.add('evidence_record_ids: expected array');
      } else {
        if (rawEvidence.isEmpty) errors.add('evidence_record_ids: at least one required');
        if (rawEvidence.length > 50) errors.add('evidence_record_ids: too many');
        for (final e in rawEvidence) {
          if (e is! String || e.isEmpty || _len(e) > 64) {
            errors.add('evidence_record_ids: invalid item');
          } else {
            evidence.add(e);
          }
        }
        if (evidence.toSet().length != evidence.length) {
          errors.add('evidence_record_ids: items must be unique');
        }
      }
    }

    final reason = _stringField(map, 'reason', 1, 1000, errors);
    final recommendation = _stringField(map, 'recommendation', 1, 1000, errors);

    SuggestedReminder? reminder;
    final rawReminder = map['suggested_reminder'];
    if (rawReminder != null) {
      if (rawReminder is! Map) {
        errors.add('suggested_reminder: expected object or null');
      } else {
        final r = rawReminder.cast<Object?, Object?>();
        for (final k in r.keys) {
          if (!_reminderKeys.contains(k)) errors.add('suggested_reminder.$k: unknown field');
        }
        for (final k in _reminderKeys) {
          if (!r.containsKey(k)) errors.add('suggested_reminder.$k: required');
        }
        final enabled = r['enabled'];
        if (r.containsKey('enabled') && enabled is! bool) {
          errors.add('suggested_reminder.enabled: expected boolean');
        }
        final delay = _asInteger(r['delay_days']);
        if (r.containsKey('delay_days') && (delay == null || delay < 0 || delay > 365)) {
          errors.add('suggested_reminder.delay_days: expected integer 0..365');
        }
        final title = _stringField(r, 'title', 1, 80, errors, prefix: 'suggested_reminder.');
        final message =
            _stringField(r, 'message', 1, 500, errors, prefix: 'suggested_reminder.');
        if (enabled is bool && delay != null && title != null && message != null) {
          reminder =
              SuggestedReminder(enabled: enabled, delayDays: delay, title: title, message: message);
        }
      }
    }

    if (map.containsKey('requires_user_confirmation') &&
        map['requires_user_confirmation'] != true) {
      errors.add('requires_user_confirmation: must be true');
    }

    if (errors.isNotEmpty) return ValidationResult.invalid(errors);
    return ValidationResult.ok(CareSuggestion(
      beetleCode: beetleId as String?,
      eventType: eventType!,
      severity: severity!,
      confidence: confidence!,
      basis: basis,
      evidenceRecordIds: List.unmodifiable(evidence),
      reason: reason!,
      recommendation: recommendation!,
      reminder: reminder,
    ));
  }

  /// Validates `{"schema_version": "1", "suggestions": [...]}`. Invalid items are
  /// dropped individually and reported, valid ones are returned.
  ({List<CareSuggestion> valid, List<String> errors}) validateBatch(Object? input) {
    if (input is! Map) return (valid: const [], errors: const ['root: expected object']);
    final errors = <String>[];
    for (final k in input.keys) {
      if (k != 'schema_version' && k != 'suggestions') errors.add('$k: unknown field');
    }
    if (input['schema_version'] != '1') errors.add('schema_version: must be "1"');
    final list = input['suggestions'];
    if (list is! List) {
      errors.add('suggestions: expected array');
      return (valid: const [], errors: errors);
    }
    if (list.length > 10) errors.add('suggestions: too many');
    if (errors.isNotEmpty) return (valid: const [], errors: errors);
    final valid = <CareSuggestion>[];
    for (var i = 0; i < list.length; i++) {
      final r = validate(list[i]);
      if (r.isValid) {
        valid.add(r.value!);
      } else {
        errors.addAll(r.errors.map((e) => 'suggestions[$i].$e'));
      }
    }
    return (valid: valid, errors: errors);
  }

  static T? Function(String?) _byName<T extends Enum>(List<T> values) => (v) {
        for (final e in values) {
          if (e.name == v) return e;
        }
        return null;
      };

  static T? _enumField<T>(
      Map<Object?, Object?> m, String key, T? Function(String?) parse, List<String> errors) {
    if (!m.containsKey(key)) return null;
    final raw = m[key];
    final value = raw is String ? parse(raw) : null;
    if (value == null) errors.add('$key: invalid value');
    return value;
  }

  static String? _stringField(
      Map<Object?, Object?> m, String key, int min, int max, List<String> errors,
      {String prefix = ''}) {
    if (!m.containsKey(key)) return null;
    final raw = m[key];
    if (raw is! String) {
      errors.add('$prefix$key: expected string');
      return null;
    }
    final len = _len(raw);
    if (len < min || len > max) {
      errors.add('$prefix$key: length must be $min..$max');
      return null;
    }
    return raw;
  }

  /// JSON Schema string length counts code points, not UTF-16 units.
  static int _len(String s) => s.runes.length;

  /// JSON Schema "integer" accepts numbers with a zero fractional part.
  static int? _asInteger(Object? v) {
    if (v is int) return v;
    if (v is double && v.isFinite && v == v.truncateToDouble()) return v.toInt();
    return null;
  }
}
