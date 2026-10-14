import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/models.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import '../shell/home_shell.dart';

class RecordsScreen extends ConsumerStatefulWidget {
  const RecordsScreen({super.key});

  @override
  ConsumerState<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends ConsumerState<RecordsScreen> {
  TimelineType? _type;

  Future<void> _add() async {
    final l = context.l10n;
    final type = await showModalBottomSheet<TimelineType>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.s),
            child: Text(l.chooseRecordType, style: Theme.of(ctx).textTheme.titleMedium),
          ),
          for (final t in TimelineType.values)
            ListTile(leading: Icon(timelineIcon(t)), title: Text(l.timelineType(t)), onTap: () => Navigator.pop(ctx, t)),
        ]),
      ),
    );
    if (type != null && mounted) await context.push(AppRoutes.newRecord(type));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final timeline = ref.watch(timelineProvider((beetleId: null, type: _type, limit: 300)));
    return Scaffold(
      appBar: topLevelAppBar(context, l.navRecords),
      floatingActionButton: FloatingActionButton.extended(
        // Unique tag: tab screens stay alive side by side in the shell.
        heroTag: 'fab-records',
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: Text(l.recordsAdd),
      ),
      body: Column(children: [
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.s),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Insets.s),
                child: ChoiceChip(
                    label: Text(l.commonAll), selected: _type == null, onSelected: (_) => setState(() => _type = null)),
              ),
              for (final t in TimelineType.values)
                Padding(
                  padding: const EdgeInsets.only(right: Insets.s),
                  child: ChoiceChip(
                    avatar: Icon(timelineIcon(t), size: 16),
                    label: Text(l.timelineType(t)),
                    selected: _type == t,
                    onSelected: (_) => setState(() => _type = t),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: AsyncView(
            value: timeline,
            data: (entries) => entries.isEmpty
                ? EmptyState(icon: Icons.timeline, title: l.recordsEmpty)
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 96),
                    itemCount: entries.length,
                    itemBuilder: (_, i) => TimelineTile(
                      entry: entries[i],
                      onDelete: () async {
                        if (await confirmDialog(context,
                            title: l.commonDeleteConfirmTitle, message: l.commonDeleteRecordMessage, destructive: true)) {
                          await ref.read(beetleRepoProvider).deleteRecord(entries[i].type, entries[i].id);
                        }
                      },
                    ),
                  ),
          ),
        ),
      ]),
    );
  }
}
