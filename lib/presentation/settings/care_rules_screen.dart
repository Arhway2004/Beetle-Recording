import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../domain/proactive/care_rules.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/widgets.dart';

class CareRulesScreen extends ConsumerStatefulWidget {
  const CareRulesScreen({super.key});

  @override
  ConsumerState<CareRulesScreen> createState() => _CareRulesScreenState();
}

class _CareRulesScreenState extends ConsumerState<CareRulesScreen> {
  final _form = GlobalKey<FormState>();
  final _percent = TextEditingController();
  final _gap = TextEditingController();
  final _interval = TextEditingController();
  final _expiry = TextEditingController();
  CareRuleSettings? _rules;

  @override
  void initState() {
    super.initState();
    ref.read(settingsRepoProvider).careRules().then((r) => setState(() {
          _rules = r;
          _percent.text = Fmt.number(r.significantWeightChangePercent);
          _gap.text = '${r.measurementGapDays}';
          _interval.text = r.substrateIntervalDays?.toString() ?? '';
          _expiry.text = '${r.suggestionExpiryDays}';
        }));
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final interval = int.tryParse(_interval.text.trim());
    await ref.read(settingsRepoProvider).saveCareRules(_rules!.copyWith(
          significantWeightChangePercent: parseDecimal(_percent.text),
          measurementGapDays: int.tryParse(_gap.text),
          substrateIntervalDays: () => interval,
          suggestionExpiryDays: int.tryParse(_expiry.text),
        ));
    if (mounted) showSnack(context, context.l10n.commonSaved);
  }

  @override
  void dispose() {
    for (final c in [_percent, _gap, _interval, _expiry]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _int(String? v, {bool optional = false}) {
    if ((v == null || v.trim().isEmpty) && optional) return null;
    final n = int.tryParse(v ?? '');
    return (n == null || n < 1 || n > 3650) ? context.l10n.commonInvalidNumber : null;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    if (_rules == null) return const Scaffold(body: LoadingView());
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsCareRules), actions: [TextButton(onPressed: _save, child: Text(l.commonSave))]),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(Insets.m), children: [
          NumberField(controller: _percent, label: l.ruleWeightPercent, required: true, min: 1, max: 100),
          formGap,
          TextFormField(controller: _gap, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l.ruleGapDays), validator: _int),
          formGap,
          TextFormField(
              controller: _interval,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l.ruleSubstrateInterval),
              validator: (v) => _int(v, optional: true)),
          formGap,
          TextFormField(controller: _expiry, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l.ruleSuggestionExpiry), validator: _int),
        ]),
      ),
    );
  }
}
