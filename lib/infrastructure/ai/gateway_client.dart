import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../domain/ai/ai_provider.dart';
import 'network_policy.dart';

class GatewayConfig {
  const GatewayConfig({
    required this.baseUrl,
    required this.token,
    required this.timeout,
    this.model,
    this.certSha256,
  });

  final Uri baseUrl;
  final String token;
  final Duration timeout;
  final String? model;

  /// Lower-case hex SHA-256 of the DER certificate. When set, a certificate
  /// that fails normal validation (self-signed) is accepted only if it matches.
  final String? certSha256;
}

class GatewayHealth {
  const GatewayHealth({required this.ok, required this.ollamaReachable, required this.models});
  final bool ok;
  final bool ollamaReachable;
  final List<String> models;
}

String certificateFingerprint(X509Certificate cert) => sha256.convert(cert.der).toString();

/// Normalizes user input like `AA:BB:..` to lower-case hex without separators.
String? normalizeFingerprint(String? input) {
  if (input == null) return null;
  final hex = input.replaceAll(RegExp(r'[^0-9a-fA-F]'), '').toLowerCase();
  return hex.length == 64 ? hex : null;
}

/// HTTP client for `services/ai-gateway` (`/api/v1`). See
/// `packages/api-contracts/openapi/ai-gateway.v1.yaml`.
class GatewayClient {
  GatewayClient(this.config, {http.Client? httpClient})
      : _http = httpClient ?? _buildClient(config);

  final GatewayConfig config;
  final http.Client _http;

  static http.Client _buildClient(GatewayConfig config) {
    final io = HttpClient()
      ..connectionTimeout = const Duration(seconds: 8)
      ..idleTimeout = const Duration(seconds: 15);
    final pin = normalizeFingerprint(config.certSha256);
    io.badCertificateCallback = (cert, host, port) =>
        pin != null && host == config.baseUrl.host && certificateFingerprint(cert) == pin;
    return IOClient(io);
  }

  Uri _u(String path) => config.baseUrl.replace(
      path: '${config.baseUrl.path.replaceAll(RegExp(r'/$'), '')}/api/v1/$path');

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${config.token}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  void _checkTransport() {
    if (!isTransportAllowed(config.baseUrl)) {
      throw AiProviderException('HTTPS is required for the Mac gateway',
          code: UnavailableCode.insecureTransport);
    }
  }

  Future<GatewayHealth> health() async {
    _checkTransport();
    final res = await _send(() => _http
        .get(_u('health'), headers: _headers)
        .timeout(const Duration(seconds: 6)));
    final body = _decode(res);
    return GatewayHealth(
      ok: body['status'] == 'ok',
      ollamaReachable: body['ollama_reachable'] == true,
      models: ((body['models'] as List?) ?? const []).map((e) => '$e').toList(),
    );
  }

  Future<ChatResponse> chat(List<ChatMessage> messages, List<ToolDefinition> tools) async {
    _checkTransport();
    final res = await _send(() => _http
        .post(_u('chat'),
            headers: _headers,
            body: jsonEncode({
              if (config.model != null) 'model': config.model,
              'messages': messages.map((m) => m.toJson()).toList(),
              'tools': tools.map((t) => t.toJson()).toList(),
            }))
        .timeout(config.timeout));
    final body = _decode(res);
    final message = (body['message'] as Map).cast<String, Object?>();
    return ChatResponse(
      content: message['content'] as String? ?? '',
      model: body['model'] as String?,
      toolCalls: ((message['tool_calls'] as List?) ?? const [])
          .map((t) => ToolCall.fromJson((t as Map).cast<String, Object?>()))
          .toList(),
    );
  }

  Future<Object?> interpretProactive(Map<String, Object?> context) async {
    _checkTransport();
    final res = await _send(() => _http
        .post(_u('proactive/interpret'),
            headers: _headers,
            body: jsonEncode({if (config.model != null) 'model': config.model, 'context': context}))
        .timeout(config.timeout));
    return _decode(res);
  }

  Future<http.Response> _send(Future<http.Response> Function() request) async {
    try {
      return await request();
    } on TimeoutException {
      throw AiProviderException('Gateway request timed out',
          retryable: true, code: UnavailableCode.unreachable);
    } on HandshakeException catch (e) {
      throw AiProviderException('TLS handshake failed (certificate not trusted or not pinned): $e',
          code: UnavailableCode.insecureTransport);
    } on SocketException catch (e) {
      throw AiProviderException('Gateway unreachable: ${e.message}',
          retryable: true, code: UnavailableCode.unreachable);
    } on http.ClientException catch (e) {
      throw AiProviderException('Gateway connection error: ${e.message}',
          retryable: true, code: UnavailableCode.unreachable);
    }
  }

  Map<String, Object?> _decode(http.Response res) {
    if (res.statusCode == 401 || res.statusCode == 403) {
      throw AiProviderException('Gateway rejected the access token',
          code: UnavailableCode.unauthorized);
    }
    if (res.statusCode == 503) {
      throw AiProviderException('Gateway is up but Ollama/model is unavailable',
          retryable: true, code: UnavailableCode.modelMissing);
    }
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw AiProviderException('Gateway error ${res.statusCode}: ${_short(res.body)}');
    }
    final decoded = jsonDecode(utf8.decode(res.bodyBytes));
    if (decoded is! Map) throw AiProviderException('Gateway returned a non-object response');
    return decoded.cast<String, Object?>();
  }

  static String _short(String s) => s.length > 300 ? '${s.substring(0, 300)}…' : s;

  void close() => _http.close();
}
