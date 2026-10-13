import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../infrastructure/backup/backup_service.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _busy = false;

  Future<void> _export() async {
    setState(() => _busy = true);
    try {
      final dir = await getTemporaryDirectory();
      final file = await ref.read(backupServiceProvider).exportToFile(dir);
      if (!mounted) return;
      final box = context.findRenderObject() as RenderBox?;
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path, mimeType: 'application/zip')],
        sharePositionOrigin: box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      ));
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _import() async {
    final l = context.l10n;
    final picked = await FilePicker.pickFiles(type: FileType.any, withData: false);
    final path = picked?.files.single.path;
    if (path == null || !mounted) return;
    if (!await confirmDialog(context, title: l.backupImport, message: l.backupRestoreConfirm)) return;
    setState(() => _busy = true);
    try {
      final r = await ref.read(backupServiceProvider).restore(await File(path).readAsBytes());
      await ref.read(reminderSchedulerProvider).reconcile();
      if (mounted) showSnack(context, l.backupRestored(r.inserted, r.updated, r.skipped));
    } on BackupException catch (e) {
      if (!mounted) return;
      showSnack(
          context,
          switch (e.error) {
            BackupError.notABackup => l.backupErrorNotBackup,
            BackupError.unsupportedVersion => l.backupErrorVersion,
            BackupError.corrupted => l.backupErrorCorrupted,
            BackupError.alreadyImported => l.backupErrorAlready,
            BackupError.codeConflict => l.backupErrorConflict(e.detail),
          });
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsBackup)),
      body: ListView(padding: const EdgeInsets.all(Insets.m), children: [
        if (_busy) const LinearProgressIndicator(),
        ListTile(
          leading: const Icon(Icons.upload_file),
          title: Text(l.backupExport),
          subtitle: Text(l.backupExportHelper),
          onTap: _busy ? null : _export,
        ),
        ListTile(
          leading: const Icon(Icons.restore),
          title: Text(l.backupImport),
          subtitle: Text(l.backupRestoreConfirm),
          onTap: _busy ? null : _import,
        ),
      ]),
    );
  }
}
