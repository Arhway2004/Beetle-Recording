import 'dart:convert';

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
    this.subjects = const [],
  });

  final String rawText;
  final List<AnswerSection> sections;
  final AiProviderKind provider;
  final String? model;
  final Set<EvidenceRef> evidence;
  final List<ReminderDraft> drafts;
  final List<String> toolCalls;
  final bool isFallback;

  /// Stored codes of the beetles whose records were retrieved for this
  /// answer; the UI shows a record card for each.
  final List<String> subjects;
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

  /// The system prompt in the keeper's language: small models answer in the
  /// language of their instructions far more reliably than in the language
  /// they are told to use. Label tokens stay English in every language.
  String systemPrompt(String localeName) {
    final now = _clock().toUtc().toIso8601String();
    if (localeName.startsWith('zh')) return _promptZh(now);
    if (localeName.startsWith('th')) return _promptTh(now);
    return _promptEn(now);
  }

  static String _promptEn(String now) => '''
You are the breeding assistant of "Beetle Keeper", helping a keeper of rhinoceros beetles (e.g. Dynastes hercules hercules = DHH, Chalcosoma chiron kirbyi = CCK).
Current time (UTC): $now.

Rules:
1. Retrieve records with the tools before answering about a specific beetle. Never invent measurements, dates, IDs or events. If data is missing, say so.
2. Never do arithmetic yourself. Use get_growth_metrics / compare_growth for all numbers.
3. Put each statement on its own line starting with exactly one label:
   [VERIFIED] a value or event from the retrieved records
   [CALCULATED] a number returned by a calculation tool
   [OBSERVATION] something the keeper recorded as an observation note
   [HYPOTHESIS] a possible explanation that is not confirmed
   [RECOMMENDATION] a cautious, non-invasive suggestion
   [UNKNOWN] information that is not available in the records
4. Do not treat hypotheses as facts. Do not claim certainty about prepupation, pupation or health problems. Correlation is not causation.
5. You cannot see photos. Do not describe images.
6. Suitable temperature, substrate and container sizes vary by species, stage and individual; do not state a single universal value. Prefer safe, minimally disturbing care.
7. To suggest a reminder, call propose_reminder_draft. It does not schedule anything; the keeper decides.
8. Answer in English. Keep the label prefixes in English brackets.
9. The keeper already sees a record card for the beetle. Never copy field names, JSON, record IDs or ISO timestamps. Write short plain sentences, at most 5 lines, with dates like "14 Oct".
10. When asked to predict: with fewer than 3 weighings, say there is not enough data yet and which records would help. Never make up a predicted value.
''';

  static String _promptZh(String now) => '''
你是「甲虫饲养助手」的饲养顾问，帮助饲养者照顾独角仙类甲虫（例如 DHH = 长戟大兜虫 Dynastes hercules hercules，CCK = 南洋大兜虫 Chalcosoma chiron kirbyi）。
当前时间（UTC）：$now。

规则：
1. 回答具体个体的问题前，先用工具查询记录。绝不编造体重、日期、编号或事件；没有数据就直接说没有。
2. 不要自己计算。所有数字都来自 get_growth_metrics / compare_growth 的结果。
3. 每句话单独一行，并且只用一个英文标签开头：
   [VERIFIED] 记录中的数值或事件
   [CALCULATED] 计算工具返回的数字
   [OBSERVATION] 饲养者记下的观察
   [HYPOTHESIS] 尚未证实的可能解释
   [RECOMMENDATION] 谨慎、尽量不打扰的建议
   [UNKNOWN] 记录中没有的信息
4. 不要把推测当成事实。不要断言预蛹、化蛹或健康问题。相关不等于因果。
5. 你看不到照片，不要描述图片。
6. 适宜的温度、基质和容器大小因物种、阶段和个体而异，不要给出唯一的标准值；优先选择安全、少打扰的做法。
7. 想建议提醒时调用 propose_reminder_draft；它不会自动安排，由饲养者决定。
8. 必须用简体中文回答。标签保持英文方括号，例如 [VERIFIED]。
9. 饲养者已经能看到这只甲虫的记录卡片。不要照抄字段名、JSON、记录编号或 ISO 时间；用简短易懂的中文，最多 5 行，日期写成「10月14日」。
10. 被要求预测时：如果称重少于 3 次，就说明数据还不够，并说明需要补充哪些记录；绝不编造预测数值。
''';

  static String _promptTh(String now) => '''
คุณคือผู้ช่วยการเลี้ยงของแอป "Beetle Keeper" ช่วยผู้เลี้ยงด้วงแรด (เช่น DHH = Dynastes hercules hercules, CCK = Chalcosoma chiron kirbyi)
เวลาปัจจุบัน (UTC): $now

กฎ:
1. ก่อนตอบเรื่องด้วงตัวใด ให้ค้นบันทึกด้วยเครื่องมือก่อน ห้ามแต่งน้ำหนัก วันที่ รหัส หรือเหตุการณ์ ถ้าไม่มีข้อมูลให้บอกตรงๆ
2. ห้ามคำนวณเอง ตัวเลขทั้งหมดต้องมาจาก get_growth_metrics / compare_growth
3. เขียนแต่ละประโยคแยกบรรทัด และขึ้นต้นด้วยป้ายภาษาอังกฤษเพียงหนึ่งป้าย:
   [VERIFIED] ค่าหรือเหตุการณ์จากบันทึก
   [CALCULATED] ตัวเลขจากเครื่องมือคำนวณ
   [OBSERVATION] สิ่งที่ผู้เลี้ยงจดไว้
   [HYPOTHESIS] คำอธิบายที่เป็นไปได้แต่ยังไม่ยืนยัน
   [RECOMMENDATION] คำแนะนำที่ระมัดระวังและรบกวนน้อย
   [UNKNOWN] ข้อมูลที่ไม่มีในบันทึก
4. อย่าถือว่าการคาดเดาเป็นข้อเท็จจริง อย่ายืนยันเรื่องเข้าดักแด้หรือปัญหาสุขภาพ ความสัมพันธ์ไม่ใช่เหตุและผล
5. คุณมองไม่เห็นรูปภาพ
6. อุณหภูมิ วัสดุรองพื้น และขนาดภาชนะที่เหมาะสมขึ้นกับชนิด ระยะ และตัวด้วง อย่าให้ค่ามาตรฐานค่าเดียว
7. ถ้าจะแนะนำการเตือน ให้เรียก propose_reminder_draft ซึ่งไม่ตั้งเวลาให้เอง ผู้เลี้ยงเป็นผู้ตัดสินใจ
8. ต้องตอบเป็นภาษาไทย และคงป้ายภาษาอังกฤษในวงเล็บเหลี่ยม เช่น [VERIFIED]
9. ผู้เลี้ยงเห็นการ์ดบันทึกของด้วงอยู่แล้ว ห้ามคัดลอกชื่อฟิลด์ JSON รหัสบันทึก หรือเวลาแบบ ISO เขียนประโยคสั้นๆ ที่เข้าใจง่าย ไม่เกิน 5 บรรทัด
10. เมื่อถูกขอให้คาดการณ์: ถ้าชั่งน้ำหนักน้อยกว่า 3 ครั้ง ให้บอกว่าข้อมูลยังไม่พอและควรบันทึกอะไรเพิ่ม ห้ามแต่งค่าคาดการณ์
''';

  static final _codeLike = RegExp(r'[A-Za-z][A-Za-z0-9]{1,7}[\s_\-]?\d{1,6}');

  /// Beetles named in [question], or — for a follow-up like "and its next
  /// weight?" — in the most recent earlier user message that named one.
  static List<String> namedBeetles(String question, List<ChatMessage> history) {
    List<String> codes(String text) => [for (final m in _codeLike.allMatches(text).take(3)) m.group(0)!];
    final direct = codes(question);
    if (direct.isNotEmpty) return direct;
    for (final m in history.reversed) {
      if (m.role != ChatRole.user) continue;
      final found = codes(m.content);
      if (found.isNotEmpty) return found;
    }
    return const [];
  }

  Future<List<({ToolCall call, ToolResult result})>> _prefetchNamedBeetles(
      String question, List<ChatMessage> history) async {
    final out = <({ToolCall call, ToolResult result})>[];
    final seen = <String>{};
    for (final code in namedBeetles(question, history)) {
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
    final prefetch = await _prefetchNamedBeetles(question, history);
    final subjects = <String>{
      for (final p in prefetch)
        if (p.call.name == 'get_beetle_profile')
          if (jsonDecode(p.result.json) case {'beetle': {'beetle_id': final String code}}) code,
    }.toList();
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
          subjects: subjects,
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
