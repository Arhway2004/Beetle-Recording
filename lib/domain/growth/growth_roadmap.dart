import '../models/enums.dart';
import 'growth_metrics.dart';

/// One recorded life-stage event, as the roadmap needs it.
class StageEventPoint {
  const StageEventPoint({
    required this.id,
    required this.occurredAt,
    required this.createdAt,
    required this.stage,
    this.l3Phase,
    this.isEstimated = false,
  });

  final String id;

  /// When the keeper says the stage was observed (may be backdated).
  final DateTime occurredAt;

  /// When the record was entered; breaks ties between events at the same instant.
  final DateTime createdAt;
  final LifeStage stage;
  final L3Phase? l3Phase;
  final bool isEstimated;
}

enum RoadmapStageStatus {
  /// The latest recorded stage.
  current,

  /// Recorded at some point, not the latest.
  recorded,

  /// Comes before the current stage in the lifecycle but has no record.
  /// The roadmap never invents dates or completion for it.
  notRecorded,

  /// Comes after the current stage. Nothing is predicted.
  upcoming,
}

/// A continuous period that starts with an event of [stage] and lasts until the
/// next event of a different stage. Consecutive events of the same stage (for
/// example L3 early → L3 late) are merged into one period.
class StagePeriod {
  const StagePeriod({
    required this.stage,
    required this.start,
    required this.startEstimated,
    required this.end,
    required this.eventIds,
    required this.l3Phases,
    required this.weights,
    required this.outOfOrder,
  });

  final LifeStage stage;

  /// When the first event of this period was recorded.
  final DateTime start;
  final bool startEstimated;

  /// When the next period's first event was recorded, or null while ongoing.
  /// This is "the next record", not a confirmed completion date.
  final DateTime? end;
  final List<String> eventIds;

  /// L3 phase labels recorded inside this period, in order.
  final List<({L3Phase phase, DateTime at})> l3Phases;

  /// Weights measured at or after [start] and before [end].
  final List<WeightPoint> weights;

  /// True when this period's stage is earlier in the lifecycle than a period
  /// before it (e.g. pupa recorded, then L3 recorded later). Shown as
  /// "needs review"; nothing is reordered or discarded.
  final bool outOfOrder;
}

class RoadmapStage {
  const RoadmapStage({required this.stage, required this.status, required this.periods});
  final LifeStage stage;
  final RoadmapStageStatus status;
  final List<StagePeriod> periods;
}

class GrowthRoadmap {
  const GrowthRoadmap({
    required this.stages,
    required this.periods,
    required this.current,
    required this.weightsBeforeFirstStage,
  });

  /// Every lifecycle stage, in lifecycle order.
  final List<RoadmapStage> stages;

  /// All recorded periods, in chronological order.
  final List<StagePeriod> periods;

  /// The stage of the latest event (see [GrowthRoadmap.derive]).
  final LifeStage? current;

  /// Weights measured before the first recorded stage event. They are not
  /// attributed to any stage because the stage at that time is unknown.
  final List<WeightPoint> weightsBeforeFirstStage;

  bool get hasOutOfOrderHistory => periods.any((p) => p.outOfOrder);

  RoadmapStage of(LifeStage s) => stages.firstWhere((r) => r.stage == s);

  /// Builds the roadmap from live (non-deleted) records.
  ///
  /// Rules, deterministic and identical to the repository's "current stage":
  /// * Events are ordered by `occurredAt`, then `createdAt`, then `id`.
  /// * The current stage is the stage of the last event in that order.
  /// * A weight belongs to the period whose `[start, end)` contains its
  ///   `measuredAt`; a weight at exactly a transition instant belongs to the
  ///   new period. Weights are never presented as "the weight at transition".
  /// * Stages before the current one without any event are `notRecorded`;
  ///   stages after it are `upcoming`. No dates are inferred for either.
  static GrowthRoadmap derive({required List<StageEventPoint> events, required List<WeightPoint> weights}) {
    final sortedEvents = [...events]..sort((a, b) {
        final t = a.occurredAt.compareTo(b.occurredAt);
        if (t != 0) return t;
        final c = a.createdAt.compareTo(b.createdAt);
        return c != 0 ? c : a.id.compareTo(b.id);
      });
    final sortedWeights = [...weights]..sort((a, b) {
        final t = a.measuredAt.compareTo(b.measuredAt);
        return t != 0 ? t : a.id.compareTo(b.id);
      });

    // Group consecutive same-stage events into periods.
    final groups = <List<StageEventPoint>>[];
    for (final e in sortedEvents) {
      if (groups.isNotEmpty && groups.last.first.stage == e.stage) {
        groups.last.add(e);
      } else {
        groups.add([e]);
      }
    }

    final periods = <StagePeriod>[];
    var furthest = -1;
    for (final (i, g) in groups.indexed) {
      final start = g.first.occurredAt;
      final end = i + 1 < groups.length ? groups[i + 1].first.occurredAt : null;
      final stageIndex = g.first.stage.index;
      periods.add(StagePeriod(
        stage: g.first.stage,
        start: start,
        startEstimated: g.first.isEstimated,
        end: end,
        eventIds: [for (final e in g) e.id],
        l3Phases: [
          for (final e in g)
            if (e.l3Phase != null) (phase: e.l3Phase!, at: e.occurredAt),
        ],
        weights: [
          for (final w in sortedWeights)
            if (!w.measuredAt.isBefore(start) && (end == null || w.measuredAt.isBefore(end))) w,
        ],
        outOfOrder: stageIndex < furthest,
      ));
      if (stageIndex > furthest) furthest = stageIndex;
    }

    final current = sortedEvents.lastOrNull?.stage;
    final stages = [
      for (final s in LifeStage.values)
        RoadmapStage(
          stage: s,
          periods: [for (final p in periods) if (p.stage == s) p],
          status: switch (s) {
            _ when s == current => RoadmapStageStatus.current,
            _ when periods.any((p) => p.stage == s) => RoadmapStageStatus.recorded,
            _ when current != null && s.index < current.index => RoadmapStageStatus.notRecorded,
            _ when current == null => RoadmapStageStatus.notRecorded,
            _ => RoadmapStageStatus.upcoming,
          },
        ),
    ];

    final firstStart = periods.firstOrNull?.start;
    return GrowthRoadmap(
      stages: stages,
      periods: periods,
      current: current,
      weightsBeforeFirstStage: [
        for (final w in sortedWeights)
          if (firstStart == null || w.measuredAt.isBefore(firstStart)) w,
      ],
    );
  }
}
