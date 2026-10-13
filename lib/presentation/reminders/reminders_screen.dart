import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import '../shell/home_shell.dart';
import 'reminder_review_sheet.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final suggested = ref.watch(suggestedRemindersProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: topLevelAppBar(context, l.navReminders,
            bottom: TabBar(tabs: [
              Tab(text: '${l.remindersTabSuggested}${(suggested.valueOrNull?.isNotEmpty ?? false) ? ' (${suggested.value!.length})' : ''}'),
              Tab(text: l.remindersTabUpcoming),
              Tab(text: l.remindersTabHistory),
            ])),
        floatingActionButton: FloatingActionButton(
          tooltip: l.reminderNew,
          onPressed: () => context.push(AppRoutes.newReminder()),
          child: const Icon(Icons.add_alarm),
        ),
        body: TabBarView(children: [
          _ReminderList(
            value: suggested,
            empty: l.remindersEmptySuggested,
            onTap: (r, code) => showSuggestionReviewSheet(context, ref, r, beetleCode: code),
          ),
          _ReminderList(
            value: ref.watch(activeRemindersProvider),
            empty: l.remindersEmptyUpcoming,
            onTap: (r, code) => _activeActions(context, ref, r),
          ),
          _ReminderList(value: ref.watch(closedRemindersProvider), empty: l.remindersEmptyHistory, newestFirst: true),
        ]),
      ),
    );
  }

  Future<void> _activeActions(BuildContext context, WidgetRef ref, ReminderRow r) async {
    final l = context.l10n;
    final actions = ref.read(reminderActionsProvider);
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(title: Text(r.title), subtitle: Text(r.message)),
          const Divider(),
          ListTile(leading: const Icon(Icons.check_circle_outline), title: Text(l.reminderComplete), onTap: () => Navigator.pop(ctx, 'done')),
          for (final d in [1, 3, 7])
            ListTile(leading: const Icon(Icons.snooze), title: Text(l.reminderPostponeDays(d)), onTap: () => Navigator.pop(ctx, 'p$d')),
          ListTile(leading: const Icon(Icons.cancel_outlined), title: Text(l.reminderCancel), onTap: () => Navigator.pop(ctx, 'cancel')),
        ]),
      ),
    );
    if (choice == null) return;
    try {
      if (choice == 'done') {
        await actions.complete(r.id);
      } else if (choice == 'cancel') {
        await actions.cancel(r.id);
      } else {
        final days = int.parse(choice.substring(1));
        final base = r.dueAt.isBefore(DateTime.now()) ? DateTime.now() : r.dueAt;
        final res = await actions.postpone(r.id, base.add(Duration(days: days)));
        if (context.mounted) reportReconcile(context, res);
      }
    } catch (e) {
      if (context.mounted) showSnack(context, '$e');
    }
  }
}

class _ReminderList extends ConsumerWidget {
  const _ReminderList({required this.value, required this.empty, this.onTap, this.newestFirst = false});
  final AsyncValue<List<ReminderRow>> value;
  final String empty;
  final void Function(ReminderRow, String?)? onTap;
  final bool newestFirst;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codes = ref.watch(beetleCodesProvider);
    final l = context.l10n;
    return AsyncView(
      value: value,
      data: (list) {
        if (list.isEmpty) return EmptyState(icon: Icons.notifications_none, title: empty);
        final items = newestFirst ? list.reversed.toList() : list;
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 96, top: Insets.s),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
          itemBuilder: (_, i) {
            final r = items[i];
            return ReminderTile(
              reminder: r,
              beetleCode: codes[r.beetleId],
              onTap: onTap == null ? null : () => onTap!(r, codes[r.beetleId]),
              trailing: r.status == ReminderStatus.suggested
                  ? Pill(l.basis(SuggestionBasis.fromWire(r.basis)),
                      color: r.source == ReminderSource.ai ? Theme.of(context).colorScheme.hypothesis : null)
                  : null,
            );
          },
        );
      },
    );
  }
}
