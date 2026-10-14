import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'application/providers.dart';
import 'data/database/app_database.dart';
import 'data/repositories/settings_repository.dart';
import 'infrastructure/notifications/notification_gateway.dart';
import 'infrastructure/notifications/reminder_scheduler.dart';
import 'data/repositories/reminder_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final db = AppDatabase.open();
  final docs = await getApplicationDocumentsDirectory();
  final support = await getApplicationSupportDirectory();
  final initialSettings = await SettingsRepository(db).all();
  final notifications = LocalNotificationGateway();

  runApp(ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(db),
      documentsDirProvider.overrideWithValue(docs),
      supportDirProvider.overrideWithValue(support),
      notificationGatewayProvider.overrideWithValue(notifications),
      initialSettingsProvider.overrideWithValue(initialSettings),
    ],
    child: const BeetleKeeperApp(),
  ));

  // Startup maintenance runs after the first frame and never blocks the UI.
  // Reminders are rescheduled from the local database: no network involved.
  try {
    await notifications.initialize();
    await ReminderScheduler(ReminderRepository(db), notifications).reconcile();
  } catch (e) {
    debugPrint('notification startup failed: $e');
  }
}
