import 'package:beetle_keeper/domain/growth/growth_metrics.dart';
import 'package:beetle_keeper/domain/growth/growth_roadmap.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime d(int month, int day, [int hour = 12]) => DateTime.utc(2026, month, day, hour);

StageEventPoint ev(String id, DateTime at, LifeStage stage, {DateTime? created, L3Phase? phase, bool estimated = false}) =>
    StageEventPoint(id: id, occurredAt: at, createdAt: created ?? at, stage: stage, l3Phase: phase, isEstimated: estimated);

WeightPoint w(String id, DateTime at, double g) => WeightPoint(id: id, measuredAt: at, grams: g);

void main() {
  test('no records: no current stage, every stage not recorded, weights unattributed', () {
    final r = GrowthRoadmap.derive(events: const [], weights: [w('w1', d(1, 1), 10)]);
    expect(r.current, isNull);
    expect(r.stages.map((s) => s.status), everyElement(RoadmapStageStatus.notRecorded));
    expect(r.weightsBeforeFirstStage.map((x) => x.id), ['w1']);
  });

  test('beetle first entered at L3: earlier stages are not recorded, later ones upcoming', () {
    final r = GrowthRoadmap.derive(events: [ev('e1', d(3, 1), LifeStage.l3)], weights: const []);
    expect(r.current, LifeStage.l3);
    expect(r.of(LifeStage.l1).status, RoadmapStageStatus.notRecorded);
    expect(r.of(LifeStage.l2).status, RoadmapStageStatus.notRecorded);
    expect(r.of(LifeStage.l3).status, RoadmapStageStatus.current);
    expect(r.of(LifeStage.pupa).status, RoadmapStageStatus.upcoming);
    expect(r.of(LifeStage.l1).periods, isEmpty); // no invented dates
    expect(r.of(LifeStage.l3).periods.single.end, isNull); // ongoing
  });

  test('weights are grouped by the period containing their measurement time', () {
    final r = GrowthRoadmap.derive(
      events: [ev('a', d(1, 1), LifeStage.l2), ev('b', d(2, 1), LifeStage.l3)],
      weights: [
        w('before', d(1, 1, 11), 5), // before the first recorded stage
        w('l2', d(1, 15), 8),
        w('edge', d(2, 1), 12), // exactly at the transition → new period
        w('l3a', d(2, 20), 20),
        w('l3b', d(3, 10), 28),
      ],
    );
    final l2 = r.of(LifeStage.l2).periods.single;
    final l3 = r.of(LifeStage.l3).periods.single;
    expect(l2.weights.map((x) => x.id), ['l2']);
    expect(l2.end, d(2, 1)); // next record, not a confirmed completion
    expect(l3.weights.map((x) => x.id), ['edge', 'l3a', 'l3b']);
    expect(r.weightsBeforeFirstStage.map((x) => x.id), ['before']);
  });

  test('skipped intermediate stage is not recorded; L3 phases merge into one period', () {
    final r = GrowthRoadmap.derive(events: [
      ev('a', d(1, 1), LifeStage.l1),
      ev('b', d(3, 1), LifeStage.l3, phase: L3Phase.early),
      ev('c', d(5, 1), LifeStage.l3, phase: L3Phase.late),
      ev('d', d(7, 1), LifeStage.prepupa, estimated: true),
    ], weights: const []);
    expect(r.of(LifeStage.l2).status, RoadmapStageStatus.notRecorded);
    final l3 = r.of(LifeStage.l3).periods.single;
    expect(l3.eventIds, ['b', 'c']);
    expect(l3.l3Phases.map((p) => p.phase), [L3Phase.early, L3Phase.late]);
    expect(l3.end, d(7, 1));
    expect(r.of(LifeStage.prepupa).periods.single.startEstimated, isTrue);
    expect(r.current, LifeStage.prepupa);
  });

  test('backdated records are placed by observation time, not entry time', () {
    final r = GrowthRoadmap.derive(events: [
      ev('pupa', d(6, 1), LifeStage.pupa, created: d(6, 1)),
      ev('pre', d(5, 1), LifeStage.prepupa, created: d(6, 2)), // entered later, observed earlier
    ], weights: const []);
    expect(r.periods.map((p) => p.stage), [LifeStage.prepupa, LifeStage.pupa]);
    expect(r.current, LifeStage.pupa);
    expect(r.hasOutOfOrderHistory, isFalse);
  });

  test('same instant: the later-entered record wins, matching the repository', () {
    final r = GrowthRoadmap.derive(events: [
      ev('x', d(4, 1), LifeStage.l3, created: d(4, 1, 13)),
      ev('y', d(4, 1), LifeStage.l2, created: d(4, 1, 12)),
    ], weights: const []);
    expect(r.current, LifeStage.l3);
  });

  test('conflicting history is kept and flagged, never reordered', () {
    final r = GrowthRoadmap.derive(events: [
      ev('a', d(1, 1), LifeStage.l3),
      ev('b', d(2, 1), LifeStage.pupa),
      ev('c', d(3, 1), LifeStage.l3), // regression: needs the keeper's review
    ], weights: const []);
    expect(r.periods.map((p) => p.stage), [LifeStage.l3, LifeStage.pupa, LifeStage.l3]);
    expect(r.periods.map((p) => p.outOfOrder), [false, false, true]);
    expect(r.hasOutOfOrderHistory, isTrue);
    expect(r.current, LifeStage.l3);
    expect(r.of(LifeStage.pupa).status, RoadmapStageStatus.recorded);
    expect(r.of(LifeStage.l3).periods, hasLength(2));
  });

  test('deleting the latest event falls back to the previous stage', () {
    final events = [ev('a', d(1, 1), LifeStage.l3), ev('b', d(2, 1), LifeStage.prepupa)];
    final before = GrowthRoadmap.derive(events: events, weights: [w('w', d(2, 5), 30)]);
    final after = GrowthRoadmap.derive(events: events.sublist(0, 1), weights: [w('w', d(2, 5), 30)]);
    expect(before.current, LifeStage.prepupa);
    expect(after.current, LifeStage.l3);
    expect(after.of(LifeStage.l3).periods.single.weights.map((x) => x.id), ['w']);
  });
}
