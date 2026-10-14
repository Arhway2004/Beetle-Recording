import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/models/enums.dart';
import '../../domain/records/past_record.dart';
import '../../l10n/gen/app_localizations.dart';
import '../common/data_providers.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// Bulk entry of a beetle's history from before the keeper used the app:
/// one date per row with a weight and/or a stage. All rows are saved in one
/// transaction; nothing is saved if any row is invalid.
class PastRecordsScreen extends ConsumerStatefulWidget {
  const PastRecordsScreen({super.key, required this.beetleId});
  final String beetleId;

  @override
  ConsumerState<PastRecordsScreen> createState() => _PastRecordsScreenState();
}

class _Row {
  DateTime? date;
  LifeStage? stage;
  L3Phase? l3Phase;
  bool approximate = false;
  final weight = TextEditingController();
  final note = TextEditingController();

  PastRecordDraft toDraft() => PastRecordDraft(
        date: date,
        grams: parseDecimal(weight.text),
        stage: stage,
        l3Phase: l3Phase,
        dateIsApproximate: approximate,
        note: note.text,
      );

  void dispose() {
    weight.dispose();
    note.dispose();
  }
}

class _PastRecordsScreenState extends ConsumerState<PastRecordsScreen> {
  final _rows = [_Row()];
  Map<int, PastRecordProblem> _problems = const {};
  bool _saving = false;

  @override
  void dispose() {
    for (final r in _rows) {
      r.dispose();
    }
    super.dispose();
  }

  String _problemText(AppLocalizations l, PastRecordProblem p) => switch (p) {
        PastRecordProblem.missingDate => l.pastRecordsMissingDate,
        PastRecordProblem.futureDate => l.pastRecordsFutureDate,
        PastRecordProblem.nothingToSave => l.pastRecordsNeedValue,
        PastRecordProblem.invalidWeight => l.pastRecordsBadWeight,
      };

  Future<void> _save() async {
    final l = context.l10n;
    final drafts = [for (final r in _rows) r.toDraft()];
    final problems = validatePastRecords(drafts, DateTime.now());
    setState(() => _problems = problems);
    if (problems.isNotEmpty) return;
    if (savablePastRecords(drafts).isEmpty) {
      showSnack(context, l.pastRecordsNothing);
      return;
    }
    setState(() => _saving = true);
    try {
      final created = await ref
          .read(recordActionsProvider)
          .addPastRecords(widget.beetleId, drafts, approximateNote: l.pastRecordsApproxNote);
      if (!mounted) return;
      showSnack(context, l.pastRecordsSaved(created));
      context.pop();
    } catch (e) {
      debugPrint('past records save failed: $e');
      if (mounted) showSnack(context, l.pastRecordsSaveFailed); // inputs are kept for a retry
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    final code = ref.watch(beetleProvider(widget.beetleId)).valueOrNull?.code ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(code.isEmpty ? l.pastRecordsTitle : '${l.pastRecordsTitle} · $code'),
        actions: [TextButton(onPressed: _saving ? null : _save, child: Text(l.commonSave))],
      ),
      body: ListView(padding: const EdgeInsets.all(Insets.m), children: [
        Text(l.pastRecordsIntro, style: t.textTheme.bodySmall),
        const SizedBox(height: Insets.m),
        for (final (i, r) in _rows.indexed) ...[
          SectionCard(
            title: l.pastRecordsRow(i + 1),
            trailing: _rows.length > 1
                ? IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: l.commonDelete,
                    onPressed: () => setState(() {
                      _rows.removeAt(i).dispose();
                      _problems = const {};
                    }),
                  )
                : null,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DateTimeField(
                label: l.pastRecordsDate,
                value: r.date,
                withTime: false,
                lastDate: DateTime.now(),
                onChanged: (v) => setState(() => r.date = v),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(l.pastRecordsApprox),
                value: r.approximate,
                onChanged: (v) => setState(() => r.approximate = v ?? false),
              ),
              NumberField(controller: r.weight, label: l.pastRecordsWeight, max: 1000),
              formGap,
              LabeledDropdown<LifeStage?>(
                label: l.pastRecordsStage,
                value: r.stage,
                items: {null: l.commonNone, for (final s in LifeStage.values) s: l.stage(s)},
                onChanged: (v) => setState(() => r.stage = v),
              ),
              if (r.stage == LifeStage.l3) ...[
                formGap,
                LabeledDropdown<L3Phase?>(
                  label: l.fieldL3Phase,
                  value: r.l3Phase,
                  items: {null: l.commonNone, for (final p in L3Phase.values) p: l.l3Phase(p)},
                  onChanged: (v) => setState(() => r.l3Phase = v),
                ),
              ],
              formGap,
              TextFormField(controller: r.note, decoration: InputDecoration(labelText: l.pastRecordsNote)),
              if (_problems[i] != null) ...[
                const SizedBox(height: Insets.s),
                Text(_problemText(l, _problems[i]!), style: TextStyle(color: t.colorScheme.error)),
              ],
            ]),
          ),
          const SizedBox(height: Insets.m),
        ],
        OutlinedButton.icon(
          onPressed: () => setState(() => _rows.add(_Row()..date = _rows.last.date)),
          icon: const Icon(Icons.add),
          label: Text(l.pastRecordsAddRow),
        ),
        const SizedBox(height: Insets.xl),
      ]),
    );
  }
}
