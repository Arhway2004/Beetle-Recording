import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/data/repositories/beetle_repository.dart';
import 'package:beetle_keeper/data/repositories/models.dart';
import 'package:beetle_keeper/data/repositories/reminder_repository.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/backup/backup_service.dart';
import 'package:beetle_keeper/infrastructure/storage/photo_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  late Directory tmp;
  late AppDatabase source;

  setUp(() async {
    tmp = await Directory.systemTemp.createTemp('bk_backup_test');
    source = memoryDb();
  });
  tearDown(() async {
    await source.close();
    await tmp.delete(recursive: true);
  });

  Future<String> seed(AppDatabase db, Directory docs) async {
    final repo = BeetleRepository(db);
    final id = await repo.createBeetle(NewBeetleInput(
        code: 'DHH-001', speciesId: builtinSpeciesId('DHH'), sex: Sex.male, initialWeightGrams: 30, initialStage: LifeStage.l3));
    await repo.addWeight(beetleId: id, measuredAt: DateTime.utc(2026, 9, 1), grams: 33);
    await ReminderRepository(db).createUserReminder(beetleId: id, title: 't', message: 'm', dueAt: DateTime.utc(2027));
    final photo = File('${tmp.path}/src.jpg')..writeAsBytesSync(List.generate(256, (i) => i % 251));
    await PhotoStore(db, docs).addPhoto(source: photo, ownerType: PhotoOwnerType.beetle, ownerId: id, beetleId: id);
    return id;
  }

  test('export → restore into a fresh device reproduces records and photos', () async {
    final docsA = await Directory('${tmp.path}/a').create();
    final docsB = await Directory('${tmp.path}/b').create();
    await seed(source, docsA);
    final bytes = await BackupService(source, docsA).exportBytes();

    final target = memoryDb();
    addTearDown(target.close);
    final result = await BackupService(target, docsB).restore(bytes);
    expect(result.inserted, greaterThan(0));
    expect(result.photosWritten, 1);
    final b = (await BeetleRepository(target).beetleByCode('DHH-001'))!;
    expect(b.latestWeightGrams, 30, reason: 'creation-time weight is newest (now)');
    expect(await target.select(target.weightRecords).get(), hasLength(2));
    expect(await target.select(target.reminders).get(), hasLength(1));
    final photo = (await target.select(target.photoAttachments).get()).single;
    expect(File('${docsB.path}/${photo.relativePath}').existsSync(), isTrue);
  });

  test('re-importing the same backup is detected; merge never duplicates', () async {
    final docs = await Directory('${tmp.path}/a').create();
    await seed(source, docs);
    final svc = BackupService(source, docs);
    final bytes = await svc.exportBytes();
    final first = await svc.restore(bytes);
    expect(first.inserted, 0, reason: 'same ids already present');
    expect(() => svc.restore(bytes), throwsA(isA<BackupException>().having((e) => e.error, 'error', BackupError.alreadyImported)));
    final again = await svc.restore(bytes, allowReimport: true);
    expect(again.inserted, 0);
    expect(await source.select(source.beetles).get(), hasLength(1));
  });

  test('newer edits win; older backup rows do not overwrite newer local rows', () async {
    final docs = await Directory('${tmp.path}/a').create();
    final id = await seed(source, docs);
    final bytes = await BackupService(source, docs).exportBytes();
    await BeetleRepository(source).updateBeetleProfile(id, sex: Sex.female, status: BeetleStatus.active, notes: 'newer');
    final r = await BackupService(source, docs).restore(bytes);
    expect(r.updated, 0);
    expect((await BeetleRepository(source).beetleRow(id)).notes, 'newer');
  });

  test('corrupted, foreign, and newer-version archives are rejected without changes', () async {
    final docs = await Directory('${tmp.path}/a').create();
    await seed(source, docs);
    final svc = BackupService(source, docs);
    final bytes = await svc.exportBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    Archive rebuild({String? data, Map<String, Object?>? manifestPatch}) {
      final out = Archive();
      for (final f in archive.files) {
        if (f.name == 'data.json' && data != null) {
          out.addFile(ArchiveFile.string('data.json', data));
        } else if (f.name == 'manifest.json' && manifestPatch != null) {
          final m = (jsonDecode(utf8.decode(f.content)) as Map).cast<String, Object?>()..addAll(manifestPatch);
          out.addFile(ArchiveFile.string('manifest.json', jsonEncode(m)));
        } else {
          out.addFile(ArchiveFile.bytes(f.name, f.content));
        }
      }
      return out;
    }

    BackupError? errorOf(List<int> b) {
      try {
        svc.inspect(b is Uint8List ? b : Uint8List.fromList(b));
        return null;
      } on BackupException catch (e) {
        return e.error;
      }
    }

    expect(errorOf(ZipEncoder().encodeBytes(rebuild(data: '{"tables":{}}'))), BackupError.corrupted);
    expect(errorOf(ZipEncoder().encodeBytes(rebuild(manifestPatch: {'schema_version': 99}))), BackupError.unsupportedVersion);
    expect(errorOf(ZipEncoder().encodeBytes(rebuild(manifestPatch: {'format': 'other'}))), BackupError.notABackup);
    expect(errorOf(utf8.encode('not a zip')), BackupError.notABackup);
  });

  test('a different record with the same beetle code is an explicit conflict', () async {
    final docs = await Directory('${tmp.path}/a').create();
    await seed(source, docs);
    final bytes = await BackupService(source, docs).exportBytes();
    final other = memoryDb();
    addTearDown(other.close);
    await BeetleRepository(other)
        .createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: builtinSpeciesId('DHH'), sex: Sex.female));
    expect(() => BackupService(other, docs).restore(bytes),
        throwsA(isA<BackupException>().having((e) => e.error, 'error', BackupError.codeConflict)));
    expect(await other.select(other.weightRecords).get(), isEmpty);
  });

  test('backups never contain provider settings or secrets', () async {
    final docs = await Directory('${tmp.path}/a').create();
    final bytes = await BackupService(source, docs).exportBytes();
    final data = utf8.decode(ZipDecoder().decodeBytes(bytes).findFile('data.json')!.content);
    expect(data, isNot(contains('ai_provider_settings')));
    expect(data, isNot(contains('token')));
  });

  test('restores a beetle whose parent was created after it', () async {
    final docs = await Directory('${tmp.path}/a').create();
    final repo = BeetleRepository(source);
    final child = await repo.createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: builtinSpeciesId('DHH'), sex: Sex.male));
    final sire = await repo.createBeetle(NewBeetleInput(code: 'DHH-002', speciesId: builtinSpeciesId('DHH'), sex: Sex.male));
    await repo.updateBeetleProfile(child, sex: Sex.male, status: BeetleStatus.active, sireId: sire);
    final bytes = await BackupService(source, docs).exportBytes();

    final target = memoryDb();
    addTearDown(target.close);
    await BackupService(target, docs).restore(bytes);
    expect((await BeetleRepository(target).beetleRow(child)).sireId, sire);
  });
}

