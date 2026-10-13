import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../core/utils/ids.dart';
import '../../data/database/app_database.dart';
import '../../domain/models/enums.dart';

/// Stores photos as files under `<documents>/photos/` and their metadata in
/// `photo_attachments`. Paths in the database are relative so backups and
/// restores work across devices.
class PhotoStore {
  PhotoStore(this.db, this.rootDir);

  final AppDatabase db;
  final Directory rootDir;

  static const folder = 'photos';

  File fileFor(String relativePath) => File(p.join(rootDir.path, relativePath));

  Future<String> addPhoto({
    required File source,
    required PhotoOwnerType ownerType,
    required String ownerId,
    String? beetleId,
    DateTime? takenAt,
    String? caption,
  }) async {
    final bytes = await source.readAsBytes();
    final ext = p.extension(source.path).toLowerCase();
    final id = newId();
    final relative = p.join(folder, '$id${ext.isEmpty ? '.jpg' : ext}');
    final dest = fileFor(relative);
    await dest.parent.create(recursive: true);
    await dest.writeAsBytes(bytes, flush: true);
    await db.into(db.photoAttachments).insert(PhotoAttachmentsCompanion.insert(
          id: Value(id),
          ownerType: ownerType,
          ownerId: ownerId,
          beetleId: Value(beetleId),
          relativePath: relative,
          sha256: sha256.convert(bytes).toString(),
          takenAt: (takenAt ?? DateTime.now()).toUtc(),
          caption: Value(caption),
        ));
    return id;
  }

  Stream<List<PhotoAttachmentRow>> watchForBeetle(String beetleId) => (db.select(db.photoAttachments)
        ..where((x) => x.beetleId.equals(beetleId) & x.deletedAt.isNull())
        ..orderBy([(x) => OrderingTerm.desc(x.takenAt)]))
      .watch();

  /// Tombstones the record and removes the file.
  Future<void> deletePhoto(String id) async {
    final row = await (db.select(db.photoAttachments)..where((x) => x.id.equals(id))).getSingle();
    await (db.update(db.photoAttachments)..where((x) => x.id.equals(id))).write(
        PhotoAttachmentsCompanion(
            deletedAt: Value(nowUtc()), updatedAt: Value(nowUtc()), revision: Value(row.revision + 1)));
    final f = fileFor(row.relativePath);
    if (await f.exists()) await f.delete();
  }
}
