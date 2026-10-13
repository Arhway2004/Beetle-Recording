import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../domain/ai/labeled_answer.dart';
import '../../domain/models/enums.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

Color claimColor(BuildContext context, ClaimKind k) {
  final c = Theme.of(context).colorScheme;
  return switch (k) {
    ClaimKind.verified => c.verified,
    ClaimKind.calculated => c.calculated,
    ClaimKind.observation => Colors.blue.shade600,
    ClaimKind.hypothesis => c.hypothesis,
    ClaimKind.recommendation => Colors.green.shade700,
    ClaimKind.unknown || ClaimKind.unclassified => c.outline,
  };
}

/// Renders an answer as labeled statements so facts, calculations and
/// hypotheses are visually distinct.
class LabeledSectionsView extends StatelessWidget {
  const LabeledSectionsView({super.key, required this.sections});
  final List<AnswerSection> sections;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final s in sections)
        Padding(
          padding: const EdgeInsets.only(bottom: Insets.s),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Pill(l.claim(s.kind), color: claimColor(context, s.kind)),
            const SizedBox(height: 4),
            SelectableText(s.text),
          ]),
        ),
    ]);
  }
}

/// One stored AI analysis (memory) with feedback, outcome tracking and delete.
class AnalysisTile extends ConsumerWidget {
  const AnalysisTile({super.key, required this.analysis, this.beetleCode});
  final AiAnalysisRow analysis;
  final String? beetleCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final repo = ref.watch(aiMemoryRepoProvider);
    final a = analysis;
    final sections = repo.sectionsOf(a);
    return ExpansionTile(
      leading: Icon(a.kind == AnalysisKind.proactive ? Icons.rule : Icons.chat_bubble_outline),
      title: Text(a.question ?? l.detailAiInterpret, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text([
        if (beetleCode != null) beetleCode!,
        Fmt.of(context).dateTime(a.createdAt),
        a.model ?? a.provider,
        if (a.outcome != PredictionOutcome.notApplicable) '${l.aiMemoryOutcome}: ${l.outcome(a.outcome)}',
      ].join(' · ')),
      childrenPadding: const EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, Insets.m),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sections.isNotEmpty)
          LabeledSectionsView(sections: sections)
        else
          SelectableText(a.response, style: Theme.of(context).textTheme.bodySmall),
        FutureBuilder(
          future: repo.evidenceFor(a.id),
          builder: (_, snap) => Text(l.reminderEvidence(snap.data?.length ?? 0),
              style: Theme.of(context).textTheme.labelSmall),
        ),
        const SizedBox(height: Insets.s),
        Wrap(spacing: Insets.s, runSpacing: Insets.s, crossAxisAlignment: WrapCrossAlignment.center, children: [
          ChoiceChip(
            label: Text(l.assistantFeedbackHelpful),
            selected: a.feedback == AnalysisFeedback.helpful,
            onSelected: (v) => repo.setFeedback(a.id, v ? AnalysisFeedback.helpful : null),
          ),
          ChoiceChip(
            label: Text(l.assistantFeedbackNotHelpful),
            selected: a.feedback == AnalysisFeedback.notHelpful,
            onSelected: (v) => repo.setFeedback(a.id, v ? AnalysisFeedback.notHelpful : null),
          ),
          PopupMenuButton<PredictionOutcome>(
            onSelected: (o) => repo.setOutcome(a.id, o),
            itemBuilder: (_) => [
              for (final o in PredictionOutcome.values) PopupMenuItem(value: o, child: Text(l.outcome(o))),
            ],
            child: Chip(label: Text('${l.aiMemoryOutcome}: ${l.outcome(a.outcome)}')),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: l.commonDelete,
            onPressed: () async {
              if (await confirmDialog(context,
                  title: l.commonDeleteConfirmTitle, message: l.aiMemoryDeleteConfirm, destructive: true)) {
                await repo.deleteAnalysis(a.id);
              }
            },
          ),
        ]),
      ],
    );
  }
}
