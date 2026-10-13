import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/repositories/models.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

/// Adds one history record of the given type. Saving triggers the proactive
/// care rules; any resulting suggestions wait for the user's confirmation.
class RecordFormScreen extends ConsumerStatefulWidget {
  const RecordFormScreen({super.key, required this.type, this.beetleId});
  final TimelineType type;
  final String? beetleId;

  @override
  ConsumerState<RecordFormScreen> createState() => _RecordFormScreenState();
}

class _RecordFormScreenState extends ConsumerState<RecordFormScreen> {
  final _form = GlobalKey<FormState>();
  final _num1 = TextEditingController(); // weight / quantity / previous / celsius
  final _num2 = TextEditingController(); // beetle weight during change / new volume
  final _text1 = TextEditingController(); // substrate type / description
  final _text2 = TextEditingController(); // brand
  final _batch = TextEditingController();
  final _condition = TextEditingController();
  final _notes = TextEditingController();

  late String? _beetleId = widget.beetleId;
  String? _sensorId;
  DateTime _at = DateTime.now();
  DateTime? _nextPlanned;
  ObservationCategory _category = ObservationCategory.general;
  LifeStage? _stage;
  L3Phase? _l3Phase;
  bool _estimated = false;
  List<File> _photos = const [];
  bool _saving = false;

  TimelineType get type => widget.type;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final actions = ref.read(recordActionsProvider);
    final l = context.l10n;
    String? opt(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    try {
      final created = switch (type) {
        TimelineType.weight =>
          await actions.addWeight(_beetleId!, _at, parseDecimal(_num1.text)!, notes: opt(_notes), photos: _photos),
        TimelineType.observation =>
          await actions.addObservation(_beetleId!, _at, _category, _text1.text.trim(), photos: _photos),
        TimelineType.substrate => await actions.addSubstrateChange(
            beetleId: _beetleId!,
            at: _at,
            substrateType: opt(_text1),
            brand: opt(_text2),
            batch: opt(_batch),
            quantityLiters: parseDecimal(_num1.text),
            beetleWeightGrams: parseDecimal(_num2.text),
            condition: opt(_condition),
            nextPlannedAt: _nextPlanned,
            notes: opt(_notes),
            photos: _photos,
          ),
        TimelineType.container => await actions.addContainerChange(
            beetleId: _beetleId!,
            at: _at,
            previousVolumeLiters: parseDecimal(_num1.text),
            newVolumeLiters: parseDecimal(_text1.text)!,
            beetleWeightGrams: parseDecimal(_num2.text),
            condition: opt(_condition),
            notes: opt(_notes),
            photos: _photos,
          ),
        TimelineType.lifeStage => await actions.addLifeStage(_beetleId!, _at, _stage!,
            l3Phase: _l3Phase, isEstimated: _estimated, notes: opt(_notes), photos: _photos),
        TimelineType.temperature =>
          await actions.addTemperature(_sensorId!, _at, parseDecimal(_num1.text)!, notes: opt(_notes)),
      };
      if (!mounted) return;
      showSnack(context, created > 0 ? l.suggestionsCreated(created) : l.commonSaved);
      context.pop();
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    for (final c in [_num1, _num2, _text1, _text2, _batch, _condition, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final beetles = ref.watch(beetlesProvider).valueOrNull ?? const <BeetleSummary>[];
    final sensors = ref.watch(sensorsProvider).valueOrNull ?? const [];
    final selected = beetles.where((b) => b.id == _beetleId).firstOrNull;
    final fragile = selected != null && (selected.stage == LifeStage.prepupa || selected.stage == LifeStage.pupa);
    final needsBeetle = type != TimelineType.temperature;

    final fields = <Widget>[
      if (needsBeetle) ...[
        if (beetles.isEmpty) Text(l.noBeetles, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        LabeledDropdown<String>(
          label: l.chooseBeetle,
          value: _beetleId,
          items: {for (final b in beetles) b.id: '${b.code} · ${l.stage(b.stage, b.l3Phase)}'},
          onChanged: (v) => setState(() => _beetleId = v),
          validator: (v) => v == null ? l.commonRequired : null,
        ),
      ] else ...[
        if (sensors.isEmpty) Text(l.noSensors, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        LabeledDropdown<String>(
          label: l.fieldSensor,
          value: _sensorId,
          items: {for (final s in sensors) s.id: s.name},
          onChanged: (v) => setState(() => _sensorId = v),
          validator: (v) => v == null ? l.commonRequired : null,
        ),
      ],
      formGap,
      DateTimeField(label: l.commonDateTime, value: _at, lastDate: DateTime.now().add(const Duration(days: 1)),
          onChanged: (v) => setState(() => _at = v ?? _at)),
      formGap,
      ...switch (type) {
        TimelineType.weight => [
            if (fragile) ...[
              Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(padding: const EdgeInsets.all(Insets.m), child: Text(l.weightDisturbWarning)),
              ),
              formGap,
            ],
            NumberField(controller: _num1, label: l.weightGrams, required: true, max: 1000),
          ],
        TimelineType.observation => [
            LabeledDropdown<ObservationCategory>(
              label: l.observationCategory,
              value: _category,
              items: {for (final c in ObservationCategory.values) c: l.observation(c)},
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            formGap,
            TextFormField(
              controller: _text1,
              minLines: 3,
              maxLines: 8,
              maxLength: 4000,
              decoration: InputDecoration(labelText: l.observationDescription, alignLabelWithHint: true),
              validator: (v) => (v == null || v.trim().isEmpty) ? l.commonRequired : null,
            ),
          ],
        TimelineType.substrate => [
            TextFormField(controller: _text1, decoration: InputDecoration(labelText: l.fieldSubstrateType)),
            formGap,
            TextFormField(controller: _text2, decoration: InputDecoration(labelText: l.fieldSubstrateBrand)),
            formGap,
            TextFormField(controller: _batch, decoration: InputDecoration(labelText: l.substrateBatch)),
            formGap,
            NumberField(controller: _num1, label: l.substrateQuantity, max: 1000),
            formGap,
            NumberField(controller: _num2, label: l.weightDuringChange, max: 1000),
            formGap,
            TextFormField(controller: _condition, decoration: InputDecoration(labelText: l.observedCondition)),
            formGap,
            DateTimeField(
                label: l.nextPlannedAt, value: _nextPlanned, withTime: false, allowClear: true,
                firstDate: DateTime.now().subtract(const Duration(days: 1)),
                onChanged: (v) => setState(() => _nextPlanned = v)),
          ],
        TimelineType.container => [
            NumberField(controller: _num1, label: l.containerPrevious, max: 1000),
            formGap,
            NumberField(controller: _text1, label: l.containerNew, required: true, max: 1000),
            formGap,
            NumberField(controller: _num2, label: l.weightDuringChange, max: 1000),
            formGap,
            TextFormField(controller: _condition, decoration: InputDecoration(labelText: l.observedCondition)),
          ],
        TimelineType.lifeStage => [
            LabeledDropdown<LifeStage>(
              label: l.stageNew,
              value: _stage,
              items: {for (final s in LifeStage.values) s: l.stage(s)},
              onChanged: (v) => setState(() => _stage = v),
              validator: (v) => v == null ? l.commonRequired : null,
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
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l.stageIsEstimated),
              value: _estimated,
              onChanged: (v) => setState(() => _estimated = v),
            ),
          ],
        TimelineType.temperature => [
            NumberField(controller: _num1, label: l.temperatureCelsius, required: true, positive: false, min: -40, max: 80),
          ],
      },
      if (type != TimelineType.observation) ...[
        formGap,
        TextFormField(
          controller: _notes,
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration(labelText: l.commonNotes),
        ),
      ],
      if (type != TimelineType.temperature) ...[
        formGap,
        PhotoPickerField(onChanged: (f) => _photos = f),
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l.timelineType(type)),
        actions: [TextButton(onPressed: _saving ? null : _save, child: Text(l.commonSave))],
      ),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(Insets.m), children: [...fields, const SizedBox(height: Insets.xl)]),
      ),
    );
  }
}
