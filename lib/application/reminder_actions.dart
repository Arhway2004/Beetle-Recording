import '../data/repositories/reminder_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../domain/models/enums.dart';
import '../infrastructure/notifications/notification_gateway.dart';
import '../infrastructure/notifications/reminder_scheduler.dart';

/// User-facing reminder operations. Every change re-syncs OS notifications.
class ReminderActions {
  ReminderActions(this.repo, this.scheduler, this.gateway, this.settings);

  final ReminderRepository repo;
  final ReminderScheduler scheduler;
  final NotificationGateway gateway;
  final SettingsRepository settings;

  /// Requests notification permission the first time the user commits to a
  /// reminder (contextual, never at launch).
  Future<void> _ensurePermissionAsked() async {
    if (await gateway.hasPermission()) return;
    if (await settings.get(SettingsKeys.notificationPermissionAsked) == 'true') return;
    await settings.set(SettingsKeys.notificationPermissionAsked, 'true');
    await gateway.requestPermission();
  }

  Future<ReconcileResult> accept(String id, {DateTime? dueAt, String? title, String? message}) async {
    await repo.accept(id, dueAt: dueAt, title: title, message: message);
    await _ensurePermissionAsked();
    return scheduler.reconcile();
  }

  Future<ReconcileResult> create({
    String? beetleId,
    required String title,
    required String message,
    required DateTime dueAt,
    ReminderSource source = ReminderSource.user,
    String? reason,
  }) async {
    await repo.createUserReminder(
        beetleId: beetleId, title: title, message: message, dueAt: dueAt, source: source, reason: reason);
    await _ensurePermissionAsked();
    return scheduler.reconcile();
  }

  Future<void> reject(String id) => repo.reject(id);

  Future<void> disableSimilar(String id, {bool onlyThisBeetle = true}) =>
      repo.disableSimilar(id, onlyThisBeetle: onlyThisBeetle);

  Future<ReconcileResult> postpone(String id, DateTime newDueAt) async {
    await repo.postpone(id, newDueAt);
    return scheduler.reconcile();
  }

  Future<void> complete(String id) async {
    final r = await repo.byId(id);
    await repo.complete(id);
    await scheduler.cancelFor(id, r.notificationId);
    await scheduler.reconcile();
  }

  Future<void> cancel(String id) async {
    final r = await repo.byId(id);
    await repo.cancel(id);
    await scheduler.cancelFor(id, r.notificationId);
    await scheduler.reconcile();
  }
}
