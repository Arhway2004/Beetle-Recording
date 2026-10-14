import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../data/database/app_database.dart';
import '../common/labels.dart';
import '../common/widgets.dart';
import 'reminder_review_sheet.dart';

/// Done / postpone / cancel for a confirmed reminder. Used by the Reminders
/// screen and the dashboard's care list.
Future<void> showReminderActions(BuildContext context, WidgetRef ref, ReminderRow r) async {
  final l = context.l10n;
  final actions = ref.read(reminderActionsProvider);
  final choice = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(title: Text(r.title), subtitle: Text(r.message)),
        const Divider(),
        ListTile(leading: const Icon(Icons.check_circle_outline), title: Text(l.reminderComplete), onTap: () => Navigator.pop(ctx, 'done')),
        for (final d in [1, 3, 7])
          ListTile(leading: const Icon(Icons.snooze), title: Text(l.reminderPostponeDays(d)), onTap: () => Navigator.pop(ctx, 'p$d')),
        ListTile(leading: const Icon(Icons.cancel_outlined), title: Text(l.reminderCancel), onTap: () => Navigator.pop(ctx, 'cancel')),
      ]),
    ),
  );
  if (choice == null) return;
  try {
    if (choice == 'done') {
      await actions.complete(r.id);
    } else if (choice == 'cancel') {
      await actions.cancel(r.id);
    } else {
      final days = int.parse(choice.substring(1));
      final base = r.dueAt.isBefore(DateTime.now()) ? DateTime.now() : r.dueAt;
      final res = await actions.postpone(r.id, base.add(Duration(days: days)));
      if (context.mounted) reportReconcile(context, res);
    }
  } catch (e) {
    debugPrint('reminder action failed: $e');
    if (context.mounted) showSnack(context, l.commonActionFailed);
  }
}
