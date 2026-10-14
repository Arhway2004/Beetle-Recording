import 'dart:convert';
import 'dart:io';

import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/domain/ai/ai_provider.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/ai/llama_mapping.dart';
import 'package:beetle_keeper/infrastructure/ai/model_store.dart';
import 'package:beetle_keeper/infrastructure/ai/on_device_runtime.dart';
import 'package:beetle_keeper/infrastructure/ai/proactive_prompt.dart';
import 'package:beetle_keeper/infrastructure/ai/providers.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:llamadart/llamadart.dart' as llama;

llama.LlamaCompletionChunk chunk({String? content, List<Map<String, Object?>>? toolCalls}) =>
    llama.LlamaCompletionChunk.fromJson({
      'id': 'c',
      'object': 'chat.completion.chunk',
      'created': 0,
      'model': 'qwen3',
      'choices': [
        {
          'index': 0,
          'delta': {if (content != null) 'content': content, if (toolCalls != null) 'tool_calls': toolCalls},
        },
      ],
    });

OnDeviceModelSpec spec(List<int> bytes) => OnDeviceModelSpec(
      id: 'test',
      displayName: 'Test model',
      fileName: 'test.gguf',
      url: Uri.parse('https://example.test/test.gguf'),
      sha256: sha256.convert(bytes).toString(),
      sizeBytes: bytes.length,
      license: 'MIT',
    );

class _FakeRuntime implements OnDeviceRuntime {
  List<ChatMessage>? lastMessages;

  @override
  Future<ChatResponse> chat(String modelPath, List<ChatMessage> messages, List<ToolDefinition> tools) async {
    lastMessages = messages;
    return const ChatResponse(content: '[UNKNOWN] no data');
  }

  Map<String, Object?>? lastSchema;
  String jsonReply = '{"schema_version": "1", "suggestions": []}';

  @override
  Future<String> completeJson(String modelPath, List<ChatMessage> messages, Map<String, Object?> schema) async {
    lastMessages = messages;
    lastSchema = schema;
    return jsonReply;
  }

  @override
  Future<void> unload() async {}
}

void main() {
  group('llama mapping', () {
    test('JSON Schema parameters become llamadart params with the same schema', () {
      final params = paramsFromSchema({
        'type': 'object',
        'properties': {
          'beetle_id': {'type': 'string', 'description': 'code'},
          'days': {'type': ['integer', 'null']},
          'status': {'type': 'string', 'enum': ['active', 'archived']},
          'ids': {'type': 'array', 'items': {'type': 'string'}},
        },
        'required': ['beetle_id'],
      });
      final schema = llama.ToolDefinition(name: 't', description: 'd', parameters: params).toJsonSchema();
      final props = schema['properties'] as Map;
      expect(schema['required'], ['beetle_id']);
      expect((props['beetle_id'] as Map)['type'], 'string');
      expect((props['days'] as Map)['type'], 'integer');
      expect((props['status'] as Map)['enum'], ['active', 'archived']);
      expect((props['ids'] as Map)['type'], 'array');
    });

    test('streamed text and tool-call deltas fold into one response', () {
      final c = CompletionCollector()
        ..add(chunk(content: 'Looking '))
        ..add(chunk(content: 'it up', toolCalls: [
          {'index': 0, 'id': 'call_a', 'function': {'name': 'get_beetle_profile', 'arguments': '{"beetle_'}},
        ]))
        ..add(chunk(toolCalls: [
          {'index': 0, 'function': {'arguments': 'id":"DHH-001"}'}},
          {'index': 1, 'function': {'name': 'broken', 'arguments': '{not json'}},
        ]));
      final r = c.finish();
      expect(r.content, 'Looking it up');
      expect(r.toolCalls, hasLength(1)); // the malformed call is dropped
      expect((r.toolCalls.single.id, r.toolCalls.single.name), ('call_a', 'get_beetle_profile'));
      expect(r.toolCalls.single.arguments, {'beetle_id': 'DHH-001'});
    });

    test('messages keep roles, tool calls and tool results', () {
      final out = toLlamaMessages([
        const ChatMessage.system('s'),
        const ChatMessage.user('u'),
        const ChatMessage.assistant('', toolCalls: [ToolCall(id: 'x', name: 'f', arguments: {'a': 1})]),
        const ChatMessage.tool('f', '{"ok":true}'),
      ]);
      expect(out.map((m) => m.role), [
        llama.LlamaChatRole.system,
        llama.LlamaChatRole.user,
        llama.LlamaChatRole.assistant,
        llama.LlamaChatRole.tool,
      ]);
      final call = out[2].parts.whereType<llama.LlamaToolCallContent>().single;
      expect(call.name, 'f');
      expect(call.arguments, {'a': 1});
      expect(out[3].parts.whereType<llama.LlamaToolResultContent>().single.result, '{"ok":true}');
    });
  });

  group('model store', () {
    late Directory dir;
    final bytes = List<int>.generate(10000, (i) => i % 251);
    setUp(() async => dir = await Directory.systemTemp.createTemp('bk_models'));
    tearDown(() => dir.delete(recursive: true));

    MockClient server({List<String>? ranges, List<int>? body}) => MockClient.streaming((req, _) async {
          final range = req.headers['Range'];
          ranges?.add(range ?? '');
          final data = body ?? bytes;
          if (range == null) return http.StreamedResponse(Stream.value(data), 200);
          final start = int.parse(range.substring(6, range.length - 1));
          return http.StreamedResponse(Stream.value(data.sublist(start)), 206);
        });

    test('downloads, verifies and reports ready; delete removes it', () async {
      final m = spec(bytes);
      final store = ModelStore(dir, client: () => server());
      expect(await store.state(m), ModelFileState.missing);
      final events = await store.download(m).toList();
      expect(events.last.fraction, 1);
      expect(events.any((e) => e.verifying), isTrue);
      expect(await store.state(m), ModelFileState.ready);
      expect(await store.modelFile(m).readAsBytes(), bytes);
      await store.delete(m);
      expect(await store.state(m), ModelFileState.missing);
    });

    test('resumes a partial download with a Range request', () async {
      final m = spec(bytes);
      await File('${dir.path}/test.gguf.part').writeAsBytes(bytes.sublist(0, 4000));
      final ranges = <String>[];
      final store = ModelStore(dir, client: () => server(ranges: ranges));
      expect(await store.state(m), ModelFileState.partial);
      await store.download(m).drain<void>();
      expect(ranges, ['bytes=4000-']);
      expect(await store.state(m), ModelFileState.ready);
    });

    test('a corrupted file fails the checksum and is discarded', () async {
      final m = spec(bytes);
      final store = ModelStore(dir, client: () => server(body: [...bytes.sublist(1), 0]));
      await expectLater(store.download(m).drain<void>(),
          throwsA(isA<ModelStoreException>().having((e) => e.error, 'error', ModelStoreError.checksum)));
      expect(await store.state(m), ModelFileState.missing);
    });
  });

  group('MobileLlamaProvider', () {
    late Directory dir;
    final bytes = utf8.encode('gguf');
    setUp(() async => dir = await Directory.systemTemp.createTemp('bk_provider'));
    tearDown(() => dir.delete(recursive: true));

    AiProviderSettingRow row({required bool enabled}) => AiProviderSettingRow(
          id: 'p',
          createdAt: DateTime.utc(2026),
          updatedAt: DateTime.utc(2026),
          revision: 1,
          provider: AiProviderKind.mobile,
          enabled: enabled,
          timeoutSeconds: 60,
        );

    test('is unavailable until enabled and downloaded, then offers experimental chat + tools', () async {
      final m = spec(bytes);
      final store = ModelStore(dir, client: () => MockClient((_) async => http.Response.bytes(bytes, 200)));
      final runtime = _FakeRuntime();

      final off = MobileLlamaProvider(settings: row(enabled: false), store: store, runtime: runtime, model: m);
      expect((await off.status()).code, UnavailableCode.disabled);

      final on = MobileLlamaProvider(settings: row(enabled: true), store: store, runtime: runtime, model: m);
      expect((await on.status()).code, UnavailableCode.modelMissing);
      expect(() => on.chat(const [ChatMessage.user('hi')]), throwsA(isA<AiProviderException>()));

      await store.download(m).drain<void>();
      final s = await on.status();
      expect((s.available, s.experimental), (true, true));
      expect(s.capabilities, {AiCapability.chat, AiCapability.toolCalling, AiCapability.proactiveInterpretation});
      final r = await on.chat(const [ChatMessage.user('hi')]);
      expect((r.content, r.model), ('[UNKNOWN] no data', 'Test model'));
      expect(runtime.lastMessages!.single.content, 'hi');
    });
  });

  group('on-device proactive interpretation', () {
    late Directory dir;
    final bytes = utf8.encode('gguf');
    setUp(() async => dir = await Directory.systemTemp.createTemp('bk_proactive'));
    tearDown(() => dir.delete(recursive: true));

    Future<MobileLlamaProvider> ready(_FakeRuntime runtime) async {
      final m = spec(bytes);
      final store = ModelStore(dir, client: () => MockClient((_) async => http.Response.bytes(bytes, 200)));
      await store.download(m).drain<void>();
      return MobileLlamaProvider(
        settings: AiProviderSettingRow(
          id: 'p',
          createdAt: DateTime.utc(2026),
          updatedAt: DateTime.utc(2026),
          revision: 1,
          provider: AiProviderKind.mobile,
          enabled: true,
          timeoutSeconds: 60,
        ),
        store: store,
        runtime: runtime,
        model: m,
        suggestionSchema: () async =>
            (jsonDecode(File('assets/schemas/ai-suggestion.v1.schema.json').readAsStringSync()) as Map)
                .cast<String, Object?>(),
      );
    }

    test('asks with the gateway prompt and the suggestion schema, returns parsed JSON', () async {
      final runtime = _FakeRuntime()
        ..jsonReply = '<think>x</think>{"schema_version": "1", "suggestions": [{"beetle_id": "DHH-001"}]}';
      final p = await ready(runtime);
      final out = await p.interpretProactive({'beetle': {'beetle_id': 'DHH-001'}});
      expect((out! as Map)['suggestions'], hasLength(1)); // validated later by the app, not here
      expect(runtime.lastMessages!.first.content, proactiveSystemPrompt);
      expect(runtime.lastMessages!.last.content, contains('DHH-001'));
      final props = runtime.lastSchema!['properties'] as Map;
      expect(((props['suggestions'] as Map)['items'] as Map)['required'], contains('evidence_record_ids'));
    });

    test('non-JSON output is an error, not an empty result', () async {
      final p = await ready(_FakeRuntime()..jsonReply = 'Sorry, I cannot');
      expect(() => p.interpretProactive(const {}), throwsA(isA<AiProviderException>()));
    });

    test('large contexts are trimmed to the most recent records', () {
      final big = {
        'beetle': {'beetle_id': 'DHH-001'},
        'temperatures': [for (var i = 0; i < 50; i++) {'id': 'temperature-reading-$i-${'x' * 120}'}],
        'weights': [for (var i = 0; i < 20; i++) {'id': 'w$i'}],
      };
      final small = MobileLlamaProvider.compactContext(big);
      expect(jsonEncode(small).length, lessThanOrEqualTo(MobileLlamaProvider.maxContextChars));
      final temps = small['temperatures']! as List;
      expect((temps.last as Map)['id'], startsWith('temperature-reading-49-')); // newest kept
      expect(small['beetle'], big['beetle']);
    });
  });

  group('contracts stay in sync', () {
    test('bundled suggestion schema equals packages/api-contracts', () {
      expect(File('assets/schemas/ai-suggestion.v1.schema.json').readAsStringSync(),
          File('../../packages/api-contracts/schemas/ai-suggestion.v1.schema.json').readAsStringSync());
    });

    test('on-device prompt equals the gateway prompt', () {
      final py = File('../../services/ai-gateway/src/ai_gateway/prompts.py').readAsStringSync();
      final start = py.indexOf('PROACTIVE_SYSTEM_PROMPT = """\\\n') + 'PROACTIVE_SYSTEM_PROMPT = """\\\n'.length;
      expect(py.substring(start, py.indexOf('"""', start)), proactiveSystemPrompt);
    });
  });
}

