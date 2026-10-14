import 'dart:convert';

import 'package:flutter/services.dart';

import '../../data/database/app_database.dart';
import '../../domain/ai/ai_provider.dart';
import '../../domain/models/enums.dart';
import 'gateway_client.dart';
import 'model_store.dart';
import 'network_policy.dart';
import 'on_device_runtime.dart';
import 'proactive_prompt.dart';

/// Provider A: Ollama on the user's Mac, through the authenticated gateway.
class MacGatewayProvider implements AiProvider {
  MacGatewayProvider({
    required this.settings,
    required this.token,
    GatewayClient Function(GatewayConfig)? clientFactory,
    DateTime Function()? clock,
  })  : _factory = clientFactory ?? GatewayClient.new,
        _clock = clock ?? DateTime.now;

  final AiProviderSettingRow settings;
  final String? token;
  final GatewayClient Function(GatewayConfig) _factory;
  final DateTime Function() _clock;

  ProviderStatus? _cached;
  DateTime? _cachedAt;
  GatewayClient? _client;

  @override
  AiProviderKind get kind => AiProviderKind.mac;

  Uri? get _uri {
    final raw = settings.baseUrl;
    if (raw == null || raw.isEmpty) return null;
    final uri = Uri.tryParse(raw);
    return (uri == null || uri.host.isEmpty) ? null : uri;
  }

  GatewayClient get client => _client ??= _factory(GatewayConfig(
        baseUrl: _uri!,
        token: token!,
        timeout: Duration(seconds: settings.timeoutSeconds),
        model: settings.model,
        certSha256: settings.certSha256,
      ));

  /// Local configuration problems, without touching the network.
  ProviderStatus? _localCheck() {
    if (!settings.enabled) return const ProviderStatus.unavailable(AiProviderKind.mac, UnavailableCode.disabled);
    final uri = _uri;
    if (uri == null || token == null || token!.isEmpty) {
      return const ProviderStatus.unavailable(AiProviderKind.mac, UnavailableCode.notConfigured);
    }
    if (!isTransportAllowed(uri)) {
      return const ProviderStatus.unavailable(AiProviderKind.mac, UnavailableCode.insecureTransport);
    }
    if (settings.consentGrantedAt == null) {
      return const ProviderStatus.unavailable(AiProviderKind.mac, UnavailableCode.consentRequired);
    }
    return null;
  }

  @override
  Future<ProviderStatus> status() async {
    final local = _localCheck();
    if (local != null) return local;
    if (_cached != null && _clock().difference(_cachedAt!) < const Duration(seconds: 20)) {
      return _cached!;
    }
    ProviderStatus result;
    try {
      final h = await client.health();
      final model = settings.model;
      if (!h.ollamaReachable) {
        result = const ProviderStatus.unavailable(AiProviderKind.mac, UnavailableCode.modelMissing,
            detail: 'Ollama not reachable from gateway');
      } else if (model != null && h.models.isNotEmpty && !h.models.contains(model)) {
        result = ProviderStatus.unavailable(AiProviderKind.mac, UnavailableCode.modelMissing,
            detail: 'Model $model not pulled. Available: ${h.models.join(', ')}');
      } else {
        result = ProviderStatus(
          kind: AiProviderKind.mac,
          available: true,
          model: model,
          capabilities: const {
            AiCapability.chat,
            AiCapability.toolCalling,
            AiCapability.proactiveInterpretation,
          },
        );
      }
    } on AiProviderException catch (e) {
      result = ProviderStatus.unavailable(AiProviderKind.mac, e.code ?? UnavailableCode.unreachable,
          detail: e.message);
    }
    _cached = result;
    _cachedAt = _clock();
    return result;
  }

  void invalidate() => _cached = null;

  @override
  Future<ChatResponse> chat(List<ChatMessage> messages, {List<ToolDefinition> tools = const []}) {
    final local = _localCheck();
    if (local != null) throw AiProviderException('Mac AI unavailable', code: local.code);
    return _retryOnce(() => client.chat(messages, tools));
  }

  @override
  Future<Object?> interpretProactive(Map<String, Object?> context) {
    final local = _localCheck();
    if (local != null) throw AiProviderException('Mac AI unavailable', code: local.code);
    return _retryOnce(() => client.interpretProactive(context));
  }

  /// One reconnection attempt for transient network errors (e.g. Wi-Fi roaming).
  Future<T> _retryOnce<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on AiProviderException catch (e) {
      if (!e.retryable || e.code == UnavailableCode.modelMissing) {
        invalidate();
        rethrow;
      }
      await Future<void>.delayed(const Duration(milliseconds: 800));
      try {
        return await body();
      } finally {
        invalidate();
      }
    }
  }
}

/// Provider B: on-device llama.cpp (llamadart) with a downloaded GGUF model.
/// Nothing leaves the phone, so no consent is needed; the user still has to
/// download the model and switch the provider on. A 1.7B model is less
/// reliable than the Mac's 8B model, so the status is marked experimental and
/// the UI says so. Proactive output is grammar-constrained to the suggestion
/// schema and then validated by the app exactly like the gateway's.
class MobileLlamaProvider implements AiProvider {
  MobileLlamaProvider({
    required this.settings,
    required this.store,
    required this.runtime,
    OnDeviceModelSpec? model,
    Future<Map<String, Object?>> Function()? suggestionSchema,
  })  : model = model ?? defaultOnDeviceModel,
        _suggestionSchema = suggestionSchema ?? _bundledSuggestionSchema;

  final AiProviderSettingRow settings;
  final ModelStore store;
  final OnDeviceRuntime runtime;
  final OnDeviceModelSpec model;
  final Future<Map<String, Object?>> Function() _suggestionSchema;

  static Future<Map<String, Object?>> _bundledSuggestionSchema() async =>
      (jsonDecode(await rootBundle.loadString('assets/schemas/ai-suggestion.v1.schema.json')) as Map)
          .cast<String, Object?>();

  /// Upper bound for the serialized records, so prompt + answer fit the
  /// on-device context window (~6k tokens).
  static const maxContextChars = 9000;

  @override
  AiProviderKind get kind => AiProviderKind.mobile;

  @override
  Future<ProviderStatus> status() async {
    if (!settings.enabled) {
      return const ProviderStatus.unavailable(AiProviderKind.mobile, UnavailableCode.disabled);
    }
    if (await store.state(model) != ModelFileState.ready) {
      return ProviderStatus.unavailable(AiProviderKind.mobile, UnavailableCode.modelMissing,
          detail: '${model.displayName} not downloaded');
    }
    return ProviderStatus(
      kind: AiProviderKind.mobile,
      available: true,
      model: model.displayName,
      experimental: true,
      capabilities: const {AiCapability.chat, AiCapability.toolCalling, AiCapability.proactiveInterpretation},
    );
  }

  Future<String> _readyModelPath() async {
    final s = await status();
    if (!s.available) throw AiProviderException('On-device AI unavailable', code: s.code);
    return store.modelFile(model).path;
  }

  @override
  Future<ChatResponse> chat(List<ChatMessage> messages, {List<ToolDefinition> tools = const []}) async {
    final response = await runtime.chat(await _readyModelPath(), messages, tools);
    return ChatResponse(content: response.content, toolCalls: response.toolCalls, model: model.displayName);
  }

  @override
  Future<Object?> interpretProactive(Map<String, Object?> context) async {
    final path = await _readyModelPath();
    final records = jsonEncode(compactContext(context));
    final raw = await runtime.completeJson(
      path,
      [
        const ChatMessage.system(proactiveSystemPrompt),
        ChatMessage.user('Breeding records (JSON):\n$records'),
      ],
      suggestionBatchSchema(await _suggestionSchema()),
    );
    try {
      return jsonDecode(raw.replaceAll(RegExp(r'<think>[\s\S]*?</think>'), '').trim());
    } on FormatException catch (e) {
      throw AiProviderException('On-device model did not return valid JSON: ${e.message}');
    }
  }

  /// Keeps the most recent records until the JSON fits [maxContextChars].
  /// Dropping records is safe: the model can only cite IDs it was shown, and
  /// the app accepts only IDs from the full context.
  static Map<String, Object?> compactContext(Map<String, Object?> context) {
    const lists = ['temperatures', 'observations', 'weights', 'substrate_changes', 'container_changes'];
    final out = Map<String, Object?>.of(context);
    for (final keep in [12, 8, 5, 3, 1]) {
      if (jsonEncode(out).length <= maxContextChars) break;
      for (final k in lists) {
        final l = out[k];
        if (l is List && l.length > keep) out[k] = l.sublist(l.length - keep);
      }
    }
    return out;
  }
}
