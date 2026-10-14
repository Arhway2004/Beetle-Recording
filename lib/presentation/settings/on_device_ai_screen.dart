import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/enums.dart';
import '../../infrastructure/ai/model_store.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// Download, verify and delete the on-device model, and switch the on-device
/// provider on or off. Nothing here sends breeding data anywhere.
class OnDeviceAiScreen extends ConsumerStatefulWidget {
  const OnDeviceAiScreen({super.key});

  @override
  ConsumerState<OnDeviceAiScreen> createState() => _OnDeviceAiScreenState();
}

class _OnDeviceAiScreenState extends ConsumerState<OnDeviceAiScreen> {
  final _model = defaultOnDeviceModel;
  ModelFileState? _state;
  ModelDownloadProgress? _progress;
  ModelDownloadCancel? _cancel;
  StreamSubscription<ModelDownloadProgress>? _sub;

  ModelStore get _store => ref.read(modelStoreProvider);

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _cancel?.cancel();
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    final s = await _store.state(_model);
    if (mounted) setState(() => _state = s);
  }

  void _download() {
    final l = context.l10n;
    final cancel = ModelDownloadCancel();
    setState(() {
      _cancel = cancel;
      _progress = ModelDownloadProgress(0, _model.sizeBytes);
    });
    _sub = _store.download(_model, cancel: cancel).listen(
      (p) => setState(() => _progress = p),
      onError: (Object e) {
        if (!mounted) return;
        setState(() => _progress = null);
        if (e is ModelStoreException && e.error != ModelStoreError.cancelled) {
          showSnack(context, switch (e.error) {
            ModelStoreError.checksum => l.onDeviceErrorChecksum,
            ModelStoreError.diskFull => l.onDeviceErrorDiskFull,
            _ => l.onDeviceErrorNetwork,
          });
        }
        _refresh();
      },
      onDone: () {
        if (!mounted) return;
        setState(() => _progress = null);
        ref.invalidate(aiProvidersProvider);
        _refresh();
      },
      cancelOnError: true,
    );
  }

  Future<void> _delete() async {
    final l = context.l10n;
    if (!await confirmDialog(context, title: l.onDeviceDelete, message: l.onDeviceDeleteConfirm, destructive: true)) {
      return;
    }
    await ref.read(onDeviceRuntimeProvider).unload();
    await ref.read(settingsRepoProvider).updateProvider(AiProviderKind.mobile, enabled: false);
    await _store.delete(_model);
    ref.invalidate(aiProvidersProvider);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    final rows = ref.watch(providerSettingsProvider).valueOrNull ?? const [];
    final enabled = rows.where((r) => r.provider == AiProviderKind.mobile).firstOrNull?.enabled ?? false;
    final ready = _state == ModelFileState.ready;
    final progress = _progress;
    final sizeGb = '${(_model.sizeBytes / 1e9).toStringAsFixed(1)} GB';

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsMobileAi)),
      body: ListView(padding: const EdgeInsets.all(Insets.m), children: [
        Text(l.onDeviceIntro(_model.displayName)),
        const SizedBox(height: Insets.s),
        Text(l.onDeviceExperimental, style: t.textTheme.bodySmall?.copyWith(color: t.colorScheme.tertiary)),
        const SizedBox(height: Insets.l),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text(l.settingsEnabled),
          subtitle: ready ? null : Text(l.onDeviceNeedsModel),
          value: enabled && ready,
          onChanged: ready
              ? (v) async {
                  await ref.read(settingsRepoProvider).updateProvider(AiProviderKind.mobile, enabled: v);
                  if (!v) await ref.read(onDeviceRuntimeProvider).unload();
                  ref.invalidate(aiProvidersProvider);
                }
              : null,
        ),
        const Divider(height: Insets.l),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.memory),
          title: Text(_model.displayName),
          subtitle: Text('$sizeGb · ${_model.license}'),
        ),
        if (_state == null)
          const LinearProgressIndicator()
        else if (progress != null) ...[
          LinearProgressIndicator(value: progress.verifying ? null : progress.fraction),
          const SizedBox(height: Insets.s),
          Text(progress.verifying ? l.onDeviceVerifying : l.onDeviceDownloading((progress.fraction * 100).floor())),
          const SizedBox(height: Insets.s),
          if (!progress.verifying)
            OutlinedButton.icon(
              onPressed: () => _cancel?.cancel(),
              icon: const Icon(Icons.pause),
              label: Text(l.commonCancel),
            ),
        ] else if (ready) ...[
          Row(children: [
            Icon(Icons.check_circle, color: t.colorScheme.primary),
            const SizedBox(width: Insets.s),
            Expanded(child: Text(l.onDeviceReady)),
          ]),
          const SizedBox(height: Insets.m),
          OutlinedButton.icon(
            onPressed: _delete,
            icon: const Icon(Icons.delete_outline),
            label: Text(l.onDeviceDelete),
          ),
        ] else ...[
          Text(l.onDeviceDownloadHint(sizeGb), style: t.textTheme.bodySmall),
          const SizedBox(height: Insets.m),
          FilledButton.icon(
            onPressed: _download,
            icon: const Icon(Icons.download),
            label: Text(_state == ModelFileState.partial ? l.onDeviceResume : l.onDeviceDownload),
          ),
        ],
      ]),
    );
  }
}
