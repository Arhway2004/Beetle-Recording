import 'dart:convert';
import 'dart:io';

import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/data/repositories/beetle_repository.dart';
import 'package:beetle_keeper/data/repositories/breeding_read_model.dart';
import 'package:beetle_keeper/data/repositories/models.dart';
import 'package:beetle_keeper/data/repositories/settings_repository.dart';
import 'package:beetle_keeper/data/repositories/temperature_repository.dart';
import 'package:beetle_keeper/domain/ai/ai_orchestrator.dart';
import 'package:beetle_keeper/domain/ai/ai_provider.dart';
import 'package:beetle_keeper/domain/ai/ai_router.dart';
import 'package:beetle_keeper/domain/ai/breeding_tools.dart';
import 'package:beetle_keeper/domain/ai/labeled_answer.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/ai/model_store.dart';
import 'package:beetle_keeper/infrastructure/ai/on_device_runtime.dart';
import 'package:beetle_keeper/infrastructure/ai/providers.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

/// Scripted provider: returns the queued responses in order and records what it saw.
class ScriptedProvider implements AiProvider {
  ScriptedProvider(this.kind, this.responses, {this.available = true, this.caps});
  @override
  final AiProviderKind kind;
  final List<ChatResponse> responses;
  final bool available;
  final Set<AiCapability>? caps;
  final seen = <List<ChatMessage>>[];

  @override
  Future<ProviderStatus> status() async => available
      ? ProviderStatus(
          kind: kind,
          available: true,
          model: 'test-model',
          capabilities: caps ?? {AiCapability.chat, AiCapability.toolCalling, AiCapability.proactiveInterpretation})
      : ProviderStatus.unavailable(kind, UnavailableCode.unreachable);

  @override
  Future<ChatResponse> chat(List<ChatMessage> messages, {List<ToolDefinition> tools = const []}) async {
    seen.add(List.of(messages));
    return responses.removeAt(0);
  }

  @override
  Future<Object?> interpretProactive(Map<String, Object?> context) async => throw UnimplementedError();
}

void main() {
  late AppDatabase db;
  late BeetleRepository beetles;
  late BreedingTools tools;
  late String beetleId;
  final clock = DateTime.utc(2026, 10, 1);

  setUp(() async {
    db = memoryDb();
    beetles = BeetleRepository(db);
    final species = (await db.select(db.species).get()).firstWhere((s) => s.code == 'CCK');
    beetleId = await beetles.createBeetle(NewBeetleInput(
        code: 'CCK-001', speciesId: species.id, sex: Sex.male, initialStage: LifeStage.l3));
    await beetles.addWeight(beetleId: beetleId, measuredAt: DateTime.utc(2026, 9, 1), grams: 20);
    await beetles.addWeight(beetleId: beetleId, measuredAt: DateTime.utc(2026, 9, 29), grams: 24);
    tools = BreedingTools(DriftBreedingReadModel(beetles, TemperatureRepository(db)), clock: () => clock);
  });

  tearDown(() => db.close());

  group('tools', () {
    test('growth metrics come from deterministic code and carry evidence', () async {
      final r = await tools.execute(const ToolCall(id: '1', name: 'get_growth_metrics', arguments: {'beetle_id': 'cck-001'}));
      final json = jsonDecode(r.json) as Map<String, Object?>;
      final m = json['metrics']! as Map<String, Object?>;
      expect(m['change_since_previous_grams'], 4.0);
      expect(m['percent_change_since_previous'], closeTo(20, 1e-9));
      expect(r.evidence.where((e) => e.type == RecordType.weight), hasLength(2));
    });

    test('unknown beetle and unknown tool return structured errors, not data', () async {
      final r1 = await tools.execute(const ToolCall(id: '1', name: 'get_weight_history', arguments: {'beetle_id': 'DHH-999'}));
      expect(jsonDecode(r1.json)['error'], 'not_found');
      final r2 = await tools.execute(const ToolCall(id: '2', name: 'delete_beetle', arguments: {'beetle_id': 'CCK-001'}));
      expect(jsonDecode(r2.json)['error'], 'unknown_tool');
      final r3 = await tools.execute(
          const ToolCall(id: '3', name: 'get_weight_history', arguments: {'beetle_id': 'CCK-001', 'since_days': 0}));
      expect(jsonDecode(r3.json)['error'], 'invalid_arguments');
    });

    test('every tool is read-only except draft proposal, which stores nothing', () async {
      final before = await db.select(db.reminders).get();
      final r = await tools.execute(const ToolCall(id: '1', name: 'propose_reminder_draft', arguments: {
        'beetle_id': 'CCK-001', 'title': 'Check', 'message': 'Look', 'delay_days': 3, 'reason': 'r',
      }));
      expect(r.draft, isNotNull);
      expect(await db.select(db.reminders).get(), hasLength(before.length));
      expect(tools.definitions.map((d) => d.name).where((n) => n.contains('delete') || n.contains('update')), isEmpty);
    });
  });

  group('orchestrator', () {
    test('runs tool loop locally and returns labeled answer with evidence', () async {
      final mac = ScriptedProvider(AiProviderKind.mac, [
        const ChatResponse(content: '', toolCalls: [ToolCall(id: 'a', name: 'get_growth_metrics', arguments: {'beetle_id': 'CCK-001'})]),
        const ChatResponse(content: '[CALCULATED] +4 g (+20%)\n[HYPOTHESIS] growth is steady'),
      ]);
      final o = AiOrchestrator(
        router: AiRouter(providers: {AiProviderKind.mac: mac}, preference: AiRoutingPreference.auto),
        tools: tools,
        clock: () => clock,
      );
      final answer = await o.ask('CCK-001 最近一个月生长正常吗？');
      expect(answer.sections.map((s) => s.kind), [ClaimKind.calculated, ClaimKind.hypothesis]);
      // The app first retrieves the named beetle itself, then runs the model's own call.
      expect(answer.toolCalls, ['get_beetle_profile', 'get_weight_history', 'get_growth_metrics', 'get_growth_metrics']);
      expect(mac.seen.first.where((m) => m.role == ChatRole.tool), hasLength(3)); // records before the first answer
      expect(mac.seen.first[1].content, contains('简体中文')); // answer-language reminder at the end
      expect(answer.evidence, isNotEmpty);
      // Second request contained the tool result produced on-device.
      final toolMsg = mac.seen[1].last;
      expect(toolMsg.role, ChatRole.tool);
      expect(toolMsg.content, contains('change_since_previous_grams'));
    });

    test('stops runaway tool loops', () async {
      final looping = ScriptedProvider(AiProviderKind.mac, [
        for (var i = 0; i < 10; i++)
          const ChatResponse(content: '', toolCalls: [ToolCall(id: 'x', name: 'list_beetles', arguments: {})]),
      ]);
      final o = AiOrchestrator(
          router: AiRouter(providers: {AiProviderKind.mac: looping}, preference: AiRoutingPreference.mac),
          tools: tools,
          maxToolRounds: 3);
      expect(() => o.ask('loop'), throwsA(isA<ToolLoopExceeded>()));
    });
  });

  group('router', () {
    test('auto falls back to mobile only when it supports the capability', () async {
      final macDown = ScriptedProvider(AiProviderKind.mac, [], available: false);
      final mobileChatOnly = ScriptedProvider(AiProviderKind.mobile, [], caps: {AiCapability.chat});
      final router = AiRouter(
          providers: {AiProviderKind.mac: macDown, AiProviderKind.mobile: mobileChatOnly},
          preference: AiRoutingPreference.auto);
      final withTools = await router.select({AiCapability.chat, AiCapability.toolCalling});
      expect(withTools, isA<NoProviderAvailable>());
      expect((withTools as NoProviderAvailable).statuses, hasLength(2));
      final chatOnly = await router.select({AiCapability.chat});
      expect(chatOnly, isA<RoutedTo>());
      expect((chatOnly as RoutedTo).isFallback, isTrue);
    });

    test('manual mac choice never silently uses another provider', () async {
      final router = AiRouter(providers: {
        AiProviderKind.mac: ScriptedProvider(AiProviderKind.mac, [], available: false),
        AiProviderKind.mobile: ScriptedProvider(AiProviderKind.mobile, []),
      }, preference: AiRoutingPreference.mac);
      expect(await router.select({AiCapability.chat}), isA<NoProviderAvailable>());
    });

    test('no AI available → orchestrator raises instead of fabricating', () async {
      final dir = await Directory.systemTemp.createTemp('bk_no_model');
      addTearDown(() => dir.delete(recursive: true));
      final mobile = MobileLlamaProvider(
        settings: await SettingsRepository(db).provider(AiProviderKind.mobile), // disabled by default
        store: ModelStore(dir),
        runtime: LlamaDartRuntime(),
      );
      final o = AiOrchestrator(
        router: AiRouter(providers: {AiProviderKind.mobile: mobile}, preference: AiRoutingPreference.auto),
        tools: tools,
      );
      expect(() => o.ask('hi'), throwsA(isA<NoAiProviderException>()));
      expect((await mobile.status()).code, UnavailableCode.disabled);
    });
  });

  group('grounding (real case: 0.18 g recorded, model said 0.12 g)', () {
    test('loosely typed codes resolve to the stored code', () async {
      await beetles.addWeight(beetleId: beetleId, measuredAt: DateTime.utc(2026, 9, 30), grams: 0.18);
      for (final typed in ['cck-01', 'CCK 1', 'cck1', 'CCK-0001', 'cck-001']) {
        final r = await tools.execute(ToolCall(id: '1', name: 'get_weight_history', arguments: {'beetle_id': typed}));
        final json = jsonDecode(r.json) as Map<String, Object?>;
        expect(json['beetle_id'], 'CCK-001', reason: typed);
        expect(jsonEncode(json), contains('0.18'), reason: typed);
      }
      final miss = await tools.execute(const ToolCall(id: '1', name: 'get_weight_history', arguments: {'beetle_id': 'cck-02'}));
      expect(jsonDecode(miss.json)['error'], 'not_found');
    });

    test('a weight that is not in the records is flagged, a recorded one is not', () async {
      await beetles.addWeight(beetleId: beetleId, measuredAt: DateTime.utc(2026, 9, 30), grams: 0.18);
      final provider = ScriptedProvider(AiProviderKind.mobile, [
        const ChatResponse(
            content: '', toolCalls: [ToolCall(id: 'a', name: 'get_weight_history', arguments: {'beetle_id': 'cck-01'})]),
        const ChatResponse(
            content: '[VERIFIED] CCK-001 最近体重 0.12 g（2026-09-30）\n[VERIFIED] 最新记录为 0.18 g\n[HYPOTHESIS] 可能会长到 1.5 g'),
      ]);
      final answer = await AiOrchestrator(
        router: AiRouter(providers: {AiProviderKind.mobile: provider}, preference: AiRoutingPreference.mobile),
        tools: tools,
      ).ask('dhh-01 体重多少');
      expect(answer.sections[0].unsupported, ['0.12 g']); // invented → warned
      expect(answer.sections[1].unsupported, isEmpty); // in the records
      expect(answer.sections[2].unsupported, isEmpty); // hypotheses are not fact claims
    });

    test('model skips tools for a named beetle: the app fetched the data anyway', () async {
      final provider = ScriptedProvider(AiProviderKind.mobile, [
        const ChatResponse(content: '[CALCULATED] The latest weight of CCK-001 is 0.12 grams.'),
      ]);
      final answer = await AiOrchestrator(
        router: AiRouter(providers: {AiProviderKind.mobile: provider}, preference: AiRoutingPreference.mobile),
        tools: tools,
      ).ask('CCK-001的数据');
      expect(provider.seen.single.where((m) => m.role == ChatRole.tool).map((m) => m.content).join(), contains('24'));
      expect(answer.toolCalls, isNotEmpty);
      expect(answer.sections.single.unsupported, ['0.12 grams']); // 'grams' is recognised too
    });

    test('no tool call at all: every stated measurement is unsupported', () async {
      final provider = ScriptedProvider(AiProviderKind.mobile, [
        const ChatResponse(content: '[VERIFIED] 体重 0.12 g，温度 24 ℃'),
      ]);
      final answer = await AiOrchestrator(
        router: AiRouter(providers: {AiProviderKind.mobile: provider}, preference: AiRoutingPreference.mobile),
        tools: tools,
      ).ask('体重多少');
      expect(answer.sections.single.unsupported, ['0.12 g', '24 ℃']);
    });
  });
}

