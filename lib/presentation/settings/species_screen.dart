import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/ids.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/models.dart';
import '../common/data_providers.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

class SpeciesScreen extends ConsumerWidget {
  const SpeciesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsSpecies)),
      floatingActionButton: FloatingActionButton(
        tooltip: l.speciesAdd,
        onPressed: () => _edit(context, ref, null),
        child: const Icon(Icons.add),
      ),
      body: AsyncView(
        value: ref.watch(speciesProvider),
        data: (list) => ListView(children: [
          for (final s in list)
            ListTile(
              title: Text('${s.code} · ${s.commonName ?? ''}'),
              subtitle: Text([
                s.scientificName,
                if (s.expectedPupaDaysMin != null) '${l.speciesPupaMin}: ${s.expectedPupaDaysMin}–${s.expectedPupaDaysMax}',
              ].join('\n')),
              isThreeLine: s.expectedPupaDaysMin != null,
              trailing: s.isBuiltin ? Pill(l.speciesBuiltin) : null,
              onTap: () => _edit(context, ref, s),
            ),
        ]),
      ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, SpeciesRow? existing) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => _SpeciesForm(existing: existing),
    );
  }
}

class _SpeciesForm extends ConsumerStatefulWidget {
  const _SpeciesForm({this.existing});
  final SpeciesRow? existing;

  @override
  ConsumerState<_SpeciesForm> createState() => _SpeciesFormState();
}

class _SpeciesFormState extends ConsumerState<_SpeciesForm> {
  final _form = GlobalKey<FormState>();
  late final _code = TextEditingController(text: widget.existing?.code);
  late final _sci = TextEditingController(text: widget.existing?.scientificName);
  late final _common = TextEditingController(text: widget.existing?.commonName);
  late final _min = TextEditingController(text: widget.existing?.expectedPupaDaysMin?.toString());
  late final _max = TextEditingController(text: widget.existing?.expectedPupaDaysMax?.toString());
  String? _error;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final repo = ref.read(beetleRepoProvider);
    final min = int.tryParse(_min.text), max = int.tryParse(_max.text);
    try {
      if (widget.existing == null) {
        await repo.addSpecies(
            code: _code.text, scientificName: _sci.text, commonName: _common.text.trim().isEmpty ? null : _common.text.trim(),
            pupaDaysMin: min, pupaDaysMax: max);
      } else {
        await repo.updateSpecies(widget.existing!.id,
            commonName: _common.text.trim().isEmpty ? null : _common.text.trim(), pupaDaysMin: min, pupaDaysMax: max,
            notes: widget.existing!.notes);
      }
      if (mounted) Navigator.of(context).pop();
    } on DuplicateCodeException catch (e) {
      setState(() => _error = context.l10n.fieldCodeDuplicate(e.code));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final isNew = widget.existing == null;
    String? days(String? v) {
      if (v == null || v.trim().isEmpty) return null;
      final n = int.tryParse(v);
      return (n == null || n < 1 || n > 1000) ? l.commonInvalidNumber : null;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, MediaQuery.viewInsetsOf(context).bottom + Insets.l),
      child: Form(
        key: _form,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: _code,
            enabled: isNew,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(labelText: l.speciesCode, errorText: _error),
            validator: (v) => speciesCodePattern.hasMatch((v ?? '').trim().toUpperCase()) ? null : l.fieldCodeInvalid,
          ),
          const SizedBox(height: Insets.s),
          TextFormField(
            controller: _sci,
            enabled: isNew,
            decoration: InputDecoration(labelText: l.speciesScientific),
            validator: (v) => (v == null || v.trim().isEmpty) ? l.commonRequired : null,
          ),
          const SizedBox(height: Insets.s),
          TextFormField(controller: _common, decoration: InputDecoration(labelText: l.speciesCommon)),
          const SizedBox(height: Insets.s),
          Row(children: [
            Expanded(child: TextFormField(controller: _min, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l.speciesPupaMin), validator: days)),
            const SizedBox(width: Insets.s),
            Expanded(
              child: TextFormField(
                controller: _max,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l.speciesPupaMax),
                validator: (v) {
                  final e = days(v);
                  if (e != null) return e;
                  final a = int.tryParse(_min.text), b = int.tryParse(v ?? '');
                  if ((a == null) != (b == null)) return l.commonRequired;
                  return (a != null && b != null && a > b) ? l.speciesRangeInvalid : null;
                },
              ),
            ),
          ]),
          Align(alignment: Alignment.centerLeft, child: Text(l.speciesPupaHelper, style: Theme.of(context).textTheme.bodySmall)),
          const SizedBox(height: Insets.m),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: _save, child: Text(l.commonSave))),
        ]),
      ),
    );
  }
}
