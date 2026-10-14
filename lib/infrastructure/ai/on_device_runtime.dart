import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:llamadart/llamadart.dart' as llama;

import '../../domain/ai/ai_provider.dart';
import 'llama_mapping.dart';

/// Runs chat turns on a local GGUF model. The model stays loaded between
/// turns (loading takes seconds) and is released by [unload], which the app
/// calls when it goes to the background so iOS does not kill it for memory.
abstract class OnDeviceRuntime {
  Future<ChatResponse> chat(String modelPath, List<ChatMessage> messages, List<ToolDefinition> tools);

  /// One completion constrained to JSON matching [schema]; returns the raw text.
  Future<String> completeJson(String modelPath, List<ChatMessage> messages, Map<String, Object?> schema);

  Future<void> unload();
}

class LlamaDartRuntime implements OnDeviceRuntime {
  /// Load attempts, best first. 6k tokens fit the system prompt, tool schemas
  /// and a few tool results with a ~0.7 GB KV cache next to the 1.1 GB model;
  /// smaller contexts and finally CPU-only are fallbacks for phones where
  /// iOS's per-app memory limit or Metal allocation rejects the larger setup.
  static const loadAttempts = [
    llama.ModelParams(contextSize: 6144),
    llama.ModelParams(contextSize: 4096),
    llama.ModelParams(contextSize: 2048),
    llama.ModelParams(contextSize: 2048, gpuLayers: 0),
  ];

  llama.LlamaEngine? _engine;
  String? _loadedPath;
  Future<void> _queue = Future.value();

  /// Turns run one at a time; the engine is not re-entrant.
  Future<T> _serialized<T>(Future<T> Function() body) {
    final result = _queue.then((_) => body());
    _queue = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  Future<llama.LlamaEngine> _engineFor(String path) async {
    if (_engine != null && _loadedPath == path) return _engine!;
    await _dropEngine();
    llama.LlamaException? lastError;
    for (final params in loadAttempts) {
      try {
        _engine = await llama.LlamaEngine.load(llama.LlamaModel(llama.ModelSource.path(path)), params: params);
        _loadedPath = path;
        debugPrint('on-device model loaded: context ${params.contextSize}, gpuLayers ${params.gpuLayers}');
        return _engine!;
      } on llama.LlamaModelException catch (e) {
        lastError = e;
        debugPrint('on-device model load failed (context ${params.contextSize}, gpuLayers ${params.gpuLayers}): '
            '${describe(e)}');
      }
    }
    throw lastError!;
  }

  /// Message plus the native detail llamadart keeps in [llama.LlamaException.details].
  static String describe(llama.LlamaException e) =>
      e.details == null ? e.message : '${e.message} (${e.details})';

  @override
  Future<ChatResponse> chat(String modelPath, List<ChatMessage> messages, List<ToolDefinition> tools) =>
      _serialized(() async {
        try {
          final engine = await _engineFor(modelPath);
          final collector = CompletionCollector();
          await for (final chunk in engine.create(
            toLlamaMessages(messages),
            tools: tools.isEmpty ? null : toLlamaTools(tools),
            // Qwen3 thinking mode is slow on a phone; the answer format is
            // enforced by the system prompt instead.
            enableThinking: false,
            params: const llama.GenerationParams(maxTokens: 1024, temp: 0.7, topP: 0.8, topK: 20, penalty: 1.05),
          )) {
            collector.add(chunk);
          }
          return collector.finish();
        } on llama.LlamaModelException catch (e) {
          await _dropEngine();
          throw AiProviderException('On-device model failed to load: ${describe(e)}', code: UnavailableCode.modelMissing);
        } on llama.LlamaException catch (e) {
          throw AiProviderException('On-device inference failed: ${describe(e)}');
        }
      });

  @override
  Future<String> completeJson(String modelPath, List<ChatMessage> messages, Map<String, Object?> schema) =>
      _serialized(() async {
        try {
          final engine = await _engineFor(modelPath);
          Future<String> run(Map<String, dynamic> format) async {
            final out = StringBuffer();
            await for (final chunk in engine.create(
              toLlamaMessages(messages),
              responseFormat: format,
              enableThinking: false,
              params: const llama.GenerationParams(maxTokens: 1500, temp: 0.3, topP: 0.8, topK: 20),
            )) {
              out.write(chunk.text);
            }
            return out.toString();
          }

          try {
            return await run({
              'type': 'json_schema',
              'json_schema': {'schema': schema},
            });
          } on StateError {
            // The schema uses a feature outside the grammar converter's subset:
            // fall back to "any JSON object"; the app validates the result.
            return await run(const {'type': 'json_object'});
          } on llama.LlamaUnsupportedException {
            return await run(const {'type': 'json_object'});
          }
        } on llama.LlamaModelException catch (e) {
          await _dropEngine();
          throw AiProviderException('On-device model failed to load: ${describe(e)}', code: UnavailableCode.modelMissing);
        } on llama.LlamaException catch (e) {
          throw AiProviderException('On-device inference failed: ${describe(e)}');
        }
      });

  Future<void> _dropEngine() async {
    final e = _engine;
    _engine = null;
    _loadedPath = null;
    await e?.dispose();
  }

  @override
  Future<void> unload() => _serialized(_dropEngine);
}
