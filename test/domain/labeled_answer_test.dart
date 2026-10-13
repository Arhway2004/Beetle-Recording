import 'package:beetle_keeper/domain/ai/labeled_answer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const parser = LabeledAnswerParser();

  test('splits labeled lines and keeps continuation lines', () {
    final s = parser.parse('''
<think>internal reasoning that must not be shown</think>
[VERIFIED] CCK-001 weighed 28.5 g on 2026-09-01 (w2)
[CALCULATED] Change since previous: +2.1 g (+8.0%)
[HYPOTHESIS] Growth may be slowing
because the last interval was longer.
【建议】 一周后复称
[UNKNOWN] Substrate condition was not recorded.
''');
    expect(s.map((e) => e.kind), [
      ClaimKind.verified,
      ClaimKind.calculated,
      ClaimKind.hypothesis,
      ClaimKind.recommendation,
      ClaimKind.unknown,
    ]);
    expect(s[2].text, contains('because the last interval'));
    expect(s.any((e) => e.text.contains('internal reasoning')), isFalse);
  });

  test('unlabeled text is unclassified, never verified', () {
    final s = parser.parse('The beetle is fine.\n[DHH-001] not a label');
    expect(s.single.kind, ClaimKind.unclassified);
    expect(s.single.text, contains('[DHH-001]'));
  });

  test('encode/decode round trip', () {
    final s = parser.parse('[OBSERVATION] yellowing noted');
    expect(parser.decode(parser.encode(s)).single.kind, ClaimKind.observation);
  });
}
