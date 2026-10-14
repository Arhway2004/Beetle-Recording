import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/growth/growth_roadmap.dart';
import '../../domain/models/enums.dart';
import '../common/labels.dart';

/// One default icon per stage, used everywhere a stage is drawn.
IconData stageIcon(LifeStage s) => switch (s) {
      LifeStage.l1 => Icons.looks_one_outlined,
      LifeStage.l2 => Icons.looks_two_outlined,
      LifeStage.l3 => Icons.looks_3_outlined,
      LifeStage.prepupa => Icons.hourglass_bottom,
      LifeStage.pupa => Icons.spa_outlined,
      LifeStage.adult => Icons.pest_control,
    };

/// Vertical lifecycle roadmap. Status is always stated in text, never only by
/// colour or icon; dates of a period's end are "next record", not completion.
class GrowthRoadmapView extends StatelessWidget {
  const GrowthRoadmapView({super.key, required this.roadmap});
  final GrowthRoadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    if (roadmap.periods.isEmpty) {
      return Text(l.roadmapNoStages, style: t.textTheme.bodySmall);
    }
    final stages = roadmap.stages;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (roadmap.weightsBeforeFirstStage.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: Insets.s),
          child: Text(l.roadmapBeforeFirst(roadmap.weightsBeforeFirstStage.length), style: t.textTheme.bodySmall),
        ),
      for (final (i, s) in stages.indexed)
        _StageRow(stage: s, isLast: i == stages.length - 1),
      const SizedBox(height: Insets.xs),
      Text(l.roadmapEndNote, style: t.textTheme.labelSmall?.copyWith(color: t.colorScheme.outline)),
    ]);
  }
}

class _StageRow extends StatelessWidget {
  const _StageRow({required this.stage, required this.isLast});
  final RoadmapStage stage;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    final fmt = Fmt.of(context);
    final s = stage;
    final status = switch (s.status) {
      RoadmapStageStatus.current => l.roadmapCurrent,
      RoadmapStageStatus.recorded => l.roadmapRecorded,
      RoadmapStageStatus.notRecorded => l.roadmapNotRecorded,
      RoadmapStageStatus.upcoming => l.roadmapUpcoming,
    };
    final hasHistory = s.periods.isNotEmpty;
    final isCurrent = s.status == RoadmapStageStatus.current;
    final color = isCurrent
        ? t.colorScheme.primary
        : hasHistory
            ? t.colorScheme.onSurface
            : t.colorScheme.outline;

    String periodText(StagePeriod p) {
      final start = '${p.startEstimated ? '${l.roadmapApprox} ' : ''}${fmt.date(p.start)}';
      return p.end == null ? l.roadmapSince(start) : l.roadmapPeriod(start, fmt.date(p.end));
    }

    final lines = <String>[
      for (final p in s.periods) ...[
        periodText(p),
        if (p.l3Phases.isNotEmpty) p.l3Phases.map((x) => l.l3Phase(x.phase)).join(' → '),
        if (p.weights.isNotEmpty)
          '${l.roadmapWeights(p.weights.length)} · '
              '${l.roadmapLatestWeight(Fmt.grams(p.weights.last.grams), fmt.date(p.weights.last.measuredAt))}',
      ],
    ];
    final needsReview = s.periods.any((p) => p.outOfOrder);

    return Semantics(
      button: hasHistory,
      label: '${l.stage(s.stage)}, $status',
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: hasHistory ? () => _showStage(context, s) : null,
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              width: 36,
              child: Column(children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent ? t.colorScheme.primary : (hasHistory ? t.colorScheme.secondaryContainer : null),
                    border: Border.all(color: color, width: isCurrent ? 0 : 1.5),
                  ),
                  child: Icon(stageIcon(s.stage),
                      size: 18, color: isCurrent ? t.colorScheme.onPrimary : color),
                ),
                if (!isLast) Expanded(child: Container(width: 2, color: t.colorScheme.outlineVariant)),
              ]),
            ),
            const SizedBox(width: Insets.s),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: Insets.m, top: 4),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Wrap(spacing: Insets.s, crossAxisAlignment: WrapCrossAlignment.center, children: [
                    Text(l.stage(s.stage),
                        style: t.textTheme.titleSmall?.copyWith(
                            color: color, fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500)),
                    Text(status, style: t.textTheme.labelSmall?.copyWith(color: color)),
                  ]),
                  for (final line in lines) Text(line, style: t.textTheme.bodySmall),
                  if (needsReview)
                    Text(l.roadmapNeedsReview, style: t.textTheme.bodySmall?.copyWith(color: t.colorScheme.error)),
                ]),
              ),
            ),
            if (hasHistory) Icon(Icons.chevron_right, color: t.colorScheme.outline),
          ]),
        ),
      ),
    );
  }

  void _showStage(BuildContext context, RoadmapStage s) {
    final l = context.l10n;
    final fmt = Fmt.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(ctx).height * 0.7),
          child: ListView(shrinkWrap: true, padding: const EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, Insets.m), children: [
            Text(l.stage(s.stage), style: Theme.of(ctx).textTheme.titleLarge),
            for (final p in s.periods) ...[
              const SizedBox(height: Insets.m),
              Text(p.end == null
                  ? l.roadmapSince('${p.startEstimated ? '${l.roadmapApprox} ' : ''}${fmt.date(p.start)}')
                  : l.roadmapPeriod('${p.startEstimated ? '${l.roadmapApprox} ' : ''}${fmt.date(p.start)}',
                      fmt.date(p.end)),
                  style: Theme.of(ctx).textTheme.titleSmall),
              if (p.l3Phases.isNotEmpty)
                for (final x in p.l3Phases)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.label_outline),
                    title: Text(l.l3Phase(x.phase)),
                    subtitle: Text(fmt.date(x.at)),
                  ),
              if (p.weights.isEmpty)
                Padding(padding: const EdgeInsets.symmetric(vertical: Insets.s), child: Text(l.roadmapNoWeights))
              else
                for (final w in p.weights)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.monitor_weight_outlined),
                    title: Text(Fmt.grams(w.grams)),
                    subtitle: Text(fmt.dateTime(w.measuredAt)),
                  ),
            ],
          ]),
        ),
      ),
    );
  }
}
