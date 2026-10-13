import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../../domain/models/enums.dart';
import 'labels.dart';
import 'widgets.dart';

IconData timelineIcon(TimelineType t) => switch (t) {
      TimelineType.weight => Icons.monitor_weight_outlined,
      TimelineType.observation => Icons.visibility_outlined,
      TimelineType.substrate => Icons.grass_outlined,
      TimelineType.container => Icons.inventory_2_outlined,
      TimelineType.lifeStage => Icons.change_circle_outlined,
      TimelineType.temperature => Icons.thermostat_outlined,
    };

/// One history row. Long-press deletes (tombstones) after confirmation.
class TimelineTile extends StatelessWidget {
  const TimelineTile({super.key, required this.entry, this.showBeetle = true, this.onDelete});
  final TimelineEntry entry;
  final bool showBeetle;
  final VoidCallback? onDelete;

  String _summary(BuildContext context) {
    final l = context.l10n;
    final e = entry;
    return switch (e.type) {
      TimelineType.weight => Fmt.grams(e.num1),
      TimelineType.observation => [
          l.observation(ObservationCategory.values.asNameMap()[e.text1] ?? ObservationCategory.general),
          if (e.text2 != null) e.text2!,
        ].join(' · '),
      TimelineType.substrate => [
          if (e.text1 != null) e.text1!,
          if (e.text2 != null) e.text2!,
          if (e.num1 != null) Fmt.liters(e.num1),
          if (e.num2 != null) Fmt.grams(e.num2),
        ].join(' · '),
      TimelineType.container => '${Fmt.liters(e.num1)} → ${Fmt.liters(e.num2)}',
      TimelineType.lifeStage => l.stage(
          LifeStage.values.asNameMap()[e.text1], L3Phase.values.asNameMap()[e.text2]),
      TimelineType.temperature => '${e.text1 ?? ''} · ${Fmt.celsius(e.num1)}',
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: t.colorScheme.secondaryContainer,
        child: Icon(timelineIcon(entry.type), color: t.colorScheme.onSecondaryContainer, size: 20),
      ),
      title: Text(_summary(context), maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text([
        if (showBeetle && entry.beetleCode != null) entry.beetleCode!,
        l.timelineType(entry.type),
        Fmt.of(context).dateTime(entry.at),
      ].join(' · ')),
      onTap: entry.beetleId != null && showBeetle ? () => context.push(AppRoutes.beetle(entry.beetleId!)) : null,
      onLongPress: onDelete,
    );
  }
}

class BeetleCard extends StatelessWidget {
  const BeetleCard({super.key, required this.beetle});
  final BeetleSummary beetle;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    final b = beetle;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.beetle(b.id)),
        child: Padding(
          padding: const EdgeInsets.all(Insets.m),
          child: Row(children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: t.colorScheme.primaryContainer,
              child: Text(b.speciesCode,
                  style: t.textTheme.labelMedium?.copyWith(color: t.colorScheme.onPrimaryContainer)),
            ),
            const SizedBox(width: Insets.m),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(b.code, style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(width: Insets.s),
                  Text(l.sex(b.sex), style: t.textTheme.bodySmall),
                  if (b.status != BeetleStatus.active) ...[
                    const SizedBox(width: Insets.s),
                    Pill(l.beetleStatus(b.status), color: t.colorScheme.outline),
                  ],
                ]),
                const SizedBox(height: 2),
                Text('${l.stage(b.stage, b.l3Phase)} · ${b.speciesCommonName ?? b.speciesName}',
                    style: t.textTheme.bodySmall?.copyWith(color: t.colorScheme.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ]),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(Fmt.grams(b.latestWeightGrams), style: t.textTheme.titleMedium),
              if (b.latestWeightAt != null)
                Text(Fmt.of(context).shortDate(b.latestWeightAt!), style: t.textTheme.bodySmall),
            ]),
          ]),
        ),
      ),
    );
  }
}

Color severityColor(BuildContext context, Severity? s) {
  final c = Theme.of(context).colorScheme;
  return switch (s) {
    Severity.alert => c.error,
    Severity.warning => Colors.orange.shade700,
    Severity.observation => c.tertiary,
    Severity.info || null => c.primary,
  };
}

/// Compact reminder row used by dashboard, beetle detail and reminders list.
class ReminderTile extends StatelessWidget {
  const ReminderTile({super.key, required this.reminder, this.beetleCode, this.onTap, this.trailing});
  final ReminderRow reminder;
  final String? beetleCode;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final r = reminder;
    final overdue = r.dueAt.isBefore(DateTime.now()) &&
        (r.status == ReminderStatus.confirmed || r.status == ReminderStatus.scheduled);
    return ListTile(
      onTap: onTap,
      leading: Icon(
        r.source == ReminderSource.ai
            ? Icons.auto_awesome
            : r.source == ReminderSource.rule
                ? Icons.rule
                : Icons.alarm,
        color: severityColor(context, r.severity),
      ),
      title: Text(r.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text([
        if (beetleCode != null) beetleCode!,
        Fmt.of(context).dateTime(r.dueAt),
        l.reminderStatus(r.status),
        if (overdue) l.reminderOverdue,
      ].join(' · ')),
      trailing: trailing,
    );
  }
}

/// Weight-over-time chart. X axis is real time (not record index), so uneven
/// measurement intervals are shown honestly.
class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.series, this.height = 220});

  /// label → points (time, grams)
  final Map<String, List<(DateTime, double)>> series;
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final all = series.values.expand((e) => e).toList();
    if (all.isEmpty) {
      return SizedBox(height: 80, child: Center(child: Text(context.l10n.analyticsNoData)));
    }
    final origin = all.map((e) => e.$1).reduce((a, b) => a.isBefore(b) ? a : b);
    double x(DateTime d) => d.difference(origin).inMinutes / (60 * 24);
    final palette = [
      t.colorScheme.primary,
      t.colorScheme.tertiary,
      Colors.orange.shade700,
      Colors.blue.shade600,
      Colors.pink.shade400,
      Colors.teal.shade600,
    ];
    final entries = series.entries.toList();
    final maxX = all.map((e) => x(e.$1)).reduce((a, b) => a > b ? a : b);
    final fmt = Fmt.of(context);
    return Column(children: [
      SizedBox(
        height: height,
        child: LineChart(LineChartData(
          minX: 0,
          maxX: maxX <= 0 ? 1 : maxX,
          gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => FlLine(color: t.dividerColor.withValues(alpha: 0.3), strokeWidth: 1)),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40, getTitlesWidget: (v, m) => Text(Fmt.number(v), style: t.textTheme.labelSmall))),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: maxX <= 0 ? 1 : (maxX / 4).clamp(1, double.infinity),
                getTitlesWidget: (v, m) => Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(fmt.shortDate(origin.add(Duration(minutes: (v * 24 * 60).round()))),
                      style: t.textTheme.labelSmall),
                ),
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => [
                for (final s in spots)
                  LineTooltipItem(
                    '${entries[s.barIndex].key}\n${Fmt.grams(s.y)}',
                    TextStyle(color: palette[s.barIndex % palette.length], fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            for (final (i, e) in entries.indexed)
              LineChartBarData(
                spots: [for (final p in e.value) FlSpot(x(p.$1), p.$2)],
                color: palette[i % palette.length],
                barWidth: 2.5,
                isCurved: false,
                dotData: const FlDotData(show: true),
              ),
          ],
        )),
      ),
      if (entries.length > 1)
        Padding(
          padding: const EdgeInsets.only(top: Insets.s),
          child: Wrap(spacing: Insets.m, runSpacing: Insets.xs, children: [
            for (final (i, e) in entries.indexed)
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 10, height: 10, color: palette[i % palette.length]),
                const SizedBox(width: 4),
                Text(e.key, style: t.textTheme.labelSmall),
              ]),
          ]),
        ),
    ]);
  }
}
