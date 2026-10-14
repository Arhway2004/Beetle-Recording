import 'dart:convert';
import 'dart:io';

import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/domain/ai/ai_provider.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/ai/llama_mapping.dart';
import 'package:beetle_keeper/infrastructure/ai/model_store.dart';
import 'package:beetle_keeper/infrastructure/ai/on_device_runtime.dart';
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
      expect((r.toolCalls.single.id, r.toolCalls.single.name, r.toolCalls.single.arguments),
          ('call_a', 'get_beetle_profile', {'beetle_id': 'DHH-001'}));
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
      expect((call.name, call.arguments), ('f', {'a': 1}));
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
      expect((s.available, s.experimental, s.capabilities),
          (true, true, {AiCapability.chat, AiCapability.toolCalling}));
      final r = await on.chat(const [ChatMessage.user('hi')]);
      expect((r.content, r.model), ('[UNKNOWN] no data', 'Test model'));
      expect(runtime.lastMessages!.single.content, 'hi');
    });
  });
}
