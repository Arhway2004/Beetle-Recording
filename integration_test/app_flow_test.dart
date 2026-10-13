// End-to-end flow on a real device/simulator (real SQLite engine, real
// platform plugins except notifications/secure storage, which are faked to
// avoid OS permission dialogs):  flutter test integration_test
import 'dart:io';

import 'package:beetle_keeper/app.dart';
import 'package:beetle_keeper/application/providers.dart';
import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/storage/secure_store.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/helpers/test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('create beetle → record weight loss → suggestion awaits confirmation', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        documentsDirProvider.overrideWithValue(Directory.systemTemp),
        notificationGatewayProvider.overrideWithValue(FakeNotificationGateway()),
        secretStoreProvider.overrideWithValue(MemorySecretStore()),
      ],
      child: const BeetleKeeperApp(),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('CCK ·').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, '当前体重（克）'), '40');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final beetle = (await db.select(db.beetles).get()).single;
    expect(beetle.code, 'CCK-001');

    // Record a significant loss directly through the record form.
    await tester.tap(find.widgetWithText(ActionChip, '体重'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, '体重（克）'), '34');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final reminders = await db.select(db.reminders).get();
    expect(reminders.single.status, ReminderStatus.suggested);
    expect(reminders.single.eventType, 'weight_loss');
    await db.close();
  });
}
