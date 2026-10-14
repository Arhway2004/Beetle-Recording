import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/repositories/models.dart';
import '../../domain/growth/growth_metrics.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// The facts the assistant was given about one beetle, rendered by the app
/// from the database (not by the model): always correct and localized.
/// Tapping it opens the beetle page.
class BeetleFactsCard extends ConsumerWidget {
  const BeetleFactsCard({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final t = Theme.of(context);
    final fmt = Fmt.of(context);
    final b = (ref.watch(beetlesProvider).valueOrNull ?? const <BeetleSummary>[])
        .where((x) => x.code == code)
        .firstOrNull;
    if (b == null) return const SizedBox.shrink();
    final weights = ref.watch(weightsProvider(b.id)).valueOrNull ?? const [];
    final m = GrowthMetrics.compute(
        weights.map((w) => WeightPoint(id: w.id, measuredAt: w.measuredAt, grams: w.weightGrams)));

    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: 88,
                child: Text(label, style: t.textTheme.bodySmall?.copyWith(color: t.colorScheme.onSurfaceVariant))),
            Expanded(child: Text(value, style: t.textTheme.bodyMedium)),
          ]),
        );

    final parents = [
      if (b.sireCode != null || b.sireNote != null) '${l.fieldSire}: ${b.sireCode ?? b.sireNote}',
      if (b.damCode != null || b.damNote != null) '${l.fieldDam}: ${b.damCode ?? b.damNote}',
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: Insets.m),
      color: t.colorScheme.surfaceContainerHigh,
      child: InkWell(
        borderRadius: BorderRadius.circular(Insets.radius),
        onTap: () => context.push(AppRoutes.beetle(b.id)),
        child: Padding(
          padding: const EdgeInsets.all(Insets.m),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                child: Text('${b.code} · ${b.speciesCommonName ?? b.speciesName}',
                    style: t.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
              ),
              Pill(l.stage(b.stage, b.l3Phase), color: t.colorScheme.primary),
              const Icon(Icons.chevron_right),
            ]),
            const SizedBox(height: Insets.s),
            row(l.detailLatestWeight,
                b.latestWeightGrams == null ? '–' : '${Fmt.grams(b.latestWeightGrams)}（${fmt.date(b.latestWeightAt)}）'),
            row(l.factsWeighings, '${m.count}'),
            if (m.count >= 2)
              row(l.detailChangeSincePrevious,
                  '${Fmt.signed(m.changeSincePrevious, unit: ' g')} (${Fmt.signed(m.percentChangeSincePrevious, unit: '%', digits: 1)})'),
            if (b.containerLiters != null) row(l.detailContainer, Fmt.liters(b.containerLiters)),
            if (b.substrateType != null || b.substrateBrand != null)
              row(l.detailSubstrate, [b.substrateType, b.substrateBrand].whereType<String>().join(' · ')),
            if (parents.isNotEmpty) row(l.parentsSection, parents.join('，')),
          ]),
        ),
      ),
    );
  }
}
