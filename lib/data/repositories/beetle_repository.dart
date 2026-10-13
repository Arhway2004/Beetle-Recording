import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/models/enums.dart';
import '../database/app_database.dart';
import 'models.dart';

/// Beetles, species and all breeding history records. History rows are only
/// ever appended or tombstoned (`deleted_at`), never overwritten.
class BeetleRepository {
  BeetleRepository(this.db);

  final AppDatabase db;

  // ---------------------------------------------------------------- species

  Stream<List<SpeciesRow>> watchSpecies() => (db.select(db.species)
        ..where((s) => s.deletedAt.isNull())
        ..orderBy([(s) => OrderingTerm(expression: s.code)]))
      .watch();

  Future<SpeciesRow?> speciesById(String id) =>
      (db.select(db.species)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<String> addSpecies({
    required String code,
    required String scientificName,
    String? commonName,
    int? pupaDaysMin,
    int? pupaDaysMax,
  }) async {
    final normalized = code.toUpperCase().trim();
    final existing =
        await (db.select(db.species)..where((s) => s.code.equals(normalized))).getSingleOrNull();
    if (existing != null) throw DuplicateCodeException(normalized);
    final id = newId();
    await db.into(db.species).insert(SpeciesCompanion.insert(
          id: Value(id),
          code: normalized,
          scientificName: scientificName.trim(),
          commonName: Value(commonName),
          expectedPupaDaysMin: Value(pupaDaysMin),
          expectedPupaDaysMax: Value(pupaDaysMax),
        ));
    return id;
  }

  Future<void> updateSpecies(String id,
      {String? commonName, int? pupaDaysMin, int? pupaDaysMax, String? notes}) async {
    await db.transaction(() async {
      final row = await (db.select(db.species)..where((s) => s.id.equals(id))).getSingle();
      await (db.update(db.species)..where((s) => s.id.equals(id))).write(SpeciesCompanion(
        commonName: Value(commonName),
        expectedPupaDaysMin: Value(pupaDaysMin),
        expectedPupaDaysMax: Value(pupaDaysMax),
        notes: Value(notes),
        updatedAt: Value(nowUtc()),
        revision: Value(row.revision + 1),
      ));
    });
  }

  // ---------------------------------------------------------------- beetles

  /// Next free code for a species, e.g. `DHH-003`. Tombstoned beetles still
  /// reserve their code so IDs are never reused.
  Future<String> nextCode(String speciesId) async {
    final sp = await (db.select(db.species)..where((s) => s.id.equals(speciesId))).getSingle();
    final rows = await (db.select(db.beetles)..where((b) => b.code.like('${sp.code}-%'))).get();
    var max = 0;
    for (final r in rows) {
      final n = parseBeetleSequence(r.code, sp.code);
      if (n != null && n > max) max = n;
    }
    return formatBeetleCode(sp.code, max + 1);
  }

  Future<bool> codeExists(String code) async =>
      (await (db.select(db.beetles)..where((b) => b.code.equals(code))).getSingleOrNull()) != null;

  /// Throws [ParentException] unless [sireId]/[damId] are other live beetles of
  /// a compatible sex and neither is a descendant of [beetleId].
  Future<void> checkParents(String beetleId, {String? sireId, String? damId}) async {
    if (sireId != null && sireId == damId) throw ParentException(ParentError.sameParent);
    for (final (role, parentId, wrongSex) in [('sire', sireId, Sex.female), ('dam', damId, Sex.male)]) {
      if (parentId == null) continue;
      if (parentId == beetleId) throw ParentException(ParentError.self, role: role);
      final parent = await (db.select(db.beetles)
            ..where((b) => b.id.equals(parentId) & b.deletedAt.isNull()))
          .getSingleOrNull();
      if (parent == null) throw ParentException(ParentError.notFound, role: role);
      if (parent.sex == wrongSex) throw ParentException(ParentError.wrongSex, role: role);
      if ((await ancestorIds(parentId)).contains(beetleId)) throw ParentException(ParentError.cycle, role: role);
    }
  }

  Future<Set<String>> ancestorIds(String beetleId) async {
    final seen = <String>{};
    var frontier = {beetleId};
    while (frontier.isNotEmpty) {
      final rows = await (db.select(db.beetles)..where((b) => b.id.isIn(frontier))).get();
      frontier = {
        for (final r in rows) ...[r.sireId, r.damId].whereType<String>()
      }.difference(seen);
      seen.addAll(frontier);
    }
    return seen;
  }

  /// Live beetles that have [beetleId] as sire or dam.
  Stream<List<BeetleSummary>> watchOffspring(String beetleId) => _summaries(
      whereExtra: 'AND (b.sire_id = ? OR b.dam_id = ?)',
      vars: [Variable<String>(beetleId), Variable<String>(beetleId)]).watch();

  /// Creates the beetle and its initial stage/weight/container/substrate events
  /// atomically.
  Future<String> createBeetle(NewBeetleInput input) {
    return db.transaction(() async {
      final code = input.code.toUpperCase().trim();
      if (await codeExists(code)) throw DuplicateCodeException(code);
      final now = nowUtc();
      final id = newId();
      await checkParents(id, sireId: input.sireId, damId: input.damId);
      await db.into(db.beetles).insert(BeetlesCompanion.insert(
            id: Value(id),
            code: code,
            speciesId: input.speciesId,
            sex: Value(input.sex),
            acquiredAt: Value(input.acquiredAt?.toUtc()),
            hatchDate: Value(input.hatchDate?.toUtc()),
            estimatedHatchDate: Value(input.estimatedHatchDate?.toUtc()),
            hatchUncertaintyDays: Value(input.hatchUncertaintyDays),
            sensorId: Value(input.sensorId),
            notes: Value(input.notes),
            sireId: Value(input.sireId),
            damId: Value(input.damId),
            sireNote: Value(_blankToNull(input.sireNote)),
            damNote: Value(_blankToNull(input.damNote)),
          ));
      if (input.initialStage != null) {
        await addLifeStageEvent(
            beetleId: id,
            occurredAt: now,
            stage: input.initialStage!,
            l3Phase: input.initialL3Phase);
      }
      if (input.initialWeightGrams != null) {
        await addWeight(beetleId: id, measuredAt: now, grams: input.initialWeightGrams!);
      }
      if (input.containerLiters != null) {
        await addContainerChange(beetleId: id, changedAt: now, newVolumeLiters: input.containerLiters!);
      }
      if (input.substrateType != null || input.substrateBrand != null) {
        await addSubstrateChange(
            beetleId: id,
            changedAt: now,
            substrateType: input.substrateType,
            brand: input.substrateBrand);
      }
      return id;
    });
  }

  Future<void> updateBeetleProfile(
    String id, {
    required Sex sex,
    required BeetleStatus status,
    DateTime? acquiredAt,
    DateTime? hatchDate,
    DateTime? estimatedHatchDate,
    int? hatchUncertaintyDays,
    String? sensorId,
    String? notes,
    String? sireId,
    String? damId,
    String? sireNote,
    String? damNote,
  }) async {
    await db.transaction(() async {
      final row = await (db.select(db.beetles)..where((b) => b.id.equals(id))).getSingle();
      await checkParents(id, sireId: sireId, damId: damId);
      if (sex != Sex.unknown && sex != row.sex) {
        // A beetle that already sired (or bore) offspring cannot change to the other sex.
        final asWrongParent = sex == Sex.female ? db.beetles.sireId : db.beetles.damId;
        final children = await (db.select(db.beetles)
              ..where((b) => asWrongParent.equals(id) & b.deletedAt.isNull()))
            .get();
        if (children.isNotEmpty) throw ParentException(ParentError.sexConflictsWithOffspring);
      }
      await (db.update(db.beetles)..where((b) => b.id.equals(id))).write(BeetlesCompanion(
        sex: Value(sex),
        status: Value(status),
        acquiredAt: Value(acquiredAt?.toUtc()),
        hatchDate: Value(hatchDate?.toUtc()),
        estimatedHatchDate: Value(estimatedHatchDate?.toUtc()),
        hatchUncertaintyDays: Value(hatchUncertaintyDays),
        sensorId: Value(sensorId),
        notes: Value(notes),
        sireId: Value(sireId),
        damId: Value(damId),
        sireNote: Value(_blankToNull(sireNote)),
        damNote: Value(_blankToNull(damNote)),
        updatedAt: Value(nowUtc()),
        revision: Value(row.revision + 1),
      ));
    });
  }

  Future<void> setStatus(String id, BeetleStatus status) async {
    final b = await beetleRow(id);
    await updateBeetleProfile(id,
        sex: b.sex,
        status: status,
        acquiredAt: b.acquiredAt,
        hatchDate: b.hatchDate,
        estimatedHatchDate: b.estimatedHatchDate,
        hatchUncertaintyDays: b.hatchUncertaintyDays,
        sensorId: b.sensorId,
        notes: b.notes,
        sireId: b.sireId,
        damId: b.damId,
        sireNote: b.sireNote,
        damNote: b.damNote);
  }

  Future<BeetleRow> beetleRow(String id) =>
      (db.select(db.beetles)..where((b) => b.id.equals(id))).getSingle();

  static const _summarySql = '''
SELECT b.*, s.code AS species_code, s.scientific_name AS species_name, s.common_name AS species_common,
  (SELECT p.code FROM beetles p WHERE p.id = b.sire_id) AS sire_code,
  (SELECT p.code FROM beetles p WHERE p.id = b.dam_id) AS dam_code,
  (SELECT e.stage FROM life_stage_events e WHERE e.beetle_id = b.id AND e.deleted_at IS NULL
     ORDER BY e.occurred_at DESC, e.created_at DESC LIMIT 1) AS cur_stage,
  (SELECT e.l3_phase FROM life_stage_events e WHERE e.beetle_id = b.id AND e.deleted_at IS NULL
     ORDER BY e.occurred_at DESC, e.created_at DESC LIMIT 1) AS cur_l3_phase,
  (SELECT e.occurred_at FROM life_stage_events e WHERE e.beetle_id = b.id AND e.deleted_at IS NULL
     ORDER BY e.occurred_at DESC, e.created_at DESC LIMIT 1) AS cur_stage_at,
  (SELECT w.weight_grams FROM weight_records w WHERE w.beetle_id = b.id AND w.deleted_at IS NULL
     ORDER BY w.measured_at DESC, w.created_at DESC LIMIT 1) AS cur_weight,
  (SELECT w.measured_at FROM weight_records w WHERE w.beetle_id = b.id AND w.deleted_at IS NULL
     ORDER BY w.measured_at DESC, w.created_at DESC LIMIT 1) AS cur_weight_at,
  (SELECT MAX(w.weight_grams) FROM weight_records w WHERE w.beetle_id = b.id AND w.deleted_at IS NULL) AS max_weight,
  (SELECT c.new_volume_liters FROM container_changes c WHERE c.beetle_id = b.id AND c.deleted_at IS NULL
     ORDER BY c.changed_at DESC, c.created_at DESC LIMIT 1) AS cur_container,
  (SELECT x.substrate_type FROM substrate_changes x WHERE x.beetle_id = b.id AND x.deleted_at IS NULL
     ORDER BY x.changed_at DESC, x.created_at DESC LIMIT 1) AS cur_substrate_type,
  (SELECT x.brand FROM substrate_changes x WHERE x.beetle_id = b.id AND x.deleted_at IS NULL
     ORDER BY x.changed_at DESC, x.created_at DESC LIMIT 1) AS cur_substrate_brand
FROM beetles b JOIN species s ON s.id = b.species_id
WHERE b.deleted_at IS NULL''';

  Set<ResultSetImplementation<dynamic, dynamic>> get _summaryTables => {
        db.beetles,
        db.species,
        db.lifeStageEvents,
        db.weightRecords,
        db.containerChanges,
        db.substrateChanges,
      };

  Selectable<BeetleSummary> _summaries({String? whereExtra, List<Variable<Object>> vars = const []}) =>
      db
          .customSelect('$_summarySql ${whereExtra ?? ''} ORDER BY b.code',
              variables: vars, readsFrom: _summaryTables)
          .map(_mapSummary);

  Stream<List<BeetleSummary>> watchBeetles([BeetleFilter filter = const BeetleFilter()]) =>
      _summaries().watch().map((l) => l.where(filter.matches).toList());

  Future<List<BeetleSummary>> beetles() => _summaries().get();

  Stream<BeetleSummary?> watchBeetle(String id) => _summaries(
      whereExtra: 'AND b.id = ?', vars: [Variable<String>(id)]).watchSingleOrNull();

  Future<BeetleSummary?> beetleByCode(String code) => _summaries(
      whereExtra: 'AND b.code = ?', vars: [Variable<String>(code)]).getSingleOrNull();

  BeetleSummary _mapSummary(QueryRow r) {
    T? byName<T extends Enum>(List<T> values, String? name) =>
        name == null ? null : values.where((v) => v.name == name).firstOrNull;
    return BeetleSummary(
      id: r.read<String>('id'),
      code: r.read<String>('code'),
      speciesId: r.read<String>('species_id'),
      speciesCode: r.read<String>('species_code'),
      speciesName: r.read<String>('species_name'),
      speciesCommonName: r.readNullable<String>('species_common'),
      sex: byName(Sex.values, r.read<String>('sex')) ?? Sex.unknown,
      status: byName(BeetleStatus.values, r.read<String>('status')) ?? BeetleStatus.active,
      acquiredAt: r.readNullable<DateTime>('acquired_at'),
      hatchDate: r.readNullable<DateTime>('hatch_date'),
      estimatedHatchDate: r.readNullable<DateTime>('estimated_hatch_date'),
      hatchUncertaintyDays: r.readNullable<int>('hatch_uncertainty_days'),
      sensorId: r.readNullable<String>('sensor_id'),
      notes: r.readNullable<String>('notes'),
      createdAt: r.read<DateTime>('created_at'),
      sireId: r.readNullable<String>('sire_id'),
      damId: r.readNullable<String>('dam_id'),
      sireCode: r.readNullable<String>('sire_code'),
      damCode: r.readNullable<String>('dam_code'),
      sireNote: r.readNullable<String>('sire_note'),
      damNote: r.readNullable<String>('dam_note'),
      stage: byName(LifeStage.values, r.readNullable<String>('cur_stage')),
      l3Phase: byName(L3Phase.values, r.readNullable<String>('cur_l3_phase')),
      stageAt: r.readNullable<DateTime>('cur_stage_at'),
      latestWeightGrams: r.readNullable<double>('cur_weight'),
      latestWeightAt: r.readNullable<DateTime>('cur_weight_at'),
      maxWeightGrams: r.readNullable<double>('max_weight'),
      containerLiters: r.readNullable<double>('cur_container'),
      substrateType: r.readNullable<String>('cur_substrate_type'),
      substrateBrand: r.readNullable<String>('cur_substrate_brand'),
    );
  }

  // ---------------------------------------------------------------- records

  Future<String> addWeight({
    required String beetleId,
    required DateTime measuredAt,
    required double grams,
    String? notes,
  }) async {
    if (!(grams > 0) || !grams.isFinite) throw ArgumentError.value(grams, 'grams');
    final id = newId();
    await db.into(db.weightRecords).insert(WeightRecordsCompanion.insert(
          id: Value(id),
          beetleId: beetleId,
          measuredAt: measuredAt.toUtc(),
          weightGrams: grams,
          notes: Value(_blankToNull(notes)),
        ));
    return id;
  }

  Future<String> addObservation({
    required String beetleId,
    required DateTime observedAt,
    required ObservationCategory category,
    required String description,
  }) async {
    final id = newId();
    await db.into(db.observationRecords).insert(ObservationRecordsCompanion.insert(
          id: Value(id),
          beetleId: beetleId,
          observedAt: observedAt.toUtc(),
          category: Value(category),
          description: description.trim(),
        ));
    return id;
  }

  Future<String> addSubstrateChange({
    required String beetleId,
    required DateTime changedAt,
    String? substrateType,
    String? brand,
    String? batch,
    double? quantityLiters,
    double? beetleWeightGrams,
    String? condition,
    DateTime? nextPlannedAt,
    String? notes,
  }) async {
    final id = newId();
    await db.into(db.substrateChanges).insert(SubstrateChangesCompanion.insert(
          id: Value(id),
          beetleId: beetleId,
          changedAt: changedAt.toUtc(),
          substrateType: Value(_blankToNull(substrateType)),
          brand: Value(_blankToNull(brand)),
          batch: Value(_blankToNull(batch)),
          quantityLiters: Value(quantityLiters),
          beetleWeightGrams: Value(beetleWeightGrams),
          condition: Value(_blankToNull(condition)),
          nextPlannedAt: Value(nextPlannedAt?.toUtc()),
          notes: Value(_blankToNull(notes)),
        ));
    return id;
  }

  /// Records a container change. When `previousVolumeLiters` is omitted it is
  /// taken from the latest container record so history stays consistent.
  Future<String> addContainerChange({
    required String beetleId,
    required DateTime changedAt,
    required double newVolumeLiters,
    double? previousVolumeLiters,
    double? beetleWeightGrams,
    String? condition,
    String? notes,
  }) async {
    if (!(newVolumeLiters > 0)) throw ArgumentError.value(newVolumeLiters, 'newVolumeLiters');
    final previous = previousVolumeLiters ??
        (await (db.select(db.containerChanges)
                  ..where((c) => c.beetleId.equals(beetleId) & c.deletedAt.isNull())
                  ..orderBy([(c) => OrderingTerm.desc(c.changedAt)])
                  ..limit(1))
                .getSingleOrNull())
            ?.newVolumeLiters;
    final id = newId();
    await db.into(db.containerChanges).insert(ContainerChangesCompanion.insert(
          id: Value(id),
          beetleId: beetleId,
          changedAt: changedAt.toUtc(),
          previousVolumeLiters: Value(previous),
          newVolumeLiters: newVolumeLiters,
          beetleWeightGrams: Value(beetleWeightGrams),
          condition: Value(_blankToNull(condition)),
          notes: Value(_blankToNull(notes)),
        ));
    return id;
  }

  Future<String> addLifeStageEvent({
    required String beetleId,
    required DateTime occurredAt,
    required LifeStage stage,
    L3Phase? l3Phase,
    bool isEstimated = false,
    String? notes,
  }) async {
    final id = newId();
    await db.into(db.lifeStageEvents).insert(LifeStageEventsCompanion.insert(
          id: Value(id),
          beetleId: beetleId,
          occurredAt: occurredAt.toUtc(),
          stage: stage,
          l3Phase: Value(stage == LifeStage.l3 ? l3Phase : null),
          isEstimated: Value(isEstimated),
          notes: Value(_blankToNull(notes)),
        ));
    return id;
  }

  /// Tombstones a history record. The row stays for audit/sync; the beetle's
  /// "current" values automatically fall back to the previous event.
  Future<void> deleteRecord(TimelineType type, String id) async {
    final table = switch (type) {
      TimelineType.weight => 'weight_records',
      TimelineType.observation => 'observation_records',
      TimelineType.substrate => 'substrate_changes',
      TimelineType.container => 'container_changes',
      TimelineType.lifeStage => 'life_stage_events',
      TimelineType.temperature => 'temperature_records',
    };
    final now = nowUtc();
    await db.customUpdate(
      'UPDATE $table SET deleted_at = ?, updated_at = ?, revision = revision + 1 WHERE id = ? AND deleted_at IS NULL',
      variables: [Variable<DateTime>(now), Variable<DateTime>(now), Variable<String>(id)],
      updates: {
        switch (type) {
          TimelineType.weight => db.weightRecords,
          TimelineType.observation => db.observationRecords,
          TimelineType.substrate => db.substrateChanges,
          TimelineType.container => db.containerChanges,
          TimelineType.lifeStage => db.lifeStageEvents,
          TimelineType.temperature => db.temperatureRecords,
        },
      },
      updateKind: UpdateKind.update,
    );
  }

  Future<List<WeightRecordRow>> weightRows(String beetleId, {DateTime? since}) =>
      (db.select(db.weightRecords)
            ..where((w) =>
                w.beetleId.equals(beetleId) &
                w.deletedAt.isNull() &
                (since == null ? const Constant(true) : w.measuredAt.isBiggerOrEqualValue(since)))
            ..orderBy([(w) => OrderingTerm(expression: w.measuredAt)]))
          .get();

  Stream<List<WeightRecordRow>> watchWeights(String beetleId) => (db.select(db.weightRecords)
        ..where((w) => w.beetleId.equals(beetleId) & w.deletedAt.isNull())
        ..orderBy([(w) => OrderingTerm(expression: w.measuredAt)]))
      .watch();

  /// All non-deleted weights, grouped by beetle, for comparisons.
  Stream<Map<String, List<WeightRecordRow>>> watchAllWeights() => (db.select(db.weightRecords)
        ..where((w) => w.deletedAt.isNull())
        ..orderBy([(w) => OrderingTerm(expression: w.measuredAt)]))
      .watch()
      .map((rows) {
        final map = <String, List<WeightRecordRow>>{};
        for (final r in rows) {
          (map[r.beetleId] ??= []).add(r);
        }
        return map;
      });

  Future<List<ObservationRecordRow>> observationRows(String beetleId, {DateTime? since}) =>
      (db.select(db.observationRecords)
            ..where((o) =>
                o.beetleId.equals(beetleId) &
                o.deletedAt.isNull() &
                (since == null ? const Constant(true) : o.observedAt.isBiggerOrEqualValue(since)))
            ..orderBy([(o) => OrderingTerm(expression: o.observedAt)]))
          .get();

  Future<List<SubstrateChangeRow>> substrateRows(String beetleId) =>
      (db.select(db.substrateChanges)
            ..where((s) => s.beetleId.equals(beetleId) & s.deletedAt.isNull())
            ..orderBy([(s) => OrderingTerm(expression: s.changedAt)]))
          .get();

  Stream<List<SubstrateChangeRow>> watchAllSubstrateChanges({int limit = 50}) =>
      (db.select(db.substrateChanges)
            ..where((s) => s.deletedAt.isNull())
            ..orderBy([(s) => OrderingTerm.desc(s.changedAt)])
            ..limit(limit))
          .watch();

  Future<List<ContainerChangeRow>> containerRows(String beetleId) =>
      (db.select(db.containerChanges)
            ..where((c) => c.beetleId.equals(beetleId) & c.deletedAt.isNull())
            ..orderBy([(c) => OrderingTerm(expression: c.changedAt)]))
          .get();

  Future<List<LifeStageEventRow>> lifeStageRows(String beetleId) =>
      (db.select(db.lifeStageEvents)
            ..where((e) => e.beetleId.equals(beetleId) & e.deletedAt.isNull())
            ..orderBy([(e) => OrderingTerm(expression: e.occurredAt)]))
          .get();

  static const _timelineSql = '''
SELECT t.*, b.code AS beetle_code FROM (
  SELECT 'weight' AS type, id, beetle_id, measured_at AS at, weight_grams AS num1, NULL AS num2, notes AS text1, NULL AS text2
    FROM weight_records WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'observation', id, beetle_id, observed_at, NULL, NULL, category, description
    FROM observation_records WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'substrate', id, beetle_id, changed_at, quantity_liters, beetle_weight_grams, substrate_type, brand
    FROM substrate_changes WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'container', id, beetle_id, changed_at, previous_volume_liters, new_volume_liters, condition, notes
    FROM container_changes WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'lifeStage', id, beetle_id, occurred_at, NULL, NULL, stage, l3_phase
    FROM life_stage_events WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'temperature', r.id, NULL, r.recorded_at, r.celsius, NULL, s.name, r.notes
    FROM temperature_records r JOIN temperature_sensors s ON s.id = r.sensor_id WHERE r.deleted_at IS NULL
) t LEFT JOIN beetles b ON b.id = t.beetle_id
WHERE (?1 IS NULL OR t.beetle_id = ?1) AND (?2 IS NULL OR t.type = ?2)
ORDER BY t.at DESC LIMIT ?3''';

  Stream<List<TimelineEntry>> watchTimeline({String? beetleId, TimelineType? type, int limit = 200}) =>
      db
          .customSelect(_timelineSql,
              variables: [
                Variable<String>(beetleId),
                Variable<String>(type?.name),
                Variable<int>(limit),
              ],
              readsFrom: {
                db.weightRecords,
                db.observationRecords,
                db.substrateChanges,
                db.containerChanges,
                db.lifeStageEvents,
                db.temperatureRecords,
                db.temperatureSensors,
                db.beetles,
              })
          .watch()
          .map((rows) => rows
              .map((r) => TimelineEntry(
                    type: TimelineType.values.byName(r.read<String>('type')),
                    id: r.read<String>('id'),
                    at: r.read<DateTime>('at'),
                    beetleId: r.readNullable<String>('beetle_id'),
                    beetleCode: r.readNullable<String>('beetle_code'),
                    num1: r.readNullable<double>('num1'),
                    num2: r.readNullable<double>('num2'),
                    text1: r.readNullable<String>('text1'),
                    text2: r.readNullable<String>('text2'),
                  ))
              .toList());

  static String? _blankToNull(String? s) => (s == null || s.trim().isEmpty) ? null : s.trim();
}
