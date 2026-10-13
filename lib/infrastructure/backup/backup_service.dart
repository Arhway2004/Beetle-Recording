import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../core/utils/ids.dart';
import '../../data/database/app_database.dart';

/// Versioned backup archive (`.zip`):
///
/// ```
/// manifest.json   format, format_version, backup_id, schema_version, sha256 of every file
/// data.json       {"tables": {"<table>": [ {<column>: <raw value>} ]}}
/// photos/…        photo files referenced by photo_attachments.relative_path
/// ```
/// Tombstoned rows are included so deletions survive a restore. Secrets and
/// device-local provider settings are never exported.
class BackupService {
  BackupService(this.db, this.documentsDir, {this.appVersion = '1.0.0'});

  final AppDatabase db;
  final Directory documentsDir;
  final String appVersion;

  static const format = 'beetle-keeper-backup';
  static const formatVersion = 1;

  Future<Uint8List> exportBytes({DateTime? now}) async {
    final tables = <String, List<Map<String, Object?>>>{};
    for (final t in db.tablesInDependencyOrder) {
      final rows = await db.customSelect('SELECT * FROM "${t.actualTableName}"').get();
      tables[t.actualTableName] = rows.map((r) => r.data).toList();
    }
    final dataBytes = utf8.encode(jsonEncode({'tables': tables}));

    final archive = Archive();
    final photos = <Map<String, Object?>>[];
    for (final row in tables['photo_attachments'] ?? const <Map<String, Object?>>[]) {
      if (row['deleted_at'] != null) continue;
      final rel = row['relative_path']! as String;
      final f = File(p.join(documentsDir.path, rel));
      if (!await f.exists()) continue;
      final bytes = await f.readAsBytes();
      final name = p.posix.joinAll(p.split(rel));
      archive.addFile(ArchiveFile.bytes(name, bytes));
      photos.add({'path': name, 'sha256': sha256.convert(bytes).toString(), 'size': bytes.length});
    }
    final manifest = {
      'format': format,
      'format_version': formatVersion,
      'backup_id': newId(),
      'created_at': (now ?? DateTime.now()).toUtc().toIso8601String(),
      'app_version': appVersion,
      'schema_version': db.schemaVersion,
      'data_file': 'data.json',
      'data_sha256': sha256.convert(dataBytes).toString(),
      'data_size': dataBytes.length,
      'counts': {for (final e in tables.entries) e.key: e.value.length},
      'photos': photos,
    };
    archive.addFile(ArchiveFile.bytes('data.json', dataBytes));
    archive.addFile(ArchiveFile.string('manifest.json', const JsonEncoder.withIndent('  ').convert(manifest)));
    return ZipEncoder().encodeBytes(archive);
  }

  Future<File> exportToFile(Directory outDir, {DateTime? now}) async {
    final stamp = (now ?? DateTime.now()).toUtc().toIso8601String().replaceAll(RegExp(r'[:.]'), '-');
    final file = File(p.join(outDir.path, 'beetle-keeper-$stamp.bkbackup.zip'));
    await file.writeAsBytes(await exportBytes(now: now), flush: true);
    return file;
  }

  /// Validates and reads a backup without modifying anything.
  BackupContents inspect(Uint8List bytes) {
    final Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(bytes, verify: true);
    } catch (e) {
      throw BackupException(BackupError.notABackup, '$e');
    }
    final manifestFile = archive.findFile('manifest.json');
    if (manifestFile == null) throw BackupException(BackupError.notABackup, 'manifest.json missing');
    final Map<String, Object?> manifest;
    try {
      manifest = (jsonDecode(utf8.decode(manifestFile.content)) as Map).cast<String, Object?>();
    } catch (e) {
      throw BackupException(BackupError.corrupted, 'manifest unreadable');
    }
    if (manifest['format'] != format) throw BackupException(BackupError.notABackup, 'wrong format');
    final fv = manifest['format_version'];
    if (fv is! int || fv > formatVersion) {
      throw BackupException(BackupError.unsupportedVersion, 'format_version $fv');
    }
    final sv = manifest['schema_version'];
    if (sv is! int || sv > db.schemaVersion) {
      throw BackupException(BackupError.unsupportedVersion, 'schema_version $sv is newer than ${db.schemaVersion}');
    }
    final dataFile = archive.findFile('data.json');
    if (dataFile == null) throw BackupException(BackupError.corrupted, 'data.json missing');
    final dataBytes = dataFile.content;
    if (sha256.convert(dataBytes).toString() != manifest['data_sha256']) {
      throw BackupException(BackupError.corrupted, 'data.json checksum mismatch');
    }
    final photos = <String, Uint8List>{};
    for (final entry in (manifest['photos'] as List? ?? const [])) {
      final m = (entry as Map).cast<String, Object?>();
      final path = m['path']! as String;
      if (path.contains('..') || p.isAbsolute(path)) {
        throw BackupException(BackupError.corrupted, 'unsafe path $path');
      }
      final f = archive.findFile(path);
      if (f == null) throw BackupException(BackupError.corrupted, 'photo $path missing');
      if (sha256.convert(f.content).toString() != m['sha256']) {
        throw BackupException(BackupError.corrupted, 'photo $path checksum mismatch');
      }
      photos[path] = f.content;
    }
    final data = (jsonDecode(utf8.decode(dataBytes)) as Map)['tables'] as Map;
    return BackupContents(
      backupId: manifest['backup_id']! as String,
      createdAt: DateTime.parse(manifest['created_at']! as String),
      schemaVersion: sv,
      tables: data.map((k, v) => MapEntry(
          k as String, (v as List).map((r) => (r as Map).cast<String, Object?>()).toList())),
      photos: photos,
    );
  }

  /// Merges a backup into the local database by record ID.
  ///
  /// * New IDs are inserted; existing IDs are updated only if the backup row
  ///   has a newer `updated_at` (so restoring twice never duplicates data).
  /// * A different record using an existing beetle/species code is an explicit
  ///   conflict and aborts the restore without changes.
  /// * Re-importing the same backup is detected and reported.
  Future<RestoreResult> restore(Uint8List bytes, {bool allowReimport = false}) async {
    final contents = inspect(bytes);
    final already = await (db.select(db.backupImports)
          ..where((b) => b.backupId.equals(contents.backupId)))
        .getSingleOrNull();
    if (already != null && !allowReimport) {
      throw BackupException(BackupError.alreadyImported, contents.backupId);
    }
    await _checkCodeConflicts(contents, 'species');
    await _checkCodeConflicts(contents, 'beetles');

    var inserted = 0, updated = 0, skipped = 0;
    await db.transaction(() async {
      // Beetles reference other beetles (sire/dam), so rows of one table can
      // arrive child-first; check foreign keys at commit instead of per row.
      await db.customStatement('PRAGMA defer_foreign_keys = ON');
      for (final table in db.tablesInDependencyOrder) {
        final name = table.actualTableName;
        final rows = contents.tables[name];
        if (rows == null) continue;
        final columns = {for (final c in table.$columns) c.name};
        final pk = table.$primaryKey.single.name;
        for (final raw in rows) {
          final row = {
            for (final e in raw.entries)
              if (columns.contains(e.key)) e.key: e.value,
          };
          final id = row[pk];
          if (id == null) {
            skipped++;
            continue;
          }
          final existing = await db
              .customSelect('SELECT updated_at FROM "$name" WHERE "$pk" = ?',
                  variables: [Variable<Object>(id)])
              .getSingleOrNull();
          if (existing == null) {
            final cols = row.keys.map((c) => '"$c"').join(', ');
            final qs = List.filled(row.length, '?').join(', ');
            await db.customInsert('INSERT INTO "$name" ($cols) VALUES ($qs)',
                variables: row.values.map(_variable).toList(), updates: {table});
            inserted++;
          } else {
            final localUpdated = existing.data['updated_at'];
            final incomingUpdated = row['updated_at'];
            if (incomingUpdated is num && localUpdated is num && incomingUpdated > localUpdated) {
              final sets = row.keys.where((c) => c != pk).map((c) => '"$c" = ?').join(', ');
              await db.customUpdate('UPDATE "$name" SET $sets WHERE "$pk" = ?',
                  variables: [
                    ...row.entries.where((e) => e.key != pk).map((e) => _variable(e.value)),
                    Variable<Object>(id),
                  ],
                  updates: {table},
                  updateKind: UpdateKind.update);
              updated++;
            } else {
              skipped++;
            }
          }
        }
      }
      await db.into(db.backupImports).insertOnConflictUpdate(BackupImportsCompanion.insert(
            backupId: contents.backupId,
            insertedCount: inserted,
            updatedCount: updated,
            skippedCount: skipped,
          ));
    });

    var photosWritten = 0;
    for (final e in contents.photos.entries) {
      final f = File(p.joinAll([documentsDir.path, ...p.posix.split(e.key)]));
      if (await f.exists() && sha256.convert(await f.readAsBytes()).toString() == sha256.convert(e.value).toString()) {
        continue;
      }
      await f.parent.create(recursive: true);
      await f.writeAsBytes(e.value, flush: true);
      photosWritten++;
    }
    return RestoreResult(
        inserted: inserted, updated: updated, skipped: skipped, photosWritten: photosWritten);
  }

  Future<void> _checkCodeConflicts(BackupContents contents, String table) async {
    final rows = contents.tables[table] ?? const [];
    final conflicts = <String>[];
    for (final r in rows) {
      final local = await db
          .customSelect('SELECT id FROM "$table" WHERE code = ?', variables: [Variable<Object>(r['code'])])
          .getSingleOrNull();
      if (local != null && local.data['id'] != r['id']) conflicts.add('${r['code']}');
    }
    if (conflicts.isNotEmpty) {
      throw BackupException(BackupError.codeConflict, conflicts.join(', '));
    }
  }

  static Variable<Object> _variable(Object? v) => Variable<Object>(v);
}

class BackupContents {
  const BackupContents({
    required this.backupId,
    required this.createdAt,
    required this.schemaVersion,
    required this.tables,
    required this.photos,
  });
  final String backupId;
  final DateTime createdAt;
  final int schemaVersion;
  final Map<String, List<Map<String, Object?>>> tables;
  final Map<String, Uint8List> photos;
}

class RestoreResult {
  const RestoreResult(
      {required this.inserted, required this.updated, required this.skipped, required this.photosWritten});
  final int inserted;
  final int updated;
  final int skipped;
  final int photosWritten;
}

enum BackupError { notABackup, unsupportedVersion, corrupted, alreadyImported, codeConflict }

class BackupException implements Exception {
  BackupException(this.error, this.detail);
  final BackupError error;
  final String detail;

  @override
  String toString() => 'BackupException(${error.name}): $detail';
}
