import 'package:beetle_keeper/domain/growth/growth_metrics.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/domain/proactive/care_rules.dart';
import 'package:beetle_keeper/domain/reminders/dedupe.dart';
import 'package:beetle_keeper/domain/reminders/reminder_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  final now = DateTime.utc(2026, 10, 1, 12);
  final engine = CareRuleEngine(const CareRuleSettings(), FakeCareTexts());

  BeetleCareSnapshot beetle({
    LifeStage? stage = LifeStage.l3,
    List<WeightPoint> weights = const [],
    List<ObservationSnap> obs = const [],
    SubstrateSnap? substrate,
    BeetleStatus status = BeetleStatus.active,
    DateTime? stageAt,
    int? pupaMin,
    int? pupaMax,
  }) =>
      BeetleCareSnapshot(
        beetleId: 'b1',
        code: 'CCK-001',
        status: status,
        createdAt: now.subtract(const Duration(days: 5)),
        stage: stage,
        stageEventId: 'ls1',
        stageAt: stageAt,
        weights: weights,
        observations: obs,
        latestSubstrate: substrate,
        expectedPupaDaysMin: pupaMin,
        expectedPupaDaysMax: pupaMax,
      );

  WeightPoint w(String id, int daysAgo, double g) =>
      WeightPoint(id: id, measuredAt: now.subtract(Duration(days: daysAgo)), grams: g);

  group('state machine', () {
    test('only confirmed/scheduled are schedulable; suggestions are not', () {
      expect(ReminderStateMachine.isSchedulable(ReminderStatus.suggested), isFalse);
      expect(ReminderStateMachine.isSchedulable(ReminderStatus.confirmed), isTrue);
      expect(ReminderStateMachine.canTransition(ReminderStatus.suggested, ReminderStatus.scheduled), isFalse);
      expect(ReminderStateMachine.canTransition(ReminderStatus.suggested, ReminderStatus.confirmed), isTrue);
      expect(ReminderStateMachine.canTransition(ReminderStatus.completed, ReminderStatus.confirmed), isFalse);
    });
  });

  group('rule engine', () {
    test('weight loss beyond threshold → warning, calculated, evidence = last two weights', () {
      final out = engine.evaluate(
          beetles: [beetle(weights: [w('w1', 20, 42), w('w2', 1, 37)])], sensors: const [], now: now);
      final s = out.singleWhere((r) => r.suggestion.eventType == CareEventType.weightLoss);
      expect(s.suggestion.severity, Severity.warning);
      expect(s.suggestion.basis, SuggestionBasis.calculated);
      expect(s.suggestion.evidenceRecordIds, ['w1', 'w2']);
      expect(s.suggestion.requiresUserConfirmation, isTrue);
    });

    test('small change does not trigger', () {
      final out = engine.evaluate(
          beetles: [beetle(weights: [w('w1', 10, 40), w('w2', 1, 41)])], sensors: const [], now: now);
      expect(out.where((r) => r.suggestion.eventType.wire.contains('weight')), isEmpty);
    });

    test('measurement overdue only for larvae (never prompts weighing a pupa)', () {
      final larva = engine.evaluate(beetles: [beetle(weights: [w('w1', 45, 30)])], sensors: const [], now: now);
      expect(larva.map((r) => r.suggestion.eventType), contains(CareEventType.measurementOverdue));
      final pupa = engine.evaluate(
          beetles: [beetle(stage: LifeStage.pupa, weights: [w('w1', 45, 30)])], sensors: const [], now: now);
      expect(pupa.map((r) => r.suggestion.eventType), isNot(contains(CareEventType.measurementOverdue)));
    });

    test('inactive beetles produce nothing', () {
      final out = engine.evaluate(
          beetles: [beetle(status: BeetleStatus.deceased, weights: [w('w1', 45, 30)])], sensors: const [], now: now);
      expect(out, isEmpty);
    });

    test('possible prepupa is low confidence observation with observation evidence', () {
      final out = engine.evaluate(beetles: [
        beetle(weights: [w('w1', 2, 30)], obs: [
          ObservationSnap(id: 'o1', observedAt: now.subtract(const Duration(days: 2)), category: ObservationCategory.colorChange),
        ]),
      ], sensors: const [], now: now);
      final s = out.singleWhere((r) => r.suggestion.eventType == CareEventType.possiblePrepupa);
      expect(s.suggestion.confidence, Confidence.low);
      expect(s.suggestion.evidenceRecordIds, ['o1']);
      expect(s.dueAt, now.add(const Duration(days: 3)));
    });

    test('substrate next planned date within lead time', () {
      final out = engine.evaluate(beetles: [
        beetle(
            weights: [w('w1', 1, 30)],
            substrate: SubstrateSnap(id: 's1', changedAt: now.subtract(const Duration(days: 60)), nextPlannedAt: now.add(const Duration(days: 1)))),
      ], sensors: const [], now: now);
      expect(out.single.suggestion.eventType, CareEventType.substrateInspection);
      expect(out.single.dueAt, now.add(const Duration(days: 1)));
    });

    test('emergence window only when user configured pupal duration', () {
      final none = engine.evaluate(
          beetles: [beetle(stage: LifeStage.pupa, stageAt: now.subtract(const Duration(days: 10)))],
          sensors: const [], now: now);
      expect(none, isEmpty);
      final some = engine.evaluate(beetles: [
        beetle(stage: LifeStage.pupa, stageAt: now.subtract(const Duration(days: 10)), pupaMin: 30, pupaMax: 45),
      ], sensors: const [], now: now);
      expect(some.single.suggestion.eventType, CareEventType.expectedEmergenceWindow);
      expect(some.single.periodEnd, now.subtract(const Duration(days: 10)).add(const Duration(days: 45)));
    });

    test('temperature: only user thresholds, labelled measured', () {
      final noThreshold = engine.evaluate(beetles: const [], sensors: [
        SensorCareSnapshot(sensorId: 't', name: 'Room', latestRecordId: 'r1', latestAt: now, latestC: 35),
      ], now: now);
      expect(noThreshold, isEmpty);
      final out = engine.evaluate(beetles: const [], sensors: [
        SensorCareSnapshot(sensorId: 't', name: 'Room', maxC: 26, latestRecordId: 'r1', latestAt: now, latestC: 29.5),
      ], now: now);
      expect(out.single.suggestion.basis, SuggestionBasis.measured);
      expect(out.single.suggestion.severity, Severity.alert);
      expect(out.single.suggestion.beetleCode, isNull);
    });
  });

  group('dedupe', () {
    ExistingReminder existing({
      String key = 'k',
      ReminderStatus status = ReminderStatus.suggested,
      String event = 'weight_loss',
      DateTime? start,
    }) =>
        ExistingReminder(
          id: 'r',
          beetleId: 'b1',
          sensorId: null,
          eventType: event,
          status: status,
          dedupeKey: key,
          periodStart: start ?? now,
          periodEnd: null,
          dueAt: start ?? now,
          createdAt: now,
        );

    DuplicateReason? check(List<ExistingReminder> e, {List<Suppression> s = const [], String key = 'new'}) =>
        findDuplicate(
          beetleId: 'b1',
          sensorId: null,
          eventType: CareEventType.weightLoss,
          dedupeKey: key,
          periodStart: now,
          periodEnd: null,
          existing: e,
          suppressions: s,
          now: now,
        );

    test('same key in any state (even rejected) is a duplicate', () {
      expect(check([existing(status: ReminderStatus.cancelled)], key: 'k'), DuplicateReason.sameKey);
    });

    test('overlapping open reminder for same beetle+event is a duplicate', () {
      expect(check([existing(key: 'other')]), DuplicateReason.overlappingOpenReminder);
      expect(check([existing(key: 'other', status: ReminderStatus.completed)]), isNull);
      expect(check([existing(key: 'other', start: now.add(const Duration(days: 9)))]), isNull);
    });

    test('suppression blocks, expired suppression does not', () {
      expect(check([], s: [const Suppression(beetleId: null, eventType: 'weight_loss', until: null)]),
          DuplicateReason.suppressed);
      expect(check([], s: [Suppression(beetleId: 'b1', eventType: 'weight_loss', until: now.subtract(const Duration(days: 1)))]),
          isNull);
    });

    test('expiry of stale suggestions and overdue reminders', () {
      final ids = findExpired([
        ExistingReminder(id: 'old-suggestion', beetleId: null, sensorId: null, eventType: 'x', status: ReminderStatus.suggested,
            dedupeKey: null, periodStart: null, periodEnd: null, dueAt: now, createdAt: now.subtract(const Duration(days: 20))),
        ExistingReminder(id: 'overdue', beetleId: null, sensorId: null, eventType: 'x', status: ReminderStatus.scheduled,
            dedupeKey: null, periodStart: null, periodEnd: null, dueAt: now.subtract(const Duration(days: 8)), createdAt: now),
        ExistingReminder(id: 'fresh', beetleId: null, sensorId: null, eventType: 'x', status: ReminderStatus.confirmed,
            dedupeKey: null, periodStart: null, periodEnd: null, dueAt: now.subtract(const Duration(days: 1)), createdAt: now),
      ], now: now, suggestionExpiryDays: 14, overdueGraceDays: 7);
      expect(ids, ['old-suggestion', 'overdue']);
    });
  });
}
