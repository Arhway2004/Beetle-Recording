import 'dart:convert';

/// Epistemic category of a statement in an AI answer.
enum ClaimKind { verified, calculated, observation, hypothesis, recommendation, unknown, unclassified }

class AnswerSection {
  const AnswerSection(this.kind, this.text);
  final ClaimKind kind;
  final String text;

  Map<String, String> toJson() => {'kind': kind.name, 'text': text};

  static AnswerSection fromJson(Map<String, Object?> json) => AnswerSection(
        ClaimKind.values.firstWhere((k) => k.name == json['kind'],
            orElse: () => ClaimKind.unclassified),
        json['text'] as String? ?? '',
      );
}

/// Parses model output whose lines are prefixed with labels such as
/// `[VERIFIED]` / `[已记录]`. Lines without a label continue the previous
/// section; leading unlabeled text is `unclassified` — it is never upgraded to
/// a verified fact. Qwen3 `<think>` blocks are removed.
class LabeledAnswerParser {
  const LabeledAnswerParser();

  static const _labels = <String, ClaimKind>{
    'VERIFIED': ClaimKind.verified,
    '已记录': ClaimKind.verified,
    '记录': ClaimKind.verified,
    'CALCULATED': ClaimKind.calculated,
    '计算': ClaimKind.calculated,
    'OBSERVATION': ClaimKind.observation,
    '观察': ClaimKind.observation,
    'HYPOTHESIS': ClaimKind.hypothesis,
    '推测': ClaimKind.hypothesis,
    '假设': ClaimKind.hypothesis,
    'RECOMMENDATION': ClaimKind.recommendation,
    '建议': ClaimKind.recommendation,
    'UNKNOWN': ClaimKind.unknown,
    '未知': ClaimKind.unknown,
  };

  static final _labelPattern = RegExp(r'^\s*(?:[-*]\s*)?[\[【]\s*([^\]】]+?)\s*[\]】]\s*[:：]?\s*');
  static final _think = RegExp(r'<think>[\s\S]*?</think>', caseSensitive: false);

  List<AnswerSection> parse(String raw) {
    final text = raw.replaceAll(_think, '').trim();
    final sections = <({ClaimKind kind, StringBuffer buf})>[];
    for (final line in const LineSplitter().convert(text)) {
      final m = _labelPattern.firstMatch(line);
      final kind = m == null ? null : _labels[m.group(1)!.toUpperCase()];
      if (kind != null) {
        sections.add((kind: kind, buf: StringBuffer(line.substring(m!.end))));
      } else if (sections.isEmpty) {
        if (line.trim().isEmpty) continue;
        sections.add((kind: ClaimKind.unclassified, buf: StringBuffer(line)));
      } else {
        sections.last.buf
          ..write('\n')
          ..write(line);
      }
    }
    return [
      for (final s in sections)
        if (s.buf.toString().trim().isNotEmpty) AnswerSection(s.kind, s.buf.toString().trim()),
    ];
  }

  String encode(List<AnswerSection> sections) =>
      jsonEncode(sections.map((s) => s.toJson()).toList());

  List<AnswerSection> decode(String? json) {
    if (json == null) return const [];
    final list = jsonDecode(json) as List<Object?>;
    return list.map((e) => AnswerSection.fromJson((e as Map).cast<String, Object?>())).toList();
  }
}
