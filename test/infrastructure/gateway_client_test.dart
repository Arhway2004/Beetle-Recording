import 'dart:convert';

import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/domain/ai/ai_provider.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/infrastructure/ai/gateway_client.dart';
import 'package:beetle_keeper/infrastructure/ai/network_policy.dart';
import 'package:beetle_keeper/infrastructure/ai/providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

AiProviderSettingRow macRow({
  bool enabled = true,
  String? url = 'https://mac.local:8443',
  DateTime? consent,
}) =>
    AiProviderSettingRow(
      id: 'x',
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
      revision: 1,
      provider: AiProviderKind.mac,
      enabled: enabled,
      baseUrl: url,
      model: 'qwen3:8b',
      timeoutSeconds: 30,
      consentGrantedAt: consent,
    );

void main() {
  group('network policy', () {
    test('classifies hosts', () {
      expect(classifyHost('localhost'), HostScope.loopback);
      expect(classifyHost('127.0.0.1'), HostScope.loopback);
      expect(classifyHost('192.168.1.20'), HostScope.privateNetwork);
      expect(classifyHost('10.0.0.5'), HostScope.privateNetwork);
      expect(classifyHost('172.20.1.1'), HostScope.privateNetwork);
      expect(classifyHost('100.101.1.2'), HostScope.privateNetwork); // Tailscale CGNAT
      expect(classifyHost('my-mac.local'), HostScope.privateNetwork);
      expect(classifyHost('mac.tailnet.ts.net'), HostScope.privateNetwork);
      expect(classifyHost('8.8.8.8'), HostScope.public);
      expect(classifyHost('example.com'), HostScope.public);
    });

    test('https required except loopback', () {
      expect(isTransportAllowed(Uri.parse('http://192.168.1.2:8443')), isFalse);
      expect(isTransportAllowed(Uri.parse('https://192.168.1.2:8443')), isTrue);
      expect(isTransportAllowed(Uri.parse('http://127.0.0.1:8443')), isTrue);
    });

    test('fingerprint normalization', () {
      final hex = List.filled(32, 'AB').join(':');
      expect(normalizeFingerprint(hex), 'ab' * 32);
      expect(normalizeFingerprint('abc'), isNull);
    });
  });

  group('gateway client', () {
    GatewayClient client(MockClientHandler h) => GatewayClient(
          GatewayConfig(baseUrl: Uri.parse('https://mac.local:8443'), token: 'secret', timeout: const Duration(seconds: 5)),
          httpClient: MockClient(h),
        );

    test('sends bearer token and parses tool calls', () async {
      late http.Request seen;
      final c = client((req) async {
        seen = req;
        return http.Response(
            jsonEncode({
              'model': 'qwen3:8b',
              'message': {
                'role': 'assistant',
                'content': '',
                'tool_calls': [
                  {'id': 'c1', 'name': 'get_weight_history', 'arguments': {'beetle_id': 'DHH-001'}},
                ],
              },
            }),
            200);
      });
      final r = await c.chat(const [ChatMessage.user('hi')], const []);
      expect(seen.headers['Authorization'], 'Bearer secret');
      expect(seen.url.path, '/api/v1/chat');
      expect(r.toolCalls.single.name, 'get_weight_history');
      expect(r.toolCalls.single.arguments['beetle_id'], 'DHH-001');
    });

    test('maps HTTP errors to typed codes', () async {
      Future<UnavailableCode?> codeFor(int status) async {
        try {
          await client((_) async => http.Response('{}', status)).health();
          return null;
        } on AiProviderException catch (e) {
          return e.code;
        }
      }

      expect(await codeFor(401), UnavailableCode.unauthorized);
      expect(await codeFor(503), UnavailableCode.modelMissing);
    });

    test('refuses plain http to a LAN host before any request', () async {
      var called = false;
      final c = GatewayClient(
        GatewayConfig(baseUrl: Uri.parse('http://192.168.1.2:8443'), token: 't', timeout: const Duration(seconds: 1)),
        httpClient: MockClient((_) async {
          called = true;
          return http.Response('{}', 200);
        }),
      );
      expect(() => c.health(), throwsA(isA<AiProviderException>().having((e) => e.code, 'code', UnavailableCode.insecureTransport)));
      expect(called, isFalse);
    });
  });

  group('Mac provider status', () {
    test('requires enable, config and consent before touching the network', () async {
      expect((await MacGatewayProvider(settings: macRow(enabled: false), token: 't').status()).code, UnavailableCode.disabled);
      expect((await MacGatewayProvider(settings: macRow(), token: null).status()).code, UnavailableCode.notConfigured);
      expect((await MacGatewayProvider(settings: macRow(), token: 't').status()).code, UnavailableCode.consentRequired);
    });

    test('reports model missing when the configured model is not pulled', () async {
      final p = MacGatewayProvider(
        settings: macRow(consent: DateTime.utc(2026)),
        token: 't',
        clientFactory: (cfg) => GatewayClient(cfg,
            httpClient: MockClient((_) async => http.Response(
                jsonEncode({'status': 'ok', 'ollama_reachable': true, 'models': ['llama3:8b']}), 200))),
      );
      final s = await p.status();
      expect(s.available, isFalse);
      expect(s.code, UnavailableCode.modelMissing);
    });

    test('available with chat + tools + proactive when healthy', () async {
      final p = MacGatewayProvider(
        settings: macRow(consent: DateTime.utc(2026)),
        token: 't',
        clientFactory: (cfg) => GatewayClient(cfg,
            httpClient: MockClient((_) async => http.Response(
                jsonEncode({'status': 'ok', 'ollama_reachable': true, 'models': ['qwen3:8b']}), 200))),
      );
      final s = await p.status();
      expect(s.supports({AiCapability.chat, AiCapability.toolCalling, AiCapability.proactiveInterpretation}), isTrue);
      expect(s.supports({AiCapability.vision}), isFalse);
    });
  });
}
