import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../../data/repositories/temperature_repository.dart';
import '../../domain/growth/growth_metrics.dart';
import '../../domain/growth/growth_roadmap.dart';
import '../../domain/models/enums.dart';

/// Reactive read models shared by screens. All are local-database streams, so
/// every screen works offline.

final beetlesProvider = StreamProvider<List<BeetleSummary>>((ref) => ref.watch(beetleRepoProvider).watchBeetles());

final offspringProvider = StreamProvider.family<List<BeetleSummary>, String>(
    (ref, id) => ref.watch(beetleRepoProvider).watchOffspring(id));

final beetleProvider =
    StreamProvider.family<BeetleSummary?, String>((ref, id) => ref.watch(beetleRepoProvider).watchBeetle(id));

final speciesProvider = StreamProvider<List<SpeciesRow>>((ref) => ref.watch(beetleRepoProvider).watchSpecies());

final sensorsProvider =
    StreamProvider<List<TemperatureSensorRow>>((ref) => ref.watch(temperatureRepoProvider).watchSensors());

final sensorStatsProvider =
    StreamProvider<List<SensorStats>>((ref) => ref.watch(temperatureRepoProvider).watchStats());

final suggestedRemindersProvider = StreamProvider<List<ReminderRow>>(
    (ref) => ref.watch(reminderRepoProvider).watchByStatus({ReminderStatus.suggested}));

final activeRemindersProvider = StreamProvider<List<ReminderRow>>((ref) =>
    ref.watch(reminderRepoProvider).watchByStatus({ReminderStatus.confirmed, ReminderStatus.scheduled}));

final closedRemindersProvider = StreamProvider<List<ReminderRow>>((ref) => ref
    .watch(reminderRepoProvider)
    .watchByStatus({ReminderStatus.completed, ReminderStatus.cancelled, ReminderStatus.expired}));

final beetleRemindersProvider = StreamProvider.family<List<ReminderRow>, String>(
    (ref, beetleId) => ref.watch(reminderRepoProvider).watchForBeetle(beetleId));

typedef TimelineQuery = ({String? beetleId, TimelineType? type, int limit});

final timelineProvider = StreamProvider.family<List<TimelineEntry>, TimelineQuery>((ref, q) =>
    ref.watch(beetleRepoProvider).watchTimeline(beetleId: q.beetleId, type: q.type, limit: q.limit));

final weightsProvider = StreamProvider.family<List<WeightRecordRow>, String>(
    (ref, beetleId) => ref.watch(beetleRepoProvider).watchWeights(beetleId));

final allWeightsProvider =
    StreamProvider<Map<String, List<WeightRecordRow>>>((ref) => ref.watch(beetleRepoProvider).watchAllWeights());

final photosProvider = StreamProvider.family<List<PhotoAttachmentRow>, String>(
    (ref, beetleId) => ref.watch(photoStoreProvider).watchForBeetle(beetleId));

final analysesProvider = StreamProvider.family<List<AiAnalysisRow>, String?>(
    (ref, beetleId) => ref.watch(aiMemoryRepoProvider).watchAnalyses(beetleId: beetleId));

/// beetleId → code, for labeling reminders and analyses.
final beetleCodesProvider = Provider<Map<String, String>>((ref) =>
    {for (final b in ref.watch(beetlesProvider).valueOrNull ?? const <BeetleSummary>[]) b.id: b.code});

final stageEventsProvider = StreamProvider.family<List<LifeStageEventRow>, String>(
    (ref, beetleId) => ref.watch(beetleRepoProvider).watchLifeStageRows(beetleId));

/// The beetle's growth roadmap, re-derived whenever a weight or stage record
/// is saved, edited or deleted (both inputs are live database streams).
final roadmapProvider = Provider.family<AsyncValue<GrowthRoadmap>, String>((ref, beetleId) {
  final stages = ref.watch(stageEventsProvider(beetleId));
  final weights = ref.watch(weightsProvider(beetleId));
  if (stages.hasError) return AsyncValue.error(stages.error!, stages.stackTrace ?? StackTrace.current);
  if (weights.hasError) return AsyncValue.error(weights.error!, weights.stackTrace ?? StackTrace.current);
  if (!stages.hasValue || !weights.hasValue) return const AsyncValue.loading();
  return AsyncValue.data(GrowthRoadmap.derive(
    events: [
      for (final e in stages.value!)
        StageEventPoint(
          id: e.id,
          occurredAt: e.occurredAt,
          createdAt: e.createdAt,
          stage: e.stage,
          l3Phase: e.l3Phase,
          isEstimated: e.isEstimated,
        ),
    ],
    weights: [for (final w in weights.value!) WeightPoint(id: w.id, measuredAt: w.measuredAt, grams: w.weightGrams)],
  ));
});
