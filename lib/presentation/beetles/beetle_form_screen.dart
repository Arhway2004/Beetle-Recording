import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/ids.dart';
import '../../data/repositories/models.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// Create a beetle (with initial history events) or edit profile fields.
/// Weight / container / substrate / stage are history: after creation they
/// are changed only by adding records.
class BeetleFormScreen extends ConsumerStatefulWidget {
  const BeetleFormScreen({super.key, this.beetleId});
  final String? beetleId;

  @override
  ConsumerState<BeetleFormScreen> createState() => _BeetleFormScreenState();
}

class _BeetleFormScreenState extends ConsumerState<BeetleFormScreen> {
  final _form = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _weight = TextEditingController();
  final _container = TextEditingController();
  final _substrateType = TextEditingController();
  final _substrateBrand = TextEditingController();
  final _uncertainty = TextEditingController();
  final _notes = TextEditingController();
  final _sireNote = TextEditingController();
  final _damNote = TextEditingController();

  String? _speciesId;
  Sex _sex = Sex.unknown;
  BeetleStatus _status = BeetleStatus.active;
  LifeStage? _stage;
  L3Phase? _l3Phase;
  DateTime? _acquiredAt = DateTime.now();
  DateTime? _hatchDate;
  DateTime? _estimatedHatch;
  String? _sensorId;
  String? _sireId;
  String? _damId;
  List<File> _photos = const [];
  bool _saving = false;
  bool _loaded = false;
  String? _codeError;

  bool get _isEdit => widget.beetleId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) _load();
  }

  Future<void> _load() async {
    final b = await ref.read(beetleRepoProvider).beetleRow(widget.beetleId!);
    setState(() {
      _code.text = b.code;
      _speciesId = b.speciesId;
      _sex = b.sex;
      _status = b.status;
      _acquiredAt = b.acquiredAt;
      _hatchDate = b.hatchDate;
      _estimatedHatch = b.estimatedHatchDate;
      _uncertainty.text = b.hatchUncertaintyDays?.toString() ?? '';
      _sensorId = b.sensorId;
      _notes.text = b.notes ?? '';
      _sireId = b.sireId;
      _damId = b.damId;
      _sireNote.text = b.sireNote ?? '';
      _damNote.text = b.damNote ?? '';
      _loaded = true;
    });
  }

  Future<void> _onSpecies(String? id) async {
    setState(() => _speciesId = id);
    if (id != null && !_isEdit) {
      _code.text = await ref.read(beetleRepoProvider).nextCode(id);
    }
  }

  Future<void> _save() async {
    setState(() => _codeError = null);
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final l = context.l10n;
    try {
      final uncertainty = int.tryParse(_uncertainty.text.trim());
      if (_isEdit) {
        await ref.read(beetleRepoProvider).updateBeetleProfile(
              widget.beetleId!,
              sex: _sex,
              status: _status,
              acquiredAt: _acquiredAt,
              hatchDate: _hatchDate,
              estimatedHatchDate: _estimatedHatch,
              hatchUncertaintyDays: uncertainty,
              sensorId: _sensorId,
              notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
              sireId: _sireId,
              damId: _damId,
              sireNote: _sireId == null ? _sireNote.text : null,
              damNote: _damId == null ? _damNote.text : null,
            );
        if (mounted) context.pop();
      } else {
        final (id, created) = await ref.read(recordActionsProvider).createBeetle(
              NewBeetleInput(
                code: _code.text,
                speciesId: _speciesId!,
                sex: _sex,
                acquiredAt: _acquiredAt,
                hatchDate: _hatchDate,
                estimatedHatchDate: _estimatedHatch,
                hatchUncertaintyDays: uncertainty,
                initialStage: _stage,
                initialL3Phase: _l3Phase,
                initialWeightGrams: parseDecimal(_weight.text),
                containerLiters: parseDecimal(_container.text),
                substrateType: _substrateType.text.trim().isEmpty ? null : _substrateType.text.trim(),
                substrateBrand: _substrateBrand.text.trim().isEmpty ? null : _substrateBrand.text.trim(),
                sensorId: _sensorId,
                notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
                sireId: _sireId,
                damId: _damId,
                sireNote: _sireId == null ? _sireNote.text : null,
                damNote: _damId == null ? _damNote.text : null,
              ),
              photos: _photos,
            );
        if (!mounted) return;
        showSnack(context, created > 0 ? l.suggestionsCreated(created) : l.commonSaved);
        context.pushReplacement(AppRoutes.beetle(id));
      }
    } on DuplicateCodeException catch (e) {
      setState(() => _codeError = l.fieldCodeDuplicate(e.code));
    } on ParentException catch (e) {
      if (mounted) showSnack(context, l.parentError(e.error));
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  /// Dropdown of candidate parents (excluding the impossible sex) plus a
  /// free-text field shown when the parent is not in the collection.
  List<Widget> _parentFields(String label, String noteLabel, String? selected, TextEditingController note,
      List<BeetleSummary> others, Sex excludedSex, ValueChanged<String?> onChanged) {
    final l = context.l10n;
    final candidates = others.where((b) => b.sex != excludedSex || b.id == selected);
    return [
      formGap,
      LabeledDropdown<String?>(
        label: label,
        value: selected,
        items: {
          null: l.parentNotInCollection,
          for (final b in candidates) b.id: '${b.code} · ${l.sex(b.sex)}',
        },
        onChanged: onChanged,
      ),
      if (selected == null) ...[
        formGap,
        TextFormField(
          controller: note,
          maxLength: 200,
          decoration: InputDecoration(labelText: noteLabel, helperText: l.parentNoteHelper),
        ),
      ],
    ];
  }

  @override
  void dispose() {
    for (final c in [
      _code, _weight, _container, _substrateType, _substrateBrand, _uncertainty, _notes, _sireNote, _damNote,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final species = ref.watch(speciesProvider).valueOrNull ?? const [];
    final sensors = ref.watch(sensorsProvider).valueOrNull ?? const [];
    final others = (ref.watch(beetlesProvider).valueOrNull ?? const <BeetleSummary>[])
        .where((b) => b.id != widget.beetleId)
        .toList();
    if (_isEdit && !_loaded) return const Scaffold(body: LoadingView());
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l.beetleFormEditTitle : l.beetleFormNewTitle),
        actions: [
          TextButton(onPressed: _saving ? null : _save, child: Text(l.commonSave)),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(Insets.m),
          children: [
            LabeledDropdown<String>(
              label: l.fieldSpecies,
              value: _speciesId,
              items: {for (final s in species) s.id: '${s.code} · ${s.commonName ?? s.scientificName}'},
              onChanged: _isEdit ? (_) {} : _onSpecies,
              validator: (v) => v == null ? l.commonRequired : null,
            ),
            formGap,
            TextFormField(
              controller: _code,
              enabled: !_isEdit,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: l.fieldCode, helperText: l.fieldCodeHelper, errorText: _codeError),
              validator: (v) =>
                  (v == null || !beetleCodePattern.hasMatch(v.trim().toUpperCase())) ? l.fieldCodeInvalid : null,
            ),
            formGap,
            Text(l.fieldSex, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: Insets.xs),
            SegmentedButton<Sex>(
              segments: [for (final s in Sex.values) ButtonSegment(value: s, label: Text(l.sex(s)))],
              selected: {_sex},
              onSelectionChanged: (s) => setState(() => _sex = s.first),
            ),
            if (_isEdit) ...[
              formGap,
              LabeledDropdown<BeetleStatus>(
                label: l.fieldStatus,
                value: _status,
                items: {for (final s in BeetleStatus.values) s: l.beetleStatus(s)},
                onChanged: (v) => setState(() => _status = v ?? _status),
              ),
            ],
            formGap,
            DateTimeField(
                label: l.fieldAcquiredAt, value: _acquiredAt, withTime: false, allowClear: true,
                onChanged: (v) => setState(() => _acquiredAt = v)),
            formGap,
            DateTimeField(
                label: '${l.fieldHatchDate} (${l.commonOptional})', value: _hatchDate, withTime: false, allowClear: true,
                onChanged: (v) => setState(() => _hatchDate = v)),
            formGap,
            Row(children: [
              Expanded(
                flex: 3,
                child: DateTimeField(
                    label: l.fieldEstimatedHatchDate, value: _estimatedHatch, withTime: false, allowClear: true,
                    onChanged: (v) => setState(() => _estimatedHatch = v)),
              ),
              const SizedBox(width: Insets.s),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _uncertainty,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: l.fieldHatchUncertainty),
                  validator: (v) => (v == null || v.isEmpty || (int.tryParse(v) ?? -1) >= 0) ? null : l.commonInvalidNumber,
                ),
              ),
            ]),
            formGap,
            LabeledDropdown<String?>(
              label: l.fieldSensor,
              value: _sensorId,
              items: {null: l.commonNone, for (final s in sensors) s.id: s.name},
              onChanged: (v) => setState(() => _sensorId = v),
            ),
            const SizedBox(height: Insets.l),
            Text(l.parentsSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: Insets.xs),
            Text(l.parentsHint, style: Theme.of(context).textTheme.bodySmall),
            ..._parentFields(l.fieldSire, l.fieldSireNote, _sireId, _sireNote, others, Sex.female,
                (v) => setState(() => _sireId = v)),
            ..._parentFields(l.fieldDam, l.fieldDamNote, _damId, _damNote, others, Sex.male,
                (v) => setState(() => _damId = v)),
            if (!_isEdit) ...[
              const SizedBox(height: Insets.l),
              Text(l.beetleFormInitialSection, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: Insets.xs),
              Text(l.beetleFormStageHint, style: Theme.of(context).textTheme.bodySmall),
              formGap,
              LabeledDropdown<LifeStage?>(
                label: l.fieldStage,
                value: _stage,
                items: {null: l.stageUnset, for (final s in LifeStage.values) s: l.stage(s)},
                onChanged: (v) => setState(() => _stage = v),
              ),
              if (_stage == LifeStage.l3) ...[
                formGap,
                LabeledDropdown<L3Phase?>(
                  label: l.fieldL3Phase,
                  value: _l3Phase,
                  items: {null: l.commonNone, for (final p in L3Phase.values) p: l.l3Phase(p)},
                  onChanged: (v) => setState(() => _l3Phase = v),
                ),
              ],
              formGap,
              NumberField(controller: _weight, label: l.fieldWeight, max: 1000),
              formGap,
              NumberField(controller: _container, label: l.fieldContainer, max: 1000),
              formGap,
              TextFormField(controller: _substrateType, decoration: InputDecoration(labelText: l.fieldSubstrateType)),
              formGap,
              TextFormField(controller: _substrateBrand, decoration: InputDecoration(labelText: l.fieldSubstrateBrand)),
              formGap,
              PhotoPickerField(onChanged: (f) => _photos = f),
            ] else ...[
              const SizedBox(height: Insets.s),
              Text(l.beetleFormHistoryHint, style: Theme.of(context).textTheme.bodySmall),
            ],
            formGap,
            TextFormField(
              controller: _notes,
              minLines: 3,
              maxLines: 8,
              decoration: InputDecoration(labelText: l.fieldBreedingNotes, alignLabelWithHint: true),
            ),
            const SizedBox(height: Insets.xl),
          ],
        ),
      ),
    );
  }
}
