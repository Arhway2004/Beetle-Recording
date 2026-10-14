import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../domain/models/enums.dart';
import '../common/data_providers.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

class SensorsScreen extends ConsumerWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsSensors)),
      floatingActionButton: FloatingActionButton(
        // Unique tag: tab screens stay alive side by side in the shell.
        heroTag: 'fab-sensors',
        tooltip: l.sensorAdd,
        onPressed: () => _edit(context, null),
        child: const Icon(Icons.add),
      ),
      body: AsyncView(
        value: ref.watch(sensorsProvider),
        data: (list) => list.isEmpty
            ? EmptyState(icon: Icons.thermostat, title: l.noSensors, body: l.sensorThresholdHelper)
            : ListView(children: [
                for (final s in list)
                  ListTile(
                    leading: const Icon(Icons.thermostat),
                    title: Text(s.name),
                    subtitle: Text([
                      if (s.location != null) s.location!,
                      (s.minThresholdC == null && s.maxThresholdC == null)
                          ? l.commonNotSet
                          : '${Fmt.celsius(s.minThresholdC)} ~ ${Fmt.celsius(s.maxThresholdC)}',
                    ].join(' · ')),
                    onTap: () => _edit(context, s),
                  ),
              ]),
      ),
    );
  }

  Future<void> _edit(BuildContext context, TemperatureSensorRow? s) => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (_) => _SensorForm(existing: s),
      );
}

class _SensorForm extends ConsumerStatefulWidget {
  const _SensorForm({this.existing});
  final TemperatureSensorRow? existing;

  @override
  ConsumerState<_SensorForm> createState() => _SensorFormState();
}

class _SensorFormState extends ConsumerState<_SensorForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.existing?.name);
  late final _location = TextEditingController(text: widget.existing?.location);
  late final _min = TextEditingController(text: Fmt.number(widget.existing?.minThresholdC).replaceAll('–', ''));
  late final _max = TextEditingController(text: Fmt.number(widget.existing?.maxThresholdC).replaceAll('–', ''));
  late final _target = TextEditingController(text: Fmt.number(widget.existing?.targetC).replaceAll('–', ''));
  late SensorKind _kind = widget.existing?.kind ?? SensorKind.manual;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    try {
      await ref.read(temperatureRepoProvider).saveSensor(
            id: widget.existing?.id,
            name: _name.text,
            location: _location.text.trim().isEmpty ? null : _location.text.trim(),
            kind: _kind,
            minThresholdC: parseDecimal(_min.text),
            maxThresholdC: parseDecimal(_max.text),
            targetC: parseDecimal(_target.text),
          );
      if (mounted) Navigator.of(context).pop();
    } on ArgumentError {
      if (mounted) showSnack(context, context.l10n.speciesRangeInvalid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, MediaQuery.viewInsetsOf(context).bottom + Insets.l),
      child: Form(
        key: _form,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: l.sensorName),
            validator: (v) => (v == null || v.trim().isEmpty) ? l.commonRequired : null,
          ),
          const SizedBox(height: Insets.s),
          TextFormField(controller: _location, decoration: InputDecoration(labelText: l.sensorLocation)),
          const SizedBox(height: Insets.s),
          LabeledDropdown<SensorKind>(
            label: l.sensorKind,
            value: _kind,
            items: {
              SensorKind.manual: l.sensorManual,
              SensorKind.bluetooth: l.sensorBluetooth,
              SensorKind.wifi: l.sensorWifi,
            },
            onChanged: (v) => setState(() => _kind = v ?? _kind),
          ),
          const SizedBox(height: Insets.s),
          Row(children: [
            Expanded(child: NumberField(controller: _min, label: l.sensorMin, positive: false, min: -40, max: 80)),
            const SizedBox(width: Insets.s),
            Expanded(child: NumberField(controller: _max, label: l.sensorMax, positive: false, min: -40, max: 80)),
          ]),
          const SizedBox(height: Insets.s),
          NumberField(controller: _target, label: l.sensorTarget, positive: false, min: -40, max: 80),
          const SizedBox(height: Insets.s),
          Text(l.sensorThresholdHelper, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: Insets.m),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: _save, child: Text(l.commonSave))),
        ]),
      ),
    );
  }
}
