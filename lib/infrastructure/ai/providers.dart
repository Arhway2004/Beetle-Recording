import '../../data/database/app_database.dart';
import '../../domain/ai/ai_provider.dart';
import '../../domain/models/enums.dart';
import 'gateway_client.dart';
import 'model_store.dart';
import 'network_policy.dart';
import 'on_device_runtime.dart';

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
/// download the model and switch the provider on. Tool calling with a 1.7B
/// model is less reliable than the Mac's 8B model, so the status is marked
/// experimental and the UI says so. Proactive interpretation is not offered.
class MobileLlamaProvider implements AiProvider {
  MobileLlamaProvider({
    required this.settings,
    required this.store,
    required this.runtime,
    OnDeviceModelSpec? model,
  }) : model = model ?? defaultOnDeviceModel;

  final AiProviderSettingRow settings;
  final ModelStore store;
  final OnDeviceRuntime runtime;
  final OnDeviceModelSpec model;

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
      capabilities: const {AiCapability.chat, AiCapability.toolCalling},
    );
  }

  @override
  Future<ChatResponse> chat(List<ChatMessage> messages, {List<ToolDefinition> tools = const []}) async {
    final s = await status();
    if (!s.available) throw AiProviderException('On-device AI unavailable', code: s.code);
    final response = await runtime.chat(store.modelFile(model).path, messages, tools);
    return ChatResponse(content: response.content, toolCalls: response.toolCalls, model: model.displayName);
  }

  @override
  Future<Object?> interpretProactive(Map<String, Object?> context) =>
      throw AiProviderException('Proactive interpretation is not supported on-device');
}
