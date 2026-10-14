import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/ai/breeding_tools.dart';
import '../../domain/growth/growth_metrics.dart';
import '../../domain/models/enums.dart';
import '../../domain/proactive/care_rules.dart';
import 'beetle_repository.dart';
import 'temperature_repository.dart';

String? _iso(DateTime? d) => d?.toUtc().toIso8601String();

/// Read-only adapter from repositories to the AI tool layer and the rule
/// engine. It exposes no write methods.
class DriftBreedingReadModel implements BreedingReadModel {
  DriftBreedingReadModel(this.beetlesRepo, this.temperatureRepo);

  final BeetleRepository beetlesRepo;
  final TemperatureRepository temperatureRepo;

  @override
  Future<List<Map<String, Object?>>> beetles({String? speciesCode, BeetleStatus? status}) async {
    final all = await beetlesRepo.beetles();
    return all
        .where((b) => speciesCode == null || b.speciesCode == speciesCode.toUpperCase())
        .where((b) => status == null || b.status == status)
        .map((b) => {
              'id': b.id,
              'beetle_id': b.code,
              'species_code': b.speciesCode,
              'sex': b.sex.name,
              'status': b.status.name,
              'current_stage': b.stage?.name,
              'latest_weight_grams': b.latestWeightGrams,
            })
        .toList();
  }

  @override
  Future<Map<String, Object?>?> beetleProfile(String code) async =>
      (await beetlesRepo.beetleByCode(code))?.toToolJson();

  @override
  Future<String?> beetleIdForCode(String code) async => (await beetlesRepo.beetleByCode(code))?.id;

  @override
  Future<String?> resolveBeetleCode(String raw) async {
    final exact = raw.toUpperCase().trim();
    if (await beetlesRepo.beetleByCode(exact) != null) return exact;
    final loose = parseLooseBeetleCode(raw);
    if (loose == null) return null;
    final matches = [
      for (final b in await beetlesRepo.beetles())
        if (parseBeetleSequence(b.code, loose.prefix) == loose.number) b.code,
    ];
    return matches.length == 1 ? matches.single : null; // ambiguous → not found
  }

  @override
  Future<List<WeightPoint>> weights(String beetleId, {DateTime? since}) async =>
      (await beetlesRepo.weightRows(beetleId, since: since))
          .map((w) => WeightPoint(id: w.id, measuredAt: w.measuredAt, grams: w.weightGrams))
          .toList();

  @override
  Future<List<Map<String, Object?>>> observations(String beetleId, {DateTime? since}) async =>
      (await beetlesRepo.observationRows(beetleId, since: since))
          .map((o) => {
                'id': o.id,
                'observed_at': _iso(o.observedAt),
                'category': o.category.name,
                'description': o.description,
              })
          .toList();

  @override
  Future<List<Map<String, Object?>>> substrateChanges(String beetleId) async =>
      (await beetlesRepo.substrateRows(beetleId))
          .map((s) => {
                'id': s.id,
                'changed_at': _iso(s.changedAt),
                'substrate_type': s.substrateType,
                'brand': s.brand,
                'batch': s.batch,
                'quantity_liters': s.quantityLiters,
                'beetle_weight_grams': s.beetleWeightGrams,
                'condition': s.condition,
                'next_planned_at': _iso(s.nextPlannedAt),
                'notes': s.notes,
              })
          .toList();

  @override
  Future<List<Map<String, Object?>>> containerChanges(String beetleId) async =>
      (await beetlesRepo.containerRows(beetleId))
          .map((c) => {
                'id': c.id,
                'changed_at': _iso(c.changedAt),
                'previous_volume_liters': c.previousVolumeLiters,
                'new_volume_liters': c.newVolumeLiters,
                'beetle_weight_grams': c.beetleWeightGrams,
                'condition': c.condition,
                'notes': c.notes,
              })
          .toList();

  @override
  Future<List<Map<String, Object?>>> lifeStageEvents(String beetleId) async =>
      (await beetlesRepo.lifeStageRows(beetleId))
          .map((e) => {
                'id': e.id,
                'occurred_at': _iso(e.occurredAt),
                'stage': e.stage.name,
                'l3_phase': e.l3Phase?.name,
                'date_is_estimated': e.isEstimated,
                'notes': e.notes,
              })
          .toList();

  @override
  Future<List<Map<String, Object?>>> temperatures({String? beetleId, DateTime? since}) async {
    String? sensorId;
    if (beetleId != null) {
      sensorId = (await beetlesRepo.beetleRow(beetleId)).sensorId;
      if (sensorId == null) return const [];
    }
    final sensors = {for (final s in await temperatureRepo.sensors()) s.id: s};
    return (await temperatureRepo.readings(sensorId, since: since))
        .where((r) => sensors.containsKey(r.sensorId))
        .map((r) {
      final s = sensors[r.sensorId]!;
      return {
        'id': r.id,
        'sensor': s.name,
        'recorded_at': _iso(r.recordedAt),
        'celsius': r.celsius,
        'user_min_threshold_c': s.minThresholdC,
        'user_max_threshold_c': s.maxThresholdC,
      };
    }).toList();
  }

  // ------------------------------------------------------------ rule engine

  Future<List<BeetleCareSnapshot>> beetleSnapshots({String? onlyBeetleId}) async {
    final all = await beetlesRepo.beetles();
    final species = {
      for (final s in await beetlesRepo.db.select(beetlesRepo.db.species).get()) s.id: s,
    };
    final out = <BeetleCareSnapshot>[];
    for (final b in all) {
      if (onlyBeetleId != null && b.id != onlyBeetleId) continue;
      final stages = await beetlesRepo.lifeStageRows(b.id);
      final subs = await beetlesRepo.substrateRows(b.id);
      final sp = species[b.speciesId];
      out.add(BeetleCareSnapshot(
        beetleId: b.id,
        code: b.code,
        status: b.status,
        createdAt: b.createdAt,
        stage: b.stage,
        stageEventId: stages.isEmpty ? null : stages.last.id,
        stageAt: b.stageAt,
        weights: await weights(b.id),
        observations: (await beetlesRepo.observationRows(b.id,
                since: DateTime.now().toUtc().subtract(const Duration(days: 60))))
            .map((o) =>
                ObservationSnap(id: o.id, observedAt: o.observedAt, category: o.category))
            .toList(),
        latestSubstrate: subs.isEmpty
            ? null
            : SubstrateSnap(
                id: subs.last.id,
                changedAt: subs.last.changedAt,
                nextPlannedAt: subs.last.nextPlannedAt),
        expectedPupaDaysMin: sp?.expectedPupaDaysMin,
        expectedPupaDaysMax: sp?.expectedPupaDaysMax,
      ));
    }
    return out;
  }

  Future<List<SensorCareSnapshot>> sensorSnapshots() async {
    final db = temperatureRepo.db;
    final out = <SensorCareSnapshot>[];
    for (final s in await temperatureRepo.sensors()) {
      final latest = await (db.select(db.temperatureRecords)
            ..where((r) => r.sensorId.equals(s.id) & r.deletedAt.isNull())
            ..orderBy([(r) => OrderingTerm.desc(r.recordedAt)])
            ..limit(1))
          .getSingleOrNull();
      out.add(SensorCareSnapshot(
        sensorId: s.id,
        name: s.name,
        minC: s.minThresholdC,
        maxC: s.maxThresholdC,
        latestRecordId: latest?.id,
        latestAt: latest?.recordedAt,
        latestC: latest?.celsius,
      ));
    }
    return out;
  }
}
