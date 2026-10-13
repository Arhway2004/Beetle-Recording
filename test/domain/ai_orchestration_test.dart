import 'dart:convert';

import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/data/repositories/beetle_repository.dart';
import 'package:beetle_keeper/data/repositories/breeding_read_model.dart';
import 'package:beetle_keeper/data/repositories/models.dart';
import 'package:beetle_keeper/data/repositories/temperature_repository.dart';
import 'package:beetle_keeper/domain/ai/ai_orchestrator.dart';
import 'package:beetle_keeper/domain/ai/ai_provider.dart';
import 'package:beetle_keeper/domain/ai/ai_router.dart';
import 'package:beetle_keeper/domain/ai/breeding_tools.dart';
import 'package:beetle_keeper/domain/ai/labeled_answer.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
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
      expect(answer.toolCalls, ['get_growth_metrics']);
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
      final o = AiOrchestrator(
        router: AiRouter(providers: {AiProviderKind.mobile: const MobileLlamaProvider()}, preference: AiRoutingPreference.auto),
        tools: tools,
      );
      expect(() => o.ask('hi'), throwsA(isA<NoAiProviderException>()));
      expect((await const MobileLlamaProvider().status()).code, UnavailableCode.notBundled);
    });
  });
}
