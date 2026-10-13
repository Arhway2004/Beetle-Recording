import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/ai/care_suggestion.dart';
import '../../domain/models/enums.dart';
import '../../domain/reminders/dedupe.dart';
import '../../domain/reminders/reminder_state.dart';
import '../database/app_database.dart';

/// A suggestion ready to be stored, from the rule engine or a validated AI result.
class SuggestionToStore {
  const SuggestionToStore({
    required this.suggestion,
    required this.source,
    required this.beetleId,
    required this.sensorId,
    required this.dueAt,
    required this.periodStart,
    required this.periodEnd,
    required this.dedupeKey,
    required this.evidence,
    this.analysisId,
  });

  final CareSuggestion suggestion;
  final ReminderSource source;
  final String? beetleId;
  final String? sensorId;
  final DateTime dueAt;
  final DateTime periodStart;
  final DateTime? periodEnd;
  final String dedupeKey;
  final List<(RecordType, String)> evidence;
  final String? analysisId;
}

class ReminderRepository {
  ReminderRepository(this.db);
  final AppDatabase db;

  Stream<List<ReminderRow>> watchByStatus(Set<ReminderStatus> statuses) =>
      (db.select(db.reminders)
            ..where((r) => r.deletedAt.isNull() & r.status.isIn(statuses.map((s) => s.name)))
            ..orderBy([(r) => OrderingTerm(expression: r.dueAt)]))
          .watch();

  Stream<List<ReminderRow>> watchForBeetle(String beetleId) => (db.select(db.reminders)
        ..where((r) => r.deletedAt.isNull() & r.beetleId.equals(beetleId))
        ..orderBy([(r) => OrderingTerm.desc(r.dueAt)]))
      .watch();

  Future<ReminderRow> byId(String id) =>
      (db.select(db.reminders)..where((r) => r.id.equals(id))).getSingle();

  Future<List<ReminderRow>> schedulable() => (db.select(db.reminders)
        ..where((r) =>
            r.deletedAt.isNull() &
            r.status.isIn([ReminderStatus.confirmed.name, ReminderStatus.scheduled.name]))
        ..orderBy([(r) => OrderingTerm(expression: r.dueAt)]))
      .get();

  Future<List<EvidenceReferenceRow>> evidenceFor(String reminderId) =>
      (db.select(db.evidenceReferences)
            ..where((e) => e.reminderId.equals(reminderId) & e.deletedAt.isNull()))
          .get();

  Future<List<ExistingReminder>> existingForDedupe() async {
    final rows = await (db.select(db.reminders)..where((r) => r.deletedAt.isNull())).get();
    return rows.map(_toExisting).toList();
  }

  Future<List<Suppression>> suppressions() async {
    final rows =
        await (db.select(db.suggestionSuppressions)..where((s) => s.deletedAt.isNull())).get();
    return rows
        .map((s) => Suppression(beetleId: s.beetleId, eventType: s.eventType, until: s.until))
        .toList();
  }

  Stream<List<SuggestionSuppressionRow>> watchSuppressions() =>
      (db.select(db.suggestionSuppressions)..where((s) => s.deletedAt.isNull())).watch();

  Future<void> removeSuppression(String id) async {
    await (db.update(db.suggestionSuppressions)..where((s) => s.id.equals(id)))
        .write(SuggestionSuppressionsCompanion(deletedAt: Value(nowUtc()), updatedAt: Value(nowUtc())));
  }

  /// A reminder the user authored (or an AI draft the user reviewed and
  /// confirmed) is stored directly as `confirmed`.
  Future<String> createUserReminder({
    String? beetleId,
    required String title,
    required String message,
    required DateTime dueAt,
    ReminderSource source = ReminderSource.user,
    String? reason,
  }) async {
    final id = newId();
    await db.into(db.reminders).insert(RemindersCompanion.insert(
          id: Value(id),
          beetleId: Value(beetleId),
          eventType: CareEventType.custom.wire,
          title: title.trim(),
          message: message.trim(),
          dueAt: dueAt.toUtc(),
          status: ReminderStatus.confirmed,
          source: source,
          basis: Value(source == ReminderSource.ai ? SuggestionBasis.aiInference.wire : null),
          reason: Value(reason),
          periodStart: Value(dueAt.toUtc()),
          notificationId: Value(notificationIdFor(id)),
        ));
    return id;
  }

  /// Stores a suggestion in the `suggested` state unless it duplicates an
  /// existing reminder/period or the user suppressed similar suggestions.
  /// Returns the new reminder id, or null when skipped.
  Future<String?> insertSuggestion(SuggestionToStore s, {DateTime? now}) {
    return db.transaction(() async {
      final at = now ?? nowUtc();
      final dup = findDuplicate(
        beetleId: s.beetleId,
        sensorId: s.sensorId,
        eventType: s.suggestion.eventType,
        dedupeKey: s.dedupeKey,
        periodStart: s.periodStart,
        periodEnd: s.periodEnd,
        existing: await existingForDedupe(),
        suppressions: await suppressions(),
        now: at,
      );
      if (dup != null) return null;
      final reminder = s.suggestion.reminder;
      final id = newId();
      await db.into(db.reminders).insert(RemindersCompanion.insert(
            id: Value(id),
            beetleId: Value(s.beetleId),
            sensorId: Value(s.sensorId),
            eventType: s.suggestion.eventType.wire,
            title: reminder?.title ?? s.suggestion.eventType.wire,
            message: reminder?.message ?? s.suggestion.recommendation,
            dueAt: s.dueAt.toUtc(),
            status: ReminderStatus.suggested,
            source: s.source,
            basis: Value(s.suggestion.basis?.wire),
            severity: Value(s.suggestion.severity),
            confidence: Value(s.suggestion.confidence),
            reason: Value(s.suggestion.reason),
            recommendation: Value(s.suggestion.recommendation),
            dedupeKey: Value(s.dedupeKey),
            periodStart: Value(s.periodStart.toUtc()),
            periodEnd: Value(s.periodEnd?.toUtc()),
            notificationId: Value(notificationIdFor(id)),
            analysisId: Value(s.analysisId),
          ));
      for (final (type, recordId) in s.evidence) {
        await db.into(db.evidenceReferences).insert(EvidenceReferencesCompanion.insert(
              reminderId: Value(id),
              recordType: type,
              recordId: recordId,
            ));
      }
      return id;
    });
  }

  /// Accept a suggestion (optionally with an edited date/title/message).
  Future<void> accept(String id, {DateTime? dueAt, String? title, String? message}) =>
      _transition(id, ReminderStatus.confirmed,
          extra: RemindersCompanion(
            dueAt: dueAt == null ? const Value.absent() : Value(dueAt.toUtc()),
            title: title == null ? const Value.absent() : Value(title.trim()),
            message: message == null ? const Value.absent() : Value(message.trim()),
          ));

  Future<void> reject(String id) => _transition(id, ReminderStatus.cancelled);

  Future<void> cancel(String id) => _transition(id, ReminderStatus.cancelled);

  Future<void> complete(String id) => _transition(id, ReminderStatus.completed,
      extra: RemindersCompanion(completedAt: Value(nowUtc())));

  Future<void> markScheduled(String id) => _transition(id, ReminderStatus.scheduled);

  /// Back to confirmed (e.g. outside the OS pending-notification window or
  /// notification permission revoked). Not an error.
  Future<void> markUnscheduled(String id) => _transition(id, ReminderStatus.confirmed);

  Future<void> expire(Iterable<String> ids) async {
    for (final id in ids) {
      await _transition(id, ReminderStatus.expired);
    }
  }

  /// Moves the due date. A scheduled reminder returns to `confirmed` so the
  /// scheduler re-registers it with the new time.
  Future<void> postpone(String id, DateTime newDueAt) async {
    await db.transaction(() async {
      final r = await byId(id);
      if (!ReminderStateMachine.canPostpone(r.status)) {
        throw InvalidReminderTransition(r.status, r.status);
      }
      await (db.update(db.reminders)..where((x) => x.id.equals(id))).write(RemindersCompanion(
        dueAt: Value(newDueAt.toUtc()),
        status: Value(r.status == ReminderStatus.scheduled ? ReminderStatus.confirmed : r.status),
        postponedCount: Value(r.postponedCount + 1),
        updatedAt: Value(nowUtc()),
        revision: Value(r.revision + 1),
      ));
    });
  }

  /// Rejects this suggestion and stops similar ones (same event type, same
  /// beetle when [onlyThisBeetle]) until [until] (null = indefinitely).
  Future<void> disableSimilar(String id, {bool onlyThisBeetle = true, DateTime? until}) async {
    await db.transaction(() async {
      final r = await byId(id);
      await db.into(db.suggestionSuppressions).insert(SuggestionSuppressionsCompanion.insert(
            beetleId: Value(onlyThisBeetle ? r.beetleId : null),
            eventType: r.eventType,
            until: Value(until?.toUtc()),
          ));
      if (r.status == ReminderStatus.suggested) await reject(id);
    });
  }

  Future<void> _transition(String id, ReminderStatus to,
      {RemindersCompanion extra = const RemindersCompanion()}) async {
    await db.transaction(() async {
      final r = await byId(id);
      if (r.status == to) return;
      if (!ReminderStateMachine.canTransition(r.status, to)) {
        throw InvalidReminderTransition(r.status, to);
      }
      await (db.update(db.reminders)..where((x) => x.id.equals(id))).write(extra.copyWith(
        status: Value(to),
        updatedAt: Value(nowUtc()),
        revision: Value(r.revision + 1),
      ));
    });
  }

  static ExistingReminder _toExisting(ReminderRow r) => ExistingReminder(
        id: r.id,
        beetleId: r.beetleId,
        sensorId: r.sensorId,
        eventType: r.eventType,
        status: r.status,
        dedupeKey: r.dedupeKey,
        periodStart: r.periodStart,
        periodEnd: r.periodEnd,
        dueAt: r.dueAt,
        createdAt: r.createdAt,
      );
}
