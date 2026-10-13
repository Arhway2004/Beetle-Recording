import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../../domain/ai/breeding_tools.dart';
import '../../domain/models/enums.dart';
import '../../infrastructure/notifications/reminder_scheduler.dart';
import '../common/form_fields.dart';
import '../common/labels.dart';
import '../common/record_widgets.dart';
import '../common/widgets.dart';

void reportReconcile(BuildContext context, ReconcileResult r) {
  final l = context.l10n;
  final parts = [
    if (r.permissionDenied) l.notificationsDenied,
    if (!r.permissionDenied && r.deferred > 0) l.remindersDeferred(r.deferred),
    if (!r.permissionDenied && !r.exact) l.remindersInexact,
  ];
  showSnack(context, parts.isEmpty ? l.commonSaved : parts.join('\n'));
}

/// Confirmation UI for a suggested reminder: accept (optionally with edited
/// date / title / message), reject, postpone, or disable similar suggestions.
Future<void> showSuggestionReviewSheet(BuildContext context, WidgetRef ref, ReminderRow reminder,
    {String? beetleCode}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => _SuggestionSheet(reminder: reminder, beetleCode: beetleCode),
  );
}

class _SuggestionSheet extends ConsumerStatefulWidget {
  const _SuggestionSheet({required this.reminder, this.beetleCode});
  final ReminderRow reminder;
  final String? beetleCode;

  @override
  ConsumerState<_SuggestionSheet> createState() => _SuggestionSheetState();
}

class _SuggestionSheetState extends ConsumerState<_SuggestionSheet> {
  late final _title = TextEditingController(text: widget.reminder.title);
  late final _message = TextEditingController(text: widget.reminder.message);
  late DateTime _due = widget.reminder.dueAt.toLocal();
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) showSnack(context, '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
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
    final t = Theme.of(context);
    final r = widget.reminder;
    final actions = ref.read(reminderActionsProvider);
    final messenger = ScaffoldMessenger.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, Insets.l),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.reminderReview, style: t.textTheme.titleLarge),
          const SizedBox(height: Insets.s),
          Wrap(spacing: Insets.s, runSpacing: Insets.xs, children: [
            if (widget.beetleCode != null) Pill(widget.beetleCode!),
            Pill(l.eventType(r.eventType)),
            Pill(l.source(r.source)),
            Pill(l.basis(SuggestionBasis.fromWire(r.basis)),
                color: r.basis == SuggestionBasis.aiInference.wire ? t.colorScheme.hypothesis : null),
            if (r.severity != null) Pill(l.severity(r.severity!), color: severityColor(context, r.severity)),
            if (r.confidence != null) Pill(l.confidence(r.confidence!)),
          ]),
          if (r.reason != null) ...[
            const SizedBox(height: Insets.m),
            Text(l.reminderReason, style: t.textTheme.labelLarge),
            Text(r.reason!),
          ],
          if (r.recommendation != null) ...[
            const SizedBox(height: Insets.s),
            Text(l.reminderRecommendation, style: t.textTheme.labelLarge),
            Text(r.recommendation!),
          ],
          const SizedBox(height: Insets.s),
          FutureBuilder(
            future: ref.read(reminderRepoProvider).evidenceFor(r.id),
            builder: (_, s) => Text(l.reminderEvidence(s.data?.length ?? 0), style: t.textTheme.labelSmall),
          ),
          const Divider(height: Insets.l),
          TextField(controller: _title, maxLength: 80, decoration: InputDecoration(labelText: l.reminderTitleField)),
          TextField(
              controller: _message,
              maxLength: 500,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(labelText: l.reminderMessageField)),
          const SizedBox(height: Insets.s),
          DateTimeField(label: l.reminderDueAt, value: _due, onChanged: (v) => setState(() => _due = v ?? _due)),
          const SizedBox(height: Insets.s),
          Text(l.reminderNeedsConfirmation, style: t.textTheme.labelSmall),
          const SizedBox(height: Insets.m),
          FilledButton.icon(
            onPressed: _busy
                ? null
                : () => _run(() async {
                      final res = await actions.accept(r.id,
                          dueAt: _due, title: _title.text.trim().isEmpty ? null : _title.text, message: _message.text);
                      if (context.mounted) reportReconcile(context, res);
                    }),
            icon: const Icon(Icons.check),
            label: Text(l.reminderAccept),
          ),
          const SizedBox(height: Insets.s),
          Wrap(spacing: Insets.s, runSpacing: Insets.s, children: [
            OutlinedButton.icon(
              onPressed: _busy ? null : () => _run(() => actions.reject(r.id)),
              icon: const Icon(Icons.close),
              label: Text(l.reminderReject),
            ),
            for (final days in [1, 3, 7])
              OutlinedButton(
                onPressed: _busy
                    ? null
                    : () => _run(() async {
                          await actions.postpone(r.id, r.dueAt.add(Duration(days: days)));
                        }),
                child: Text(l.reminderPostponeDays(days)),
              ),
            TextButton.icon(
              onPressed: _busy
                  ? null
                  : () async {
                      final ok = await confirmDialog(context,
                          title: l.reminderDisableSimilar,
                          message: l.reminderDisableSimilarConfirm(l.eventType(r.eventType)));
                      if (ok) {
                        await _run(() => actions.disableSimilar(r.id));
                        messenger.showSnackBar(SnackBar(content: Text(l.commonSaved)));
                      }
                    },
              icon: const Icon(Icons.notifications_off_outlined),
              label: Text(l.reminderDisableSimilar),
            ),
          ]),
        ]),
      ),
    );
  }
}

/// Review of a reminder the AI proposed in chat. Nothing exists until the user
/// confirms here.
Future<void> showDraftReviewSheet(BuildContext context, WidgetRef ref,
    {required ReminderDraft draft, String? beetleId}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => _DraftSheet(draft: draft, beetleId: beetleId),
  );
}

class _DraftSheet extends ConsumerStatefulWidget {
  const _DraftSheet({required this.draft, this.beetleId});
  final ReminderDraft draft;
  final String? beetleId;

  @override
  ConsumerState<_DraftSheet> createState() => _DraftSheetState();
}

class _DraftSheetState extends ConsumerState<_DraftSheet> {
  late final _title = TextEditingController(text: widget.draft.title);
  late final _message = TextEditingController(text: widget.draft.message);
  late DateTime _due = DateTime.now().add(Duration(days: widget.draft.delayDays));

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Insets.m, 0, Insets.m, Insets.l),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.assistantReminderDraft, style: t.textTheme.titleLarge),
          const SizedBox(height: Insets.s),
          Wrap(spacing: Insets.s, children: [
            Pill(widget.draft.beetleCode),
            Pill(l.basisAiInference, color: t.colorScheme.hypothesis),
          ]),
          if (widget.draft.reason.isNotEmpty) ...[
            const SizedBox(height: Insets.m),
            Text(l.reminderReason, style: t.textTheme.labelLarge),
            Text(widget.draft.reason),
          ],
          const Divider(height: Insets.l),
          TextField(controller: _title, maxLength: 80, decoration: InputDecoration(labelText: l.reminderTitleField)),
          TextField(
              controller: _message,
              maxLength: 500,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(labelText: l.reminderMessageField)),
          DateTimeField(label: l.reminderDueAt, value: _due, onChanged: (v) => setState(() => _due = v ?? _due)),
          const SizedBox(height: Insets.m),
          FilledButton.icon(
            onPressed: _title.text.trim().isEmpty
                ? null
                : () async {
                    final res = await ref.read(reminderActionsProvider).create(
                          beetleId: widget.beetleId,
                          title: _title.text.trim(),
                          message: _message.text.trim(),
                          dueAt: _due,
                          source: ReminderSource.ai,
                          reason: widget.draft.reason.isEmpty ? null : widget.draft.reason,
                        );
                    if (!context.mounted) return;
                    reportReconcile(context, res);
                    Navigator.of(context).pop();
                  },
            icon: const Icon(Icons.check),
            label: Text(l.reminderAccept),
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l.reminderReject)),
        ]),
      ),
    );
  }
}
