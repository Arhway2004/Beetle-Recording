import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../../domain/models/enums.dart';
import '../../domain/reminders/care_agenda.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import '../reminders/reminder_actions_sheet.dart';
import '../shell/home_shell.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final beetles = ref.watch(beetlesProvider);
    return Scaffold(
      appBar: topLevelAppBar(context, l.appTitle, actions: [
        IconButton(
            icon: const Icon(Icons.insights_outlined),
            tooltip: l.navAnalytics,
            onPressed: () => context.go(AppRoutes.analytics)),
        IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l.navSettings,
            onPressed: () => context.go(AppRoutes.settings)),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.newBeetle),
        icon: const Icon(Icons.add),
        label: Text(l.dashboardAddBeetle),
      ),
      body: AsyncView(
        value: beetles,
        onRetry: () => ref.invalidate(beetlesProvider),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.bug_report_outlined,
              graphic: const AppLogo(size: 96),
              title: l.dashboardEmptyTitle,
              body: l.dashboardEmptyBody,
              action: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.newBeetle),
                icon: const Icon(Icons.add),
                label: Text(l.dashboardAddBeetle),
              ),
            );
          }
          final active = list.where((b) => b.status == BeetleStatus.active).toList();
          final bySpecies = <String, int>{};
          final byStage = <LifeStage?, int>{};
          for (final b in active) {
            bySpecies[b.speciesCode] = (bySpecies[b.speciesCode] ?? 0) + 1;
            byStage[b.stage] = (byStage[b.stage] ?? 0) + 1;
          }
          final suggested = ref.watch(suggestedRemindersProvider).valueOrNull ?? const [];
          final active_ = ref.watch(activeRemindersProvider);
          final stats = ref.watch(sensorStatsProvider).valueOrNull ?? const [];
          final codes = ref.watch(beetleCodesProvider);
          final recent = ref.watch(timelineProvider((beetleId: null, type: null, limit: 6)));
          final alerts = stats.where((s) => s.latestOutOfRange).toList();
          final agenda = CareAgenda.of(active_.valueOrNull ?? const <ReminderRow>[], (r) => r.dueAt, now: DateTime.now());
          final t = Theme.of(context);

          Widget task(ReminderRow r) => ReminderTile(
                reminder: r,
                beetleCode: codes[r.beetleId],
                onTap: () => showReminderActions(context, ref, r),
                trailing: IconButton(
                  icon: const Icon(Icons.check_circle_outline),
                  tooltip: l.reminderMarkDone,
                  onPressed: () => ref.read(reminderActionsProvider).complete(r.id).catchError((Object e) {
                    debugPrint('complete failed: $e');
                    if (context.mounted) showSnack(context, l.commonActionFailed);
                  }),
                ),
              );

          final needsAttention = alerts.isNotEmpty || agenda.overdue.isNotEmpty || suggested.isNotEmpty;
          return ListView(
            padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.m, 96),
            children: [
              // 1. Needs attention: measured alerts, overdue tasks, suggestions to review.
              if (needsAttention) ...[
                SectionCard(
                  title: l.dashboardNeedsAttention,
                  padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
                  child: Column(children: [
                    for (final s in alerts)
                      ListTile(
                        leading: Icon(Icons.thermostat, color: t.colorScheme.error),
                        title: Text(l.dashboardTemperatureAlert(s.sensor.name, Fmt.number(s.latest!.celsius))),
                        subtitle: Text('${l.basisMeasured} · ${Fmt.of(context).dateTime(s.latest!.recordedAt)}'),
                      ),
                    if (agenda.overdue.isNotEmpty) ...[
                      _GroupLabel(l.dashboardOverdueCount(agenda.overdue.length), color: t.colorScheme.error),
                      for (final r in agenda.overdue.take(5)) task(r),
                    ],
                    if (suggested.isNotEmpty)
                      ListTile(
                        leading: Icon(Icons.rule, color: t.colorScheme.tertiary),
                        title: Text(l.dashboardSuggestionsToReview(suggested.length)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.go(AppRoutes.reminders),
                      ),
                  ]),
                ),
                const SizedBox(height: Insets.m),
              ],
              // 2. Today's care, then the next 7 days.
              SectionCard(
                title: l.dashboardToday,
                trailing: TextButton(onPressed: () => context.go(AppRoutes.reminders), child: Text(l.navReminders)),
                padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
                child: AsyncView(
                  value: active_,
                  onRetry: () => ref.invalidate(activeRemindersProvider),
                  data: (_) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    if (agenda.today.isEmpty)
                      ListTile(
                        leading: Icon(Icons.check_circle, color: t.colorScheme.primary),
                        title: Text(l.dashboardAllClear),
                      )
                    else
                      for (final r in agenda.today) task(r),
                    if (agenda.soon.isNotEmpty) ...[
                      _GroupLabel(l.dashboardSoon),
                      for (final r in agenda.soon.take(5)) task(r),
                    ],
                  ]),
                ),
              ),
              const SizedBox(height: Insets.m),
              // 3. Quick record: the two most common records first.
              SectionCard(
                title: l.dashboardQuickRecord,
                child: Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
                  for (final type in const [TimelineType.weight, TimelineType.lifeStage, TimelineType.observation])
                    FilledButton.tonalIcon(
                      onPressed: () => context.push(AppRoutes.newRecord(type)),
                      icon: Icon(timelineIcon(type), size: 18),
                      label: Text(l.timelineType(type)),
                    ),
                ]),
              ),
              const SizedBox(height: Insets.m),
              // 4. Collection summary.
              SectionCard(
                title: l.dashboardCollection,
                trailing: TextButton(onPressed: () => context.go(AppRoutes.beetles), child: Text(l.navBeetles)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${active.length}', style: t.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700)),
                  Text(l.dashboardActiveBeetles, style: t.textTheme.bodySmall),
                  const SizedBox(height: Insets.m),
                  Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
                    for (final e in bySpecies.entries) Chip(label: Text('${e.key} · ${e.value}')),
                    for (final e in byStage.entries)
                      Chip(avatar: const Icon(Icons.change_circle_outlined, size: 16), label: Text('${l.stage(e.key)} · ${e.value}')),
                  ]),
                ]),
              ),
              const SizedBox(height: Insets.m),
              // 5. Recent activity.
              SectionCard(
                title: l.dashboardRecent,
                trailing: TextButton(onPressed: () => context.go(AppRoutes.records), child: Text(l.navRecords)),
                padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
                child: AsyncView(
                  value: recent,
                  data: (entries) => entries.isEmpty
                      ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.recordsEmpty))
                      : Column(children: [for (final e in entries) TimelineTile(entry: e)]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Small heading inside a section, e.g. "3 overdue" or "Next 7 days".
class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text, {this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.m, 0),
        child: Text(text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color ?? Theme.of(context).colorScheme.outline)),
      );
}

