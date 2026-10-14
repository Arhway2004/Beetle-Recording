import '../models/enums.dart';
import 'ai_provider.dart';
import 'ai_router.dart';
import 'answer_grounding.dart';
import 'breeding_tools.dart';
import 'labeled_answer.dart';

class AssistantAnswer {
  const AssistantAnswer({
    required this.rawText,
    required this.sections,
    required this.provider,
    required this.model,
    required this.evidence,
    required this.drafts,
    required this.toolCalls,
    required this.isFallback,
  });

  final String rawText;
  final List<AnswerSection> sections;
  final AiProviderKind provider;
  final String? model;
  final Set<EvidenceRef> evidence;
  final List<ReminderDraft> drafts;
  final List<String> toolCalls;
  final bool isFallback;
}

class NoAiProviderException implements Exception {
  NoAiProviderException(this.decision);
  final NoProviderAvailable decision;
}

class ToolLoopExceeded implements Exception {}

/// Runs the tool-calling loop on the device. The provider (e.g. the Mac
/// gateway) only sees tool *requests* and the results the app chooses to
/// return; it never has database access.
class AiOrchestrator {
  AiOrchestrator({
    required this.router,
    required this.tools,
    DateTime Function()? clock,
    this.maxToolRounds = 6,
  }) : _clock = clock ?? DateTime.now;

  final AiRouter router;
  final BreedingTools tools;
  final DateTime Function() _clock;
  final int maxToolRounds;
  static const _parser = LabeledAnswerParser();

  static const required = {AiCapability.chat, AiCapability.toolCalling};

  /// Sections presented as facts; their quantities must come from the records.
  static const _factual = {ClaimKind.verified, ClaimKind.calculated, ClaimKind.observation, ClaimKind.unclassified};

  String systemPrompt(String localeName) => '''
You are the breeding assistant of "Beetle Keeper", helping a keeper of rhinoceros beetles (e.g. Dynastes hercules hercules = DHH, Chalcosoma chiron kirbyi = CCK).
Current time (UTC): ${_clock().toUtc().toIso8601String()}.

Rules:
1. Always call tools to retrieve records before answering questions about specific beetles. Never invent measurements, dates, IDs or events. If data is missing, say so.
2. Never do arithmetic yourself. Use get_growth_metrics / compare_growth for all numbers.
3. Label EVERY statement on its own line with exactly one prefix:
   [VERIFIED] a value or event that appears in the retrieved records (cite record ids in parentheses)
   [CALCULATED] a number returned by a calculation tool
   [OBSERVATION] something the keeper recorded as an observation note
   [HYPOTHESIS] a possible explanation that is not confirmed
   [RECOMMENDATION] a cautious, non-invasive suggestion
   [UNKNOWN] information that is not available in the records
4. Do not treat hypotheses as facts. Do not claim certainty about prepupation, pupation or health problems. Correlation is not causation.
5. You cannot see photos. Do not describe images.
6. Suitable temperature, substrate and container sizes vary by species, stage and individual; do not state a single universal value. Prefer safe, minimally disturbing care.
7. To suggest a reminder, call propose_reminder_draft. It does not schedule anything; the keeper decides.
8. Answer in the keeper's language (${localeName.startsWith('zh') ? 'Simplified Chinese' : localeName.startsWith('th') ? 'Thai' : 'English'}). Keep the label prefixes in English brackets.
''';

  static final _codeLike = RegExp(r'[A-Za-z][A-Za-z0-9]{1,7}[\s_\-]?\d{1,6}');

  Future<List<({ToolCall call, ToolResult result})>> _prefetchNamedBeetles(String question) async {
    final out = <({ToolCall call, ToolResult result})>[];
    final seen = <String>{};
    for (final m in _codeLike.allMatches(question).take(3)) {
      final code = m.group(0)!;
      for (final tool in const ['get_beetle_profile', 'get_weight_history', 'get_growth_metrics']) {
        final call = ToolCall(id: 'prefetch_${out.length}', name: tool, arguments: {'beetle_id': code});
        final result = await tools.execute(call);
        if (result.json.contains('"error"')) break; // not a beetle in the records
        final key = '$tool:${result.json.hashCode}';
        if (seen.add(key)) out.add((call: call, result: result));
      }
    }
    return out;
  }

  static String _answerLanguageReminder(String localeName) => localeName.startsWith('zh')
      ? '（请只用简体中文回答，并保留英文方括号标签，例如 [VERIFIED]。只能使用上面查询到的记录数据。）'
      : localeName.startsWith('th')
          ? '(โปรดตอบเป็นภาษาไทยเท่านั้น และคงป้ายภาษาอังกฤษในวงเล็บเหลี่ยม เช่น [VERIFIED] ใช้เฉพาะข้อมูลจากบันทึกที่ค้นได้)'
          : '(Answer in English only, keep the bracket labels such as [VERIFIED], and use only the retrieved records.)';

  Future<AssistantAnswer> ask(
    String question, {
    List<ChatMessage> history = const [],
    String localeName = 'zh',
  }) async {
    final decision = await router.select(required);
    if (decision is NoProviderAvailable) throw NoAiProviderException(decision);
    final routed = decision as RoutedTo;

    final messages = <ChatMessage>[
      ChatMessage.system(systemPrompt(localeName)),
      ...history,
      // Small models follow the last instruction best: repeat the language there.
      ChatMessage.user('$question\n\n${_answerLanguageReminder(localeName)}'),
    ];
    final evidence = <EvidenceRef>{};
    final drafts = <ReminderDraft>[];
    final calls = <String>[];
    final toolResults = <String>[];

    // Retrieve before answering: records of every beetle named in the question
    // are fetched by the app itself, so a model that skips tool calls (common
    // for small on-device models) still answers from real data.
    final prefetch = await _prefetchNamedBeetles(question);
    if (prefetch.isNotEmpty) {
      messages.add(ChatMessage.assistant('', toolCalls: [for (final p in prefetch) p.call]));
      for (final p in prefetch) {
        calls.add(p.call.name);
        evidence.addAll(p.result.evidence);
        toolResults.add(p.result.json);
        messages.add(ChatMessage.tool(p.call.name, p.result.json));
      }
    }

    for (var round = 0; round <= maxToolRounds; round++) {
      final response = await routed.provider.chat(messages, tools: tools.definitions);
      if (response.toolCalls.isEmpty) {
        final grounding = AnswerGrounding(toolResults, question: question);
        return AssistantAnswer(
          rawText: response.content,
          sections: [
            for (final s in _parser.parse(response.content))
              _factual.contains(s.kind) ? s.withUnsupported(grounding.unsupported(s.text)) : s,
          ],
          provider: routed.status.kind,
          model: response.model ?? routed.status.model,
          evidence: evidence,
          drafts: drafts,
          toolCalls: calls,
          isFallback: routed.isFallback,
        );
      }
      if (round == maxToolRounds) break;
      messages.add(ChatMessage.assistant(response.content, toolCalls: response.toolCalls));
      for (final call in response.toolCalls) {
        calls.add(call.name);
        final result = await tools.execute(call);
        toolResults.add(result.json);
        evidence.addAll(result.evidence);
        if (result.draft != null) drafts.add(result.draft!);
        messages.add(ChatMessage.tool(call.name, result.json));
      }
    }
    throw ToolLoopExceeded();
  }
}
