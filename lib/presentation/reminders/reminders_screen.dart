import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import '../shell/home_shell.dart';
import 'reminder_actions_sheet.dart';
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
          // Unique tag: tab screens stay alive side by side in the shell.
          heroTag: 'fab-reminders',
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
            onTap: (r, code) => showReminderActions(context, ref, r),
          ),
          _ReminderList(value: ref.watch(closedRemindersProvider), empty: l.remindersEmptyHistory, newestFirst: true),
        ]),
      ),
    );
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
