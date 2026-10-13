import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../../data/repositories/temperature_repository.dart';
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
