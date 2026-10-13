import '../models/enums.dart';

enum AiCapability { chat, toolCalling, proactiveInterpretation, vision }

enum ChatRole { system, user, assistant, tool }

class ToolCall {
  const ToolCall({required this.id, required this.name, required this.arguments});
  final String id;
  final String name;
  final Map<String, Object?> arguments;

  Map<String, Object?> toJson() => {'id': id, 'name': name, 'arguments': arguments};

  factory ToolCall.fromJson(Map<String, Object?> json) => ToolCall(
        id: json['id'] as String? ?? '',
        name: json['name'] as String,
        arguments: (json['arguments'] as Map?)?.cast<String, Object?>() ?? const {},
      );
}

class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.content,
    this.toolCalls = const [],
    this.toolName,
  });

  const ChatMessage.system(String content) : this(role: ChatRole.system, content: content);
  const ChatMessage.user(String content) : this(role: ChatRole.user, content: content);
  const ChatMessage.assistant(String content, {List<ToolCall> toolCalls = const []})
      : this(role: ChatRole.assistant, content: content, toolCalls: toolCalls);
  const ChatMessage.tool(String name, String content)
      : this(role: ChatRole.tool, content: content, toolName: name);

  final ChatRole role;
  final String content;
  final List<ToolCall> toolCalls;
  final String? toolName;

  Map<String, Object?> toJson() => {
        'role': role.name,
        'content': content,
        if (toolCalls.isNotEmpty) 'tool_calls': toolCalls.map((t) => t.toJson()).toList(),
        if (toolName != null) 'tool_name': toolName,
      };
}

class ToolDefinition {
  const ToolDefinition({required this.name, required this.description, required this.parameters});
  final String name;
  final String description;

  /// JSON Schema for the arguments object.
  final Map<String, Object?> parameters;

  Map<String, Object?> toJson() => {
        'type': 'function',
        'function': {'name': name, 'description': description, 'parameters': parameters},
      };
}

class ChatResponse {
  const ChatResponse({required this.content, this.toolCalls = const [], this.model});
  final String content;
  final List<ToolCall> toolCalls;
  final String? model;
}

/// Why a provider cannot be used right now. Mapped to localized text in the UI.
enum UnavailableCode {
  disabled,
  notConfigured,
  consentRequired,
  unreachable,
  unauthorized,
  insecureTransport,
  modelMissing,
  notBundled,
}

class ProviderStatus {
  const ProviderStatus({
    required this.kind,
    required this.available,
    required this.capabilities,
    this.model,
    this.code,
    this.detail,
    this.experimental = false,
  });

  const ProviderStatus.unavailable(this.kind, UnavailableCode this.code, {this.detail})
      : available = false,
        capabilities = const {},
        model = null,
        experimental = false;

  final AiProviderKind kind;
  final bool available;
  final Set<AiCapability> capabilities;
  final String? model;
  final UnavailableCode? code;

  /// Technical detail for diagnostics (not localized).
  final String? detail;
  final bool experimental;

  bool supports(Set<AiCapability> required) => available && capabilities.containsAll(required);
}

/// A language-model provider. Implementations must never execute record
/// mutations; tools are run by the app (see `AiOrchestrator`).
abstract class AiProvider {
  AiProviderKind get kind;

  Future<ProviderStatus> status();

  Future<ChatResponse> chat(List<ChatMessage> messages, {List<ToolDefinition> tools = const []});

  /// Returns the raw (unvalidated) JSON batch `{"schema_version":"1","suggestions":[...]}`.
  Future<Object?> interpretProactive(Map<String, Object?> context);
}

class AiProviderException implements Exception {
  AiProviderException(this.message, {this.retryable = false, this.code});
  final String message;
  final bool retryable;
  final UnavailableCode? code;

  @override
  String toString() => message;
}
