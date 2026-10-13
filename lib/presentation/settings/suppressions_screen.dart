import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../data/database/app_database.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

final _suppressionsProvider =
    StreamProvider<List<SuggestionSuppressionRow>>((ref) => ref.watch(reminderRepoProvider).watchSuppressions());

/// Suggestion types the user switched off ("disable similar suggestions").
class SuppressionsScreen extends ConsumerWidget {
  const SuppressionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final codes = ref.watch(beetleCodesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsSuppressions)),
      body: AsyncView(
        value: ref.watch(_suppressionsProvider),
        data: (list) => list.isEmpty
            ? EmptyState(icon: Icons.notifications_active_outlined, title: l.commonNone)
            : ListView(children: [
                for (final s in list)
                  ListTile(
                    leading: const Icon(Icons.notifications_off_outlined),
                    title: Text(l.eventType(s.eventType)),
                    subtitle: Text(s.beetleId == null ? l.suppressionAllBeetles : (codes[s.beetleId] ?? s.beetleId!)),
                    trailing: IconButton(
                      icon: const Icon(Icons.undo),
                      onPressed: () => ref.read(reminderRepoProvider).removeSuppression(s.id),
                    ),
                  ),
              ]),
      ),
    );
  }
}
