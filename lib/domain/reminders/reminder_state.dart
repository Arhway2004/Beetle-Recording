import '../models/enums.dart';

/// Reminder lifecycle.
///
/// ```
/// suggested ──accept──▶ confirmed ──OS scheduled──▶ scheduled ──▶ completed
///     │                    │  ▲                         │
///     └─reject─▶ cancelled ◀┘  └──unscheduled (cap/perm)─┘
/// any open state ──past grace period──▶ expired
/// ```
/// Only `confirmed` reminders may become `scheduled`; `suggested` reminders are
/// never handed to the OS.
class ReminderStateMachine {
  const ReminderStateMachine._();

  static const _transitions = <ReminderStatus, Set<ReminderStatus>>{
    ReminderStatus.suggested: {
      ReminderStatus.confirmed,
      ReminderStatus.cancelled,
      ReminderStatus.expired,
    },
    ReminderStatus.confirmed: {
      ReminderStatus.scheduled,
      ReminderStatus.completed,
      ReminderStatus.cancelled,
      ReminderStatus.expired,
    },
    ReminderStatus.scheduled: {
      ReminderStatus.confirmed,
      ReminderStatus.completed,
      ReminderStatus.cancelled,
      ReminderStatus.expired,
    },
    ReminderStatus.completed: {},
    ReminderStatus.cancelled: {},
    ReminderStatus.expired: {},
  };

  static bool canTransition(ReminderStatus from, ReminderStatus to) =>
      _transitions[from]!.contains(to);

  static bool isOpen(ReminderStatus s) =>
      s == ReminderStatus.suggested ||
      s == ReminderStatus.confirmed ||
      s == ReminderStatus.scheduled;

  static bool canPostpone(ReminderStatus s) => isOpen(s);

  /// States in which a reminder may be handed to the OS notification scheduler.
  static bool isSchedulable(ReminderStatus s) =>
      s == ReminderStatus.confirmed || s == ReminderStatus.scheduled;
}

class InvalidReminderTransition implements Exception {
  InvalidReminderTransition(this.from, this.to);
  final ReminderStatus from;
  final ReminderStatus to;

  @override
  String toString() => 'Invalid reminder transition ${from.name} → ${to.name}';
}

/// Builds the key that identifies "the same beetle, event and observation
/// period". The anchor is the record that triggered the suggestion (e.g. the
/// latest weight record), so new evidence produces a new period.
String buildDedupeKey({
  required String? beetleId,
  required String? sensorId,
  required CareEventType eventType,
  required String anchor,
}) =>
    '${beetleId ?? '-'}|${sensorId ?? '-'}|${eventType.wire}|$anchor';

/// True when two optional periods overlap (null end = open-ended).
bool periodsOverlap(DateTime aStart, DateTime? aEnd, DateTime bStart, DateTime? bEnd) {
  final aE = aEnd ?? aStart;
  final bE = bEnd ?? bStart;
  return !aE.isBefore(bStart) && !bE.isBefore(aStart);
}
