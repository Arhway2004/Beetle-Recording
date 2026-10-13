import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../../domain/growth/growth_metrics.dart';
import '../../domain/models/enums.dart';
import '../assistant/analysis_tile.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';
import '../shell/home_shell.dart';

final _readings7dProvider = StreamProvider.family<List<TemperatureRecordRow>, String>((ref, sensorId) =>
    ref.watch(temperatureRepoProvider).watchReadings(sensorId, since: DateTime.now().toUtc().subtract(const Duration(days: 7))));

final _substrateHistoryProvider =
    StreamProvider<List<SubstrateChangeRow>>((ref) => ref.watch(beetleRepoProvider).watchAllSubstrateChanges());

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  final _selected = <String>{};
  String? _speciesId;
  Sex? _sex;
  LifeStage? _stage;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final beetles = ref.watch(beetlesProvider);
    return Scaffold(
      appBar: topLevelAppBar(context, l.navAnalytics),
      body: AsyncView(
        value: beetles,
        data: (all) {
          if (all.isEmpty) return EmptyState(icon: Icons.insights_outlined, title: l.analyticsNoData);
          return ListView(
            padding: const EdgeInsets.fromLTRB(Insets.m, Insets.s, Insets.m, Insets.xl),
            children: [
              Text(l.analyticsCorrelationNote, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: Insets.m),
              _counts(context, all),
              const SizedBox(height: Insets.m),
              _comparison(context, all),
              const SizedBox(height: Insets.m),
              _recentMeasurements(context),
              const SizedBox(height: Insets.m),
              _temperatures(context),
              const SizedBox(height: Insets.m),
              _substrate(context),
              const SizedBox(height: Insets.m),
              _aiHistory(context),
            ],
          );
        },
      ),
    );
  }

  Widget _counts(BuildContext context, List<BeetleSummary> all) {
    final l = context.l10n;
    final active = all.where((b) => b.status == BeetleStatus.active);
    final bySpecies = <String, int>{};
    final byStage = <String, int>{};
    for (final b in active) {
      bySpecies[b.speciesCode] = (bySpecies[b.speciesCode] ?? 0) + 1;
      byStage[l.stage(b.stage)] = (byStage[l.stage(b.stage)] ?? 0) + 1;
    }
    Widget bars(Map<String, int> m) {
      final max = m.values.fold(1, (a, b) => a > b ? a : b);
      return Column(children: [
        for (final e in m.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(children: [
              SizedBox(width: 90, child: Text(e.key, overflow: TextOverflow.ellipsis)),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: e.value / max, minHeight: 10),
                ),
              ),
              SizedBox(width: 32, child: Text('${e.value}', textAlign: TextAlign.end)),
            ]),
          ),
      ]);
    }

    return SectionCard(
      title: '${l.dashboardActiveBeetles}: ${active.length}',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l.dashboardBySpecies, style: Theme.of(context).textTheme.labelLarge),
        bars(bySpecies),
        const SizedBox(height: Insets.m),
        Text(l.dashboardByStage, style: Theme.of(context).textTheme.labelLarge),
        bars(byStage),
      ]),
    );
  }

  Widget _comparison(BuildContext context, List<BeetleSummary> all) {
    final l = context.l10n;
    final species = ref.watch(speciesProvider).valueOrNull ?? const [];
    final weights = ref.watch(allWeightsProvider).valueOrNull ?? const {};
    final candidates = all
        .where((b) => BeetleFilter(speciesId: _speciesId, sex: _sex, stage: _stage).matches(b))
        .where((b) => (weights[b.id]?.isNotEmpty ?? false))
        .toList();
    final chosen = candidates.where((b) => _selected.contains(b.id)).toList();
    final shown = chosen.isEmpty ? candidates.take(3).toList() : chosen;
    return SectionCard(
      title: l.analyticsWeightComparison,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
          DropdownButton<String?>(
            value: _speciesId,
            hint: Text(l.filterSpecies),
            items: [
              DropdownMenuItem(value: null, child: Text('${l.filterSpecies}: ${l.commonAll}')),
              for (final s in species) DropdownMenuItem(value: s.id, child: Text(s.code)),
            ],
            onChanged: (v) => setState(() => _speciesId = v),
          ),
          DropdownButton<Sex?>(
            value: _sex,
            items: [
              DropdownMenuItem(value: null, child: Text('${l.filterSex}: ${l.commonAll}')),
              for (final s in Sex.values) DropdownMenuItem(value: s, child: Text(l.sex(s))),
            ],
            onChanged: (v) => setState(() => _sex = v),
          ),
          DropdownButton<LifeStage?>(
            value: _stage,
            items: [
              DropdownMenuItem(value: null, child: Text('${l.filterStage}: ${l.commonAll}')),
              for (final s in LifeStage.values) DropdownMenuItem(value: s, child: Text(l.stage(s))),
            ],
            onChanged: (v) => setState(() => _stage = v),
          ),
        ]),
        const SizedBox(height: Insets.s),
        Text(l.analyticsSelectBeetles, style: Theme.of(context).textTheme.labelSmall),
        Wrap(spacing: Insets.s, children: [
          for (final b in candidates)
            FilterChip(
              label: Text(b.code),
              selected: _selected.contains(b.id),
              onSelected: (v) => setState(() => v ? _selected.add(b.id) : _selected.remove(b.id)),
            ),
        ]),
        const SizedBox(height: Insets.m),
        WeightChart(series: {
          for (final b in shown) b.code: [for (final w in weights[b.id]!) (w.measuredAt, w.weightGrams)],
        }),
        const SizedBox(height: Insets.s),
        for (final b in shown)
          Builder(builder: (_) {
            final m = GrowthMetrics.compute(
                weights[b.id]!.map((w) => WeightPoint(id: w.id, measuredAt: w.measuredAt, grams: w.weightGrams)));
            return Text(
              '${b.code}: ${Fmt.grams(m.latest?.grams)} · ${l.detailMaxWeight} ${Fmt.grams(m.max?.grams)} · ${l.detailAvgWeekly} ${Fmt.signed(m.avgWeeklyChange, unit: ' g')}',
              style: Theme.of(context).textTheme.bodySmall,
            );
          }),
      ]),
    );
  }

  Widget _recentMeasurements(BuildContext context) {
    final l = context.l10n;
    final recent = ref.watch(timelineProvider((beetleId: null, type: TimelineType.weight, limit: 8)));
    return SectionCard(
      title: l.analyticsRecentMeasurements,
      padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
      child: AsyncView(
        value: recent,
        data: (e) => e.isEmpty
            ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.analyticsNoData))
            : Column(children: [for (final x in e) TimelineTile(entry: x)]),
      ),
    );
  }

  Widget _temperatures(BuildContext context) {
    final l = context.l10n;
    final stats = ref.watch(sensorStatsProvider).valueOrNull ?? const [];
    return SectionCard(
      title: l.analyticsTemperatureTrends,
      child: stats.isEmpty
          ? Text(l.noSensors)
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final s in stats) ...[
                Text(s.sensor.name, style: Theme.of(context).textTheme.titleSmall),
                Text(
                  l.analyticsMinMax(Fmt.number(s.latest?.celsius), Fmt.number(s.minC), Fmt.number(s.maxC)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  l.analyticsTarget(Fmt.number(s.sensor.targetC),
                      (s.sensor.minThresholdC == null && s.sensor.maxThresholdC == null)
                          ? l.commonNotSet
                          : '${Fmt.number(s.sensor.minThresholdC)} ~ ${Fmt.number(s.sensor.maxThresholdC)} °C'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: Insets.s),
                _TemperatureChart(sensor: s.sensor, readings: ref.watch(_readings7dProvider(s.sensor.id)).valueOrNull ?? const []),
                const SizedBox(height: Insets.m),
              ],
            ]),
    );
  }

  Widget _substrate(BuildContext context) {
    final l = context.l10n;
    final codes = ref.watch(beetleCodesProvider);
    final rows = ref.watch(_substrateHistoryProvider).valueOrNull ?? const [];
    final fmt = Fmt.of(context);
    return SectionCard(
      title: l.analyticsSubstrateHistory,
      padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
      child: rows.isEmpty
          ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.analyticsNoData))
          : Column(children: [
              for (final r in rows.take(15))
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.grass_outlined),
                  title: Text([codes[r.beetleId] ?? '', r.substrateType, r.brand, r.batch].whereType<String>().where((s) => s.isNotEmpty).join(' · ')),
                  subtitle: Text([fmt.date(r.changedAt), if (r.quantityLiters != null) Fmt.liters(r.quantityLiters), if (r.condition != null) r.condition!].join(' · ')),
                ),
            ]),
    );
  }

  Widget _aiHistory(BuildContext context) {
    final l = context.l10n;
    final analyses = ref.watch(analysesProvider(null)).valueOrNull ?? const [];
    final codes = ref.watch(beetleCodesProvider);
    return SectionCard(
      title: l.analyticsAiHistory,
      padding: const EdgeInsets.fromLTRB(0, Insets.m, 0, Insets.s),
      child: analyses.isEmpty
          ? Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.aiMemoryEmpty))
          : Column(children: [
              for (final a in analyses.take(10)) AnalysisTile(analysis: a, beetleCode: codes[a.beetleId]),
            ]),
    );
  }
}

class _TemperatureChart extends StatelessWidget {
  const _TemperatureChart({required this.sensor, required this.readings});
  final TemperatureSensorRow sensor;
  final List<TemperatureRecordRow> readings;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    if (readings.isEmpty) return Text(context.l10n.analyticsNoData, style: t.textTheme.bodySmall);
    final origin = readings.first.recordedAt;
    double x(DateTime d) => d.difference(origin).inMinutes / 60;
    final fmt = Fmt.of(context);
    HorizontalLine? threshold(double? v) => v == null
        ? null
        : HorizontalLine(y: v, color: t.colorScheme.error.withValues(alpha: 0.6), strokeWidth: 1, dashArray: [6, 4]);
    final maxX = x(readings.last.recordedAt);
    return SizedBox(
      height: 160,
      child: LineChart(LineChartData(
        minX: 0,
        maxX: maxX <= 0 ? 1 : maxX,
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(drawVerticalLine: false),
        extraLinesData: ExtraLinesData(
            horizontalLines: [threshold(sensor.minThresholdC), threshold(sensor.maxThresholdC)]
                .whereType<HorizontalLine>()
                .toList()),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 36, getTitlesWidget: (v, _) => Text(Fmt.number(v), style: t.textTheme.labelSmall))),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: maxX <= 0 ? 1 : (maxX / 3).clamp(1, double.infinity),
              getTitlesWidget: (v, _) => Text(fmt.shortDate(origin.add(Duration(minutes: (v * 60).round()))), style: t.textTheme.labelSmall),
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [for (final r in readings) FlSpot(x(r.recordedAt), r.celsius)],
            color: t.colorScheme.tertiary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
          ),
        ],
      )),
    );
  }
}
