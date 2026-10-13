import 'package:beetle_keeper/application/proactive_care_service.dart';
import 'package:beetle_keeper/application/reminder_actions.dart';
import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/data/repositories/ai_memory_repository.dart';
import 'package:beetle_keeper/data/repositories/beetle_repository.dart';
import 'package:beetle_keeper/data/repositories/breeding_read_model.dart';
import 'package:beetle_keeper/data/repositories/models.dart';
import 'package:beetle_keeper/data/repositories/reminder_repository.dart';
import 'package:beetle_keeper/data/repositories/settings_repository.dart';
import 'package:beetle_keeper/data/repositories/temperature_repository.dart';
import 'package:beetle_keeper/domain/ai/ai_provider.dart';
import 'package:beetle_keeper/domain/ai/ai_router.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/domain/reminders/reminder_state.dart';
import 'package:beetle_keeper/infrastructure/notifications/reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

class _InterpretProvider implements AiProvider {
  _InterpretProvider(this.output);
  final Object? Function(Map<String, Object?> ctx) output;

  @override
  AiProviderKind get kind => AiProviderKind.mac;

  @override
  Future<ProviderStatus> status() async => const ProviderStatus(
      kind: AiProviderKind.mac, available: true, model: 'm', capabilities: {AiCapability.proactiveInterpretation});

  @override
  Future<ChatResponse> chat(List<ChatMessage> messages, {List<ToolDefinition> tools = const []}) => throw UnimplementedError();

  @override
  Future<Object?> interpretProactive(Map<String, Object?> context) async => output(context);
}

void main() {
  late AppDatabase db;
  late BeetleRepository beetles;
  late ReminderRepository reminders;
  late ProactiveCareService service;
  late FakeNotificationGateway notifications;
  late ReminderActions actions;
  late String beetleId;
  final now = DateTime.now().toUtc();

  setUp(() async {
    db = memoryDb();
    beetles = BeetleRepository(db);
    reminders = ReminderRepository(db);
    final settings = SettingsRepository(db);
    service = ProactiveCareService(
      readModel: DriftBreedingReadModel(beetles, TemperatureRepository(db)),
      reminders: reminders,
      settings: settings,
      memory: AiMemoryRepository(db),
      texts: FakeCareTexts.new,
    );
    notifications = FakeNotificationGateway();
    actions = ReminderActions(reminders, ReminderScheduler(reminders, notifications), notifications, settings);
    beetleId = await beetles.createBeetle(NewBeetleInput(
        code: 'CCK-001', speciesId: builtinSpeciesId('CCK'), sex: Sex.female, initialStage: LifeStage.l3));
  });
  tearDown(() => db.close());

  test('saving a record creates a suggestion once; re-evaluation does not duplicate', () async {
    await beetles.addWeight(beetleId: beetleId, measuredAt: now.subtract(const Duration(days: 14)), grams: 40);
    await beetles.addWeight(beetleId: beetleId, measuredAt: now.subtract(const Duration(hours: 1)), grams: 35);
    expect(await service.evaluate(beetleId: beetleId), 1);
    expect(await service.evaluate(beetleId: beetleId), 0);
    final r = (await db.select(db.reminders).get()).single;
    expect(r.status, ReminderStatus.suggested);
    expect(r.eventType, 'weight_loss');
    expect(r.source, ReminderSource.rule);
    expect(await reminders.evidenceFor(r.id), hasLength(2));
    expect(notifications.pending, isEmpty, reason: 'suggestions are never scheduled');
  });

  test('rejected suggestion is not re-suggested for the same period', () async {
    await beetles.addWeight(beetleId: beetleId, measuredAt: now.subtract(const Duration(days: 14)), grams: 40);
    await beetles.addWeight(beetleId: beetleId, measuredAt: now, grams: 35);
    await service.evaluate();
    final r = (await db.select(db.reminders).get()).single;
    await actions.reject(r.id);
    expect(await service.evaluate(), 0);
  });

  test('accept → confirmed → scheduled with contextual permission request', () async {
    await beetles.addWeight(beetleId: beetleId, measuredAt: now.subtract(const Duration(days: 14)), grams: 40);
    await beetles.addWeight(beetleId: beetleId, measuredAt: now, grams: 35);
    await service.evaluate();
    final r = (await db.select(db.reminders).get()).single;
    notifications.permission = false;
    final denied = await actions.accept(r.id, message: 'edited');
    expect(notifications.permissionRequested, isTrue);
    expect(denied.permissionDenied, isTrue);
    expect((await reminders.byId(r.id)).status, ReminderStatus.confirmed);
    expect((await reminders.byId(r.id)).message, 'edited');

    notifications.permission = true;
    final ok = await ReminderScheduler(reminders, notifications).reconcile();
    expect(ok.scheduled, 1);
    expect((await reminders.byId(r.id)).status, ReminderStatus.scheduled);
    expect(notifications.pending, hasLength(1));

    await actions.complete(r.id);
    expect(notifications.pending, isEmpty);
    expect((await reminders.byId(r.id)).status, ReminderStatus.completed);
  });

  test('postpone moves the OS notification; disable similar suppresses future suggestions', () async {
    final id = await reminders.createUserReminder(title: 't', message: 'm', dueAt: now.add(const Duration(days: 1)));
    await ReminderScheduler(reminders, notifications).reconcile();
    final newDue = now.add(const Duration(days: 4));
    await actions.postpone(id, newDue);
    expect(notifications.pending.values.single.at.difference(newDue).inSeconds.abs(), lessThan(2));

    await beetles.addWeight(beetleId: beetleId, measuredAt: now.subtract(const Duration(days: 14)), grams: 40);
    await beetles.addWeight(beetleId: beetleId, measuredAt: now, grams: 35);
    await service.evaluate();
    final s = (await reminders.existingForDedupe()).firstWhere((r) => r.eventType == 'weight_loss');
    await actions.disableSimilar(s.id);
    expect((await reminders.byId(s.id)).status, ReminderStatus.cancelled);
    await beetles.addWeight(beetleId: beetleId, measuredAt: now.add(const Duration(minutes: 1)), grams: 30);
    expect(await service.evaluate(), 0);
  });

  test('scheduler respects the OS pending-notification cap and keeps the soonest', () async {
    for (var i = 1; i <= 5; i++) {
      await reminders.createUserReminder(title: 'r$i', message: '', dueAt: now.add(Duration(days: i)));
    }
    final res = await ReminderScheduler(reminders, notifications, maxPending: 3).reconcile();
    expect(res.scheduled, 3);
    expect(res.deferred, 2);
    expect(notifications.pending.values.map((p) => p.title).toSet(), {'r1', 'r2', 'r3'});
  });

  test('invalid transitions are rejected', () async {
    final id = await reminders.createUserReminder(title: 't', message: 'm', dueAt: now.add(const Duration(days: 1)));
    await reminders.complete(id);
    expect(() => reminders.accept(id), throwsA(isA<InvalidReminderTransition>()));
  });

  group('AI interpretation', () {
    Map<String, Object?> suggestion({required String beetle, required List<String> evidence}) => {
          'beetle_id': beetle,
          'event_type': 'possible_prepupa',
          'severity': 'observation',
          'confidence': 'low',
          'basis': 'measured',
          'evidence_record_ids': evidence,
          'reason': 'r',
          'recommendation': 'observe',
          'suggested_reminder': {'enabled': true, 'delay_days': 3, 'title': '观察', 'message': 'm'},
          'requires_user_confirmation': true,
        };

    test('valid output becomes a suggested AI reminder labelled as inference', () async {
      final obs = await beetles.addObservation(
          beetleId: beetleId, observedAt: now, category: ObservationCategory.colorChange, description: 'yellow');
      final router = AiRouter(providers: {
        AiProviderKind.mac: _InterpretProvider((_) => {'schema_version': '1', 'suggestions': [suggestion(beetle: 'CCK-001', evidence: [obs])]}),
      }, preference: AiRoutingPreference.auto);
      final res = await service.interpretWithAi(beetleId, router);
      expect(res.stored, 1);
      final r = (await (db.select(db.reminders)..where((x) => x.source.equalsValue(ReminderSource.ai))).get()).single;
      expect(r.status, ReminderStatus.suggested);
      expect(r.basis, 'ai_inference', reason: 'AI cannot claim a measured basis');
      expect(r.analysisId, isNotNull);
      expect(notifications.pending, isEmpty);
    });

    test('fabricated evidence, wrong beetle, and malformed output are rejected', () async {
      final router = AiRouter(providers: {
        AiProviderKind.mac: _InterpretProvider((_) => {
              'schema_version': '1',
              'suggestions': [
                suggestion(beetle: 'CCK-001', evidence: ['OBS-does-not-exist']),
                suggestion(beetle: 'DHH-001', evidence: [beetleId]),
                {'free_text': 'schedule it now'},
              ],
            }),
      }, preference: AiRoutingPreference.auto);
      final res = await service.interpretWithAi(beetleId, router);
      expect(res.stored, 0);
      expect(res.rejected, 3);
      expect(await db.select(db.reminders).get(), isEmpty);
      expect(await db.select(db.aiAnalyses).get(), hasLength(1), reason: 'raw output kept for audit');
    });
  });
}
