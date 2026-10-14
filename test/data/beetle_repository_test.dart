import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/data/repositories/beetle_repository.dart';
import 'package:beetle_keeper/data/repositories/models.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/domain/records/past_record.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  late AppDatabase db;
  late BeetleRepository repo;
  late String dhh;

  setUp(() async {
    db = memoryDb();
    repo = BeetleRepository(db);
    dhh = builtinSpeciesId('DHH');
  });
  tearDown(() => db.close());

  test('seeds built-in species with deterministic ids, no demo beetles', () async {
    final species = await db.select(db.species).get();
    expect(species.map((s) => s.code), containsAll(['DHH', 'CCK']));
    expect(species.firstWhere((s) => s.code == 'DHH').id, '5c1d6b0e-0d1a-4c7e-9a00-000000000001');
    expect(await db.select(db.beetles).get(), isEmpty);
  });

  test('codes are sequential per species and never reused', () async {
    expect(await repo.nextCode(dhh), 'DHH-001');
    final id = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male));
    expect(await repo.nextCode(dhh), 'DHH-002');
    await db.customStatement("UPDATE beetles SET deleted_at = 1 WHERE id = '$id'");
    expect(await repo.nextCode(dhh), 'DHH-002');
    expect(() => repo.createBeetle(NewBeetleInput(code: 'dhh-001', speciesId: dhh, sex: Sex.male)),
        throwsA(isA<DuplicateCodeException>()));
  });

  test('creation writes initial values as history events; current values are derived', () async {
    final id = await repo.createBeetle(NewBeetleInput(
      code: 'DHH-001',
      speciesId: dhh,
      sex: Sex.male,
      initialStage: LifeStage.l3,
      initialL3Phase: L3Phase.middle,
      initialWeightGrams: 35,
      containerLiters: 3,
      substrateType: 'fermented flake',
      substrateBrand: 'BrandA',
    ));
    final b = (await repo.beetleByCode('DHH-001'))!;
    expect(b.id, id);
    expect(b.stage, LifeStage.l3);
    expect(b.l3Phase, L3Phase.middle);
    expect(b.latestWeightGrams, 35);
    expect(b.containerLiters, 3);
    expect(b.substrateBrand, 'BrandA');
    expect(await repo.weightRows(id), hasLength(1));
    expect(await repo.lifeStageRows(id), hasLength(1));
  });

  test('history is appended, never overwritten; tombstone falls back to previous', () async {
    final id = await repo.createBeetle(
        NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male, containerLiters: 2, initialWeightGrams: 20));
    await repo.addContainerChange(beetleId: id, changedAt: DateTime.now().add(const Duration(minutes: 1)), newVolumeLiters: 5);
    final changes = await repo.containerRows(id);
    expect(changes, hasLength(2));
    expect(changes.last.previousVolumeLiters, 2, reason: 'previous volume taken from history');
    expect((await repo.beetleByCode('DHH-001'))!.containerLiters, 5);

    final w2 = await repo.addWeight(beetleId: id, measuredAt: DateTime.now().add(const Duration(days: 1)), grams: 25);
    expect((await repo.beetleByCode('DHH-001'))!.latestWeightGrams, 25);
    await repo.deleteRecord(TimelineType.weight, w2);
    final after = (await repo.beetleByCode('DHH-001'))!;
    expect(after.latestWeightGrams, 20);
    final raw = await (db.select(db.weightRecords)..where((w) => w.id.equals(w2))).getSingle();
    expect(raw.deletedAt, isNotNull, reason: 'row kept as tombstone');
    expect(raw.revision, 2);
  });

  test('foreign keys and check constraints are enforced', () async {
    expect(() => repo.addWeight(beetleId: 'missing', measuredAt: DateTime.now(), grams: 10), throwsA(anything));
    final id = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male));
    expect(() => repo.addWeight(beetleId: id, measuredAt: DateTime.now(), grams: 0), throwsArgumentError);
    expect(
      () => db.into(db.weightRecords).insert(WeightRecordsCompanion.insert(beetleId: id, measuredAt: DateTime.now(), weightGrams: -1)),
      throwsA(anything),
    );
  });

  test('stage is never inferred from weight', () async {
    final id = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male));
    await repo.addWeight(beetleId: id, measuredAt: DateTime.now(), grams: 120);
    expect((await repo.beetleByCode('DHH-001'))!.stage, isNull);
  });

  test('timeline merges record types newest first and filters by type', () async {
    final id = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male));
    final t0 = DateTime.utc(2026, 1, 1);
    await repo.addWeight(beetleId: id, measuredAt: t0, grams: 10);
    await repo.addObservation(beetleId: id, observedAt: t0.add(const Duration(days: 1)), category: ObservationCategory.colorChange, description: 'yellow');
    await repo.addLifeStageEvent(beetleId: id, occurredAt: t0.add(const Duration(days: 2)), stage: LifeStage.prepupa);
    final all = await repo.watchTimeline(beetleId: id).first;
    expect(all.map((e) => e.type), [TimelineType.lifeStage, TimelineType.observation, TimelineType.weight]);
    expect(all.first.beetleCode, 'DHH-001');
    final weights = await repo.watchTimeline(type: TimelineType.weight).first;
    expect(weights.single.num1, 10);
  });

  test('migration strategy: fresh DB reports schema version 2 with FK pragma on', () async {
    expect(db.schemaVersion, 2);
    final fk = await db.customSelect('PRAGMA foreign_keys').getSingle();
    expect(fk.data.values.first, 1);
    final idx = await db.customSelect("SELECT name FROM sqlite_master WHERE type='index' AND name LIKE 'idx_%'").get();
    expect(idx.map((r) => r.read<String>('name')), containsAll(['idx_weight_beetle_time', 'idx_reminder_dedupe']));
  });

  group('parents', () {
    Future<String> make(String code, Sex sex, {String? sireId, String? damId, String? sireNote}) =>
        repo.createBeetle(
            NewBeetleInput(code: code, speciesId: dhh, sex: sex, sireId: sireId, damId: damId, sireNote: sireNote));
    Matcher fails(ParentError e) => throwsA(isA<ParentException>().having((x) => x.error, 'error', e));

    test('links sire and dam, lists offspring and exposes parents to AI tools', () async {
      final sire = await make('DHH-001', Sex.male);
      final dam = await make('DHH-002', Sex.female);
      final child = await make('DHH-003', Sex.unknown, sireId: sire, damId: dam);
      final external = await make('DHH-004', Sex.unknown, sireNote: '  WD 150 mm  ');

      final c = (await repo.beetleByCode('DHH-003'))!;
      expect((c.sireCode, c.damCode, c.hasParents), ('DHH-001', 'DHH-002', true));
      expect(c.toToolJson()['sire'], 'DHH-001');
      expect((await repo.beetleByCode('DHH-004'))!.sireNote, 'WD 150 mm');
      expect((await repo.watchOffspring(sire).first).map((b) => b.id), [child]);
      expect(await repo.watchOffspring(external).first, isEmpty);
    });

    test('rejects impossible links', () async {
      final sire = await make('DHH-001', Sex.male);
      final dam = await make('DHH-002', Sex.female);
      expect(() => make('DHH-010', Sex.male, sireId: dam), fails(ParentError.wrongSex));
      expect(() => make('DHH-011', Sex.male, damId: sire), fails(ParentError.wrongSex));
      expect(() => make('DHH-012', Sex.male, sireId: 'missing'), fails(ParentError.notFound));

      final child = await make('DHH-003', Sex.male, sireId: sire, damId: dam);
      Future<void> relink(String id, {String? sireId, String? damId, Sex sex = Sex.male}) =>
          repo.updateBeetleProfile(id, sex: sex, status: BeetleStatus.active, sireId: sireId, damId: damId);
      expect(() => relink(sire, sireId: sire), fails(ParentError.self));
      expect(() => relink(sire, sireId: child), fails(ParentError.cycle));
      expect(() => relink(sire, sex: Sex.female), fails(ParentError.sexConflictsWithOffspring));
      await relink(child); // clearing parents is always allowed
      expect((await repo.beetleByCode('DHH-003'))!.hasParents, isFalse);
    });

    test('changing status keeps parent links', () async {
      final sire = await make('DHH-001', Sex.male);
      final child = await make('DHH-002', Sex.male, sireId: sire);
      await repo.setStatus(child, BeetleStatus.archived);
      expect((await repo.beetleRow(child)).sireId, sire);
    });
  });

  group('past records', () {
    test('saves weights and stages from earlier months in one go', () async {
      final id = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male));
      final created = await repo.addPastRecords(id, [
        PastRecordDraft(date: DateTime.utc(2026, 2, 1), grams: 8, stage: LifeStage.l2, dateIsApproximate: true),
        PastRecordDraft(date: DateTime.utc(2026, 4, 1), stage: LifeStage.l3, l3Phase: L3Phase.early, note: 'moved'),
        PastRecordDraft(date: DateTime.utc(2026, 5, 1), grams: 21),
        const PastRecordDraft(date: null), // empty row ignored
      ], approximateNote: 'approx.');
      expect(created, 4);

      final weights = await repo.watchWeights(id).first;
      expect(weights.map((w) => w.weightGrams), [8, 21]);
      expect(weights.first.notes, 'approx.');
      final stages = await (db.select(db.lifeStageEvents)..where((e) => e.beetleId.equals(id))).get();
      expect(stages.firstWhere((e) => e.stage == LifeStage.l2).isEstimated, isTrue);
      expect(stages.firstWhere((e) => e.stage == LifeStage.l3).l3Phase, L3Phase.early);
      expect((await repo.beetleByCode('DHH-001'))!.stage, LifeStage.l3); // latest by observation date
    });

    test('nothing is saved when one row fails', () async {
      final id = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: dhh, sex: Sex.male));
      await expectLater(
          repo.addPastRecords(id, [
            PastRecordDraft(date: DateTime.utc(2026, 2, 1), grams: 8),
            PastRecordDraft(date: DateTime.utc(2026, 3, 1), grams: -1), // rejected by addWeight
          ], approximateNote: 'approx.'),
          throwsArgumentError);
      expect(await repo.watchWeights(id).first, isEmpty);
    });
  });
}

