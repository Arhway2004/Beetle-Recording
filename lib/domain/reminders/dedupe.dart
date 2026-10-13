import '../models/enums.dart';
import 'reminder_state.dart';

/// Minimal view of an existing reminder for duplicate detection.
class ExistingReminder {
  const ExistingReminder({
    required this.id,
    required this.beetleId,
    required this.sensorId,
    required this.eventType,
    required this.status,
    required this.dedupeKey,
    required this.periodStart,
    required this.periodEnd,
    required this.dueAt,
    required this.createdAt,
  });

  final String id;
  final String? beetleId;
  final String? sensorId;
  final String eventType;
  final ReminderStatus status;
  final String? dedupeKey;
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final DateTime dueAt;
  final DateTime createdAt;
}

class Suppression {
  const Suppression({required this.beetleId, required this.eventType, required this.until});
  final String? beetleId;
  final String eventType;
  final DateTime? until;

  bool matches(String? beetleId, String eventType, DateTime now) =>
      this.eventType == eventType &&
      (this.beetleId == null || this.beetleId == beetleId) &&
      (until == null || until!.isAfter(now));
}

/// Why a candidate suggestion was not stored.
enum DuplicateReason { sameKey, suppressed, overlappingOpenReminder }

/// Returns null when the candidate is new, otherwise why it is a duplicate.
///
/// * Same dedupe key in *any* status (including a rejected suggestion) → skip,
///   so rejecting a suggestion is respected for that observation period.
/// * The user disabled similar suggestions → skip.
/// * An open reminder for the same beetle/sensor and event overlaps the period → skip.
DuplicateReason? findDuplicate({
  required String? beetleId,
  required String? sensorId,
  required CareEventType eventType,
  required String dedupeKey,
  required DateTime periodStart,
  required DateTime? periodEnd,
  required List<ExistingReminder> existing,
  required List<Suppression> suppressions,
  required DateTime now,
}) {
  if (existing.any((r) => r.dedupeKey == dedupeKey)) return DuplicateReason.sameKey;
  if (suppressions.any((s) => s.matches(beetleId, eventType.wire, now))) {
    return DuplicateReason.suppressed;
  }
  final overlap = existing.any((r) =>
      ReminderStateMachine.isOpen(r.status) &&
      r.eventType == eventType.wire &&
      r.beetleId == beetleId &&
      r.sensorId == sensorId &&
      periodsOverlap(r.periodStart ?? r.dueAt, r.periodEnd, periodStart, periodEnd));
  return overlap ? DuplicateReason.overlappingOpenReminder : null;
}

/// IDs of reminders that should become `expired`:
/// * suggestions nobody acted on within [suggestionExpiryDays];
/// * confirmed/scheduled reminders more than [overdueGraceDays] past due.
List<String> findExpired(
  List<ExistingReminder> reminders, {
  required DateTime now,
  required int suggestionExpiryDays,
  required int overdueGraceDays,
}) =>
    [
      for (final r in reminders)
        if ((r.status == ReminderStatus.suggested &&
                now.difference(r.createdAt).inDays >= suggestionExpiryDays) ||
            (ReminderStateMachine.isSchedulable(r.status) &&
                now.difference(r.dueAt).inDays >= overdueGraceDays))
          r.id,
    ];
