import '../../core/utils/ids.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../domain/models/enums.dart';
import 'notification_gateway.dart';

class ReconcileResult {
  const ReconcileResult({
    required this.scheduled,
    required this.deferred,
    required this.permissionDenied,
    required this.exact,
  });
  final int scheduled;

  /// Confirmed reminders outside the OS pending window; scheduled later.
  final int deferred;
  final bool permissionDenied;
  final bool exact;
}

/// Keeps OS notifications in sync with confirmed reminders.
///
/// * Only `confirmed`/`scheduled` reminders are ever handed to the OS.
/// * iOS allows 64 pending local notifications; we keep the soonest
///   [maxPending] scheduled and re-run on every launch/resume.
/// * Scheduling uses absolute instants, so reminders fire at the right moment
///   after time-zone changes; Android reboots are handled by the plugin's
///   boot receiver, and reconcile re-registers anything missing.
/// * Works fully offline; the Mac is never involved.
class ReminderScheduler {
  ReminderScheduler(this.repo, this.gateway, {DateTime Function()? clock, this.maxPending = 60})
      : _clock = clock ?? DateTime.now;

  final ReminderRepository repo;
  final NotificationGateway gateway;
  final DateTime Function() _clock;
  final int maxPending;

  Future<ReconcileResult> reconcile() async {
    final now = _clock().toUtc();
    final all = await repo.schedulable();
    final future = all.where((r) => r.dueAt.isAfter(now)).toList();
    final window = future.take(maxPending).toList();
    final outside = future.skip(maxPending).toList();
    final windowIds = {for (final r in window) r.notificationId ?? notificationIdFor(r.id)};

    // Remove OS notifications that no longer correspond to an open reminder.
    for (final id in await gateway.pendingIds()) {
      if (!windowIds.contains(id)) await gateway.cancel(id);
    }

    if (!await gateway.hasPermission()) {
      for (final r in all.where((r) => r.status == ReminderStatus.scheduled && r.dueAt.isAfter(now))) {
        await repo.markUnscheduled(r.id);
      }
      for (final id in windowIds) {
        await gateway.cancel(id);
      }
      return ReconcileResult(
          scheduled: 0, deferred: future.length, permissionDenied: true, exact: false);
    }

    final exact = await gateway.canScheduleExact();
    for (final r in window) {
      await gateway.schedule(
        id: r.notificationId ?? notificationIdFor(r.id),
        title: r.title,
        body: r.message,
        at: r.dueAt,
        exact: exact,
        payload: r.id,
      );
      if (r.status != ReminderStatus.scheduled) await repo.markScheduled(r.id);
    }
    for (final r in outside.where((r) => r.status == ReminderStatus.scheduled)) {
      await gateway.cancel(r.notificationId ?? notificationIdFor(r.id));
      await repo.markUnscheduled(r.id);
    }
    return ReconcileResult(
        scheduled: window.length, deferred: outside.length, permissionDenied: false, exact: exact);
  }

  Future<void> cancelFor(String reminderId, int? notificationId) =>
      gateway.cancel(notificationId ?? notificationIdFor(reminderId));
}
