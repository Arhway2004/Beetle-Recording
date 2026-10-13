import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../assistant/analysis_tile.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// Inspect and delete AI-generated analyses. Breeding records are never touched.
class AiMemoryScreen extends ConsumerWidget {
  const AiMemoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final codes = ref.watch(beetleCodesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsAiMemory), actions: [
        IconButton(
          icon: const Icon(Icons.delete_sweep_outlined),
          tooltip: l.aiMemoryDeleteAll,
          onPressed: () async {
            if (await confirmDialog(context,
                title: l.aiMemoryDeleteAll, message: l.aiMemoryDeleteConfirm, destructive: true)) {
              await ref.read(aiMemoryRepoProvider).deleteAllAnalyses();
            }
          },
        ),
      ]),
      body: AsyncView(
        value: ref.watch(analysesProvider(null)),
        data: (list) => list.isEmpty
            ? EmptyState(icon: Icons.psychology_outlined, title: l.aiMemoryEmpty, body: l.aiMemoryDeleteConfirm)
            : ListView(children: [for (final a in list) AnalysisTile(analysis: a, beetleCode: codes[a.beetleId])]),
      ),
    );
  }
}
