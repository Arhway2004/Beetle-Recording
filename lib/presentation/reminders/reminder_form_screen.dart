import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../common/data_providers.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/widgets.dart';
import 'reminder_review_sheet.dart';

/// A reminder written by the user (explicitly confirmed by creation).
class ReminderFormScreen extends ConsumerStatefulWidget {
  const ReminderFormScreen({super.key, this.beetleId});
  final String? beetleId;

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _message = TextEditingController();
  late String? _beetleId = widget.beetleId;
  DateTime _due = DateTime.now().add(const Duration(days: 1));
  bool _saving = false;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final res = await ref.read(reminderActionsProvider).create(
          beetleId: _beetleId, title: _title.text.trim(), message: _message.text.trim(), dueAt: _due);
      if (!mounted) return;
      reportReconcile(context, res);
      context.pop();
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final beetles = ref.watch(beetlesProvider).valueOrNull ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: Text(l.reminderNew),
        actions: [TextButton(onPressed: _saving ? null : _save, child: Text(l.commonSave))],
      ),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(Insets.m), children: [
          LabeledDropdown<String?>(
            label: l.reminderBeetleOptional,
            value: _beetleId,
            items: {null: l.commonNone, for (final b in beetles) b.id: b.code},
            onChanged: (v) => setState(() => _beetleId = v),
          ),
          formGap,
          TextFormField(
            controller: _title,
            maxLength: 80,
            decoration: InputDecoration(labelText: l.reminderTitleField),
            validator: (v) => (v == null || v.trim().isEmpty) ? l.commonRequired : null,
          ),
          TextFormField(
            controller: _message,
            maxLength: 500,
            minLines: 2,
            maxLines: 5,
            decoration: InputDecoration(labelText: l.reminderMessageField),
          ),
          formGap,
          DateTimeField(
            label: l.reminderDueAt,
            value: _due,
            firstDate: DateTime.now().subtract(const Duration(days: 1)),
            onChanged: (v) => setState(() => _due = v ?? _due),
          ),
          formGap,
          Text(l.notificationsRationale, style: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    );
  }
}
