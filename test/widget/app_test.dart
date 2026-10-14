import 'dart:io';

import 'package:beetle_keeper/app.dart';
import 'package:beetle_keeper/application/providers.dart';
import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/data/repositories/beetle_repository.dart';
import 'package:beetle_keeper/data/repositories/models.dart';
import 'package:beetle_keeper/data/repositories/reminder_repository.dart';
import 'package:beetle_keeper/data/repositories/settings_repository.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/storage/secure_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = memoryDb());

  Widget app({Map<String, String> settings = const {}}) => ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          documentsDirProvider.overrideWithValue(Directory.systemTemp),
          supportDirProvider.overrideWithValue(Directory.systemTemp),
          notificationGatewayProvider.overrideWithValue(FakeNotificationGateway()),
          secretStoreProvider.overrideWithValue(MemorySecretStore()),
          initialSettingsProvider.overrideWithValue(settings),
        ],
        child: const BeetleKeeperApp(),
      );

  /// Drift runs real (non-fake) async work, so let it progress in real time
  /// and then pump frames; pumpAndSettle would spin on progress indicators.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 30)));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> pumpApp(WidgetTester tester, {Map<String, String> settings = const {}}) async {
    tester.view.physicalSize = const Size(1170, 2532); // iPhone-sized, phone layout
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(settings: settings));
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    // Closing waits on Drift's stream timers, which only advance in fake time.
    await tester.pumpWidget(const SizedBox());
    final closing = db.close();
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(() => closing);
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('boots offline in Simplified Chinese with an empty state', (tester) async {
    await pumpApp(tester);
    expect(find.text('还没有甲虫'), findsOneWidget);
    expect(find.text('添加甲虫'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('opening Settings does not highlight Dashboard in the bottom bar', (tester) async {
    await pumpApp(tester);
    final bar = find.byType(NavigationBar);
    expect(find.descendant(of: bar, matching: find.byIcon(Icons.space_dashboard)), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings_outlined).first);
    await settle(tester);
    expect(find.descendant(of: bar, matching: find.byIcon(Icons.space_dashboard)), findsNothing);
    expect(find.descendant(of: bar, matching: find.byIcon(Icons.space_dashboard_outlined)), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('dashboard puts overdue care first and marks it done in place', (tester) async {
    await tester.runAsync(() async {
      final id = await BeetleRepository(db)
          .createBeetle(NewBeetleInput(code: 'DHH-001', speciesId: builtinSpeciesId('DHH'), sex: Sex.male));
      await ReminderRepository(db).createUserReminder(
          beetleId: id, title: '换土', message: 'm', dueAt: DateTime.now().subtract(const Duration(days: 1)));
    });
    await pumpApp(tester);
    expect(find.text('需要处理'), findsOneWidget);
    expect(find.text('已逾期 1 项'), findsOneWidget);
    expect(find.text('换土'), findsOneWidget);

    await tester.tap(find.byTooltip('标记完成'));
    await settle(tester);
    expect(find.text('需要处理'), findsNothing);
    expect(find.text('今天没有待办，一切正常'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('beetle page shows identity, roadmap and the tabs', (tester) async {
    late String id;
    await tester.runAsync(() async {
      final repo = BeetleRepository(db);
      id = await repo.createBeetle(NewBeetleInput(code: 'DHH-007', speciesId: builtinSpeciesId('DHH'), sex: Sex.male));
      await repo.addLifeStageEvent(beetleId: id, occurredAt: DateTime.utc(2026, 3, 1), stage: LifeStage.l3);
      await repo.addWeight(beetleId: id, measuredAt: DateTime.utc(2026, 4, 1), grams: 30.5);
    });
    await pumpApp(tester);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('甲虫')));
    await settle(tester);
    await tester.tap(find.text('DHH-007').first);
    await settle(tester);

    expect(find.text('成长路线'), findsOneWidget);
    expect(find.text('当前阶段'), findsOneWidget); // L3, stated in words
    expect(find.text('未记录'), findsNWidgets(2)); // L1 and L2: no invented history
    expect(find.text('尚未到达'), findsNWidgets(3)); // prepupa, pupa, adult
    expect(find.text('添加记录'), findsOneWidget);
    expect(find.textContaining('30.5 g'), findsWidgets);

    await tester.tap(find.text('记录').last);
    await settle(tester);
    expect(find.text('补录历史'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('English locale is selectable', (tester) async {
    await tester.runAsync(() => SettingsRepository(db).set(SettingsKeys.locale, 'en'));
    await pumpApp(tester, settings: {'ui.locale': 'en'});
    expect(find.text('No beetles yet'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('beetle form validates and creates a beetle with history', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
    expect(find.text('新增甲虫'), findsOneWidget);

    // Saving without species fails validation.
    await tester.tap(find.text('保存'));
    await settle(tester);
    expect(find.text('必填'), findsWidgets);

    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await settle(tester);
    await tester.tap(find.textContaining('DHH ·').last);
    await settle(tester);
    expect(find.widgetWithText(TextFormField, 'DHH-001'), findsOneWidget);

    final weight = find.widgetWithText(TextFormField, '当前体重（克）');
    await tester.scrollUntilVisible(weight, 200, scrollable: find.descendant(of: find.byType(Form), matching: find.byType(Scrollable)).first);
    await tester.enterText(weight, '35.5');
    await tester.tap(find.text('保存'));
    await settle(tester);

    final beetles = (await tester.runAsync(() => db.select(db.beetles).get()))!;
    expect(beetles.single.code, 'DHH-001');
    final weights = (await tester.runAsync(() => db.select(db.weightRecords).get()))!;
    expect(weights.single.weightGrams, 35.5);
    expect(find.text('DHH-001'), findsWidgets); // detail page
    await dispose(tester);
  });

  testWidgets('assistant explains when no AI is available instead of answering', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('AI 助手').last);
    await settle(tester);
    await tester.enterText(find.byType(TextField), 'CCK-001 最近一个月生长正常吗？');
    await tester.tap(find.byIcon(Icons.send));
    await settle(tester);
    expect(find.textContaining('当前没有可用的 AI 模型'), findsOneWidget);
    await dispose(tester);
  });
}
