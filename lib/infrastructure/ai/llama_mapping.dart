import 'dart:convert';

import 'package:llamadart/llamadart.dart' as llama;

import '../../domain/ai/ai_provider.dart';

/// Conversions between the app's provider-neutral AI types and llamadart.
/// Pure functions, so they are unit-tested without the native runtime.

List<llama.LlamaChatMessage> toLlamaMessages(List<ChatMessage> messages) => [
      for (final m in messages)
        switch (m.role) {
          ChatRole.system => llama.LlamaChatMessage.fromText(role: llama.LlamaChatRole.system, text: m.content),
          ChatRole.user => llama.LlamaChatMessage.fromText(role: llama.LlamaChatRole.user, text: m.content),
          ChatRole.assistant when m.toolCalls.isEmpty =>
            llama.LlamaChatMessage.fromText(role: llama.LlamaChatRole.assistant, text: m.content),
          ChatRole.assistant => llama.LlamaChatMessage.withContent(role: llama.LlamaChatRole.assistant, content: [
              if (m.content.isNotEmpty) llama.LlamaTextContent(m.content),
              for (final c in m.toolCalls)
                llama.LlamaToolCallContent(
                  id: c.id.isEmpty ? null : c.id,
                  name: c.name,
                  arguments: Map<String, dynamic>.from(c.arguments),
                  rawJson: jsonEncode(c.arguments),
                ),
            ]),
          ChatRole.tool => llama.LlamaChatMessage.withContent(
              role: llama.LlamaChatRole.tool,
              content: [llama.LlamaToolResultContent(name: m.toolName ?? 'tool', result: m.content)],
            ),
        },
    ];

List<llama.ToolDefinition> toLlamaTools(List<ToolDefinition> tools) => [
      for (final t in tools)
        llama.ToolDefinition(name: t.name, description: t.description, parameters: paramsFromSchema(t.parameters)),
    ];

/// Converts a JSON Schema `object` into llamadart parameters. Covers the
/// subset the breeding tools use: string/integer/number/boolean, enums,
/// arrays and nested objects, with nullable `["x", "null"]` types.
List<llama.ToolParam> paramsFromSchema(Map<String, Object?> schema) {
  final props = (schema['properties'] as Map?)?.cast<String, Object?>() ?? const {};
  final required = ((schema['required'] as List?) ?? const []).cast<String>().toSet();
  return [
    for (final e in props.entries)
      _param(e.key, (e.value as Map).cast<String, Object?>(), required: required.contains(e.key)),
  ];
}

llama.ToolParam _param(String name, Map<String, Object?> s, {required bool required}) {
  final description = s['description'] as String?;
  final enumValues = s['enum'] as List?;
  if (enumValues != null) {
    return llama.ToolParam.enumType(name,
        values: [for (final v in enumValues) '$v'], description: description, required: required);
  }
  final rawType = s['type'];
  final type = rawType is List ? rawType.whereType<String>().firstWhere((t) => t != 'null', orElse: () => 'string') : rawType;
  return switch (type) {
    'integer' => llama.ToolParam.integer(name, description: description, required: required),
    'number' => llama.ToolParam.number(name, description: description, required: required),
    'boolean' => llama.ToolParam.boolean(name, description: description, required: required),
    'array' => llama.ToolParam.array(name,
        itemType: _param('item', ((s['items'] as Map?) ?? const {'type': 'string'}).cast<String, Object?>(),
            required: false),
        description: description,
        required: required),
    'object' => llama.ToolParam.object(name,
        properties: paramsFromSchema(s), description: description, required: required),
    _ => llama.ToolParam.string(name, description: description, required: required),
  };
}

/// Folds a streamed completion into one [ChatResponse]. Tool-call deltas are
/// merged by index; calls whose arguments are not a JSON object are dropped.
class CompletionCollector {
  final _text = StringBuffer();
  final _calls = <int, ({String? id, StringBuffer name, StringBuffer args})>{};
  String? _model;

  void add(llama.LlamaCompletionChunk chunk) {
    _model ??= chunk.model.isEmpty ? null : chunk.model;
    for (final choice in chunk.choices) {
      final delta = choice.delta;
      if (delta.content != null) _text.write(delta.content);
      for (final t in delta.toolCalls ?? const <llama.LlamaCompletionChunkToolCall>[]) {
        final acc = _calls[t.index] ??= (id: t.id, name: StringBuffer(), args: StringBuffer());
        if (acc.id == null && t.id != null) _calls[t.index] = (id: t.id, name: acc.name, args: acc.args);
        if (t.function?.name != null) acc.name.write(t.function!.name);
        if (t.function?.arguments != null) acc.args.write(t.function!.arguments);
      }
    }
  }

  ChatResponse finish() {
    final calls = <ToolCall>[];
    for (final (i, c) in _calls.values.indexed) {
      final name = c.name.toString().trim();
      if (name.isEmpty) continue;
      final raw = c.args.toString().trim();
      Object? args;
      try {
        args = raw.isEmpty ? <String, Object?>{} : jsonDecode(raw);
      } on FormatException {
        continue;
      }
      if (args is! Map) continue;
      calls.add(ToolCall(id: c.id ?? 'call_$i', name: name, arguments: args.cast<String, Object?>()));
    }
    return ChatResponse(content: _text.toString().trim(), toolCalls: calls, model: _model);
  }
}
