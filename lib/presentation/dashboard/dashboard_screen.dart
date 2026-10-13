import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
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
          final upcoming = ref.watch(activeRemindersProvider).valueOrNull ?? const [];
          final stats = ref.watch(sensorStatsProvider).valueOrNull ?? const [];
          final codes = ref.watch(beetleCodesProvider);
          final recent = ref.watch(timelineProvider((beetleId: null, type: null, limit: 6)));
          return ListView(
            padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.m, 96),
            children: [
              Row(children: [
                Expanded(child: StatTile(label: l.dashboardActiveBeetles, value: '${active.length}', icon: Icons.bug_report_outlined, onTap: () => context.go(AppRoutes.beetles))),
                const SizedBox(width: Insets.s),
                Expanded(
                    child: StatTile(
                        label: l.dashboardPendingSuggestions,
                        value: '${suggested.length}',
                        icon: Icons.rule,
                        onTap: () => context.go(AppRoutes.reminders))),
              ]),
              for (final s in stats.where((s) => s.latestOutOfRange))
                Padding(
                  padding: const EdgeInsets.only(top: Insets.s),
                  child: Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: ListTile(
                      leading: const Icon(Icons.thermostat),
                      title: Text(l.dashboardTemperatureAlert(s.sensor.name, Fmt.number(s.latest!.celsius))),
                      subtitle: Text('${l.basisMeasured} · ${Fmt.of(context).dateTime(s.latest!.recordedAt)}'),
                    ),
                  ),
                ),
              const SizedBox(height: Insets.m),
              SectionCard(
                title: l.dashboardUpcoming,
                trailing: TextButton(onPressed: () => context.go(AppRoutes.reminders), child: Text(l.navReminders)),
                padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
                child: upcoming.isEmpty
                    ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.dashboardNoUpcoming))
                    : Column(children: [
                        for (final r in upcoming.take(5))
                          ReminderTile(reminder: r, beetleCode: codes[r.beetleId]),
                      ]),
              ),
              const SizedBox(height: Insets.m),
              SectionCard(
                title: l.dashboardBySpecies,
                child: Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
                  for (final e in bySpecies.entries) Chip(label: Text('${e.key} · ${e.value}')),
                ]),
              ),
              const SizedBox(height: Insets.m),
              SectionCard(
                title: l.dashboardByStage,
                child: Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
                  for (final e in byStage.entries) Chip(label: Text('${l.stage(e.key)} · ${e.value}')),
                ]),
              ),
              const SizedBox(height: Insets.m),
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
