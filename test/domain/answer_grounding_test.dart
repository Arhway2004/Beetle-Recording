import 'package:beetle_keeper/core/utils/ids.dart';
import 'package:beetle_keeper/domain/ai/answer_grounding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loose beetle codes', () {
    expect(parseLooseBeetleCode('dhh-01'), (prefix: 'DHH', number: 1));
    expect(parseLooseBeetleCode(' DHH 12 '), (prefix: 'DHH', number: 12));
    expect(parseLooseBeetleCode('dhh1'), (prefix: 'DHH', number: 1));
    expect(parseLooseBeetleCode('A1B-0003'), (prefix: 'A1B', number: 3));
    expect(parseLooseBeetleCode('hello'), isNull);
  });

  test('quantities must match a recorded value at the stated precision', () {
    final g = AnswerGrounding(['{"records":[{"weight_grams":0.183,"measured_at":"2026-09-30T00:00:00Z"}],'
        '"metrics":{"percent_change_since_previous":-12.5}}']);
    expect(g.unsupported('最近 0.18 g'), isEmpty); // 0.183 rounded as stated
    expect(g.unsupported('最近 0.12 g'), ['0.12 g']);
    expect(g.unsupported('下降了 12.5%'), isEmpty); // sign-insensitive
    expect(g.unsupported('记录于 2026-09-30，10月14日'), isEmpty); // dates are not checked
    expect(g.unsupported('约 0.2克'), isEmpty); // 0.183 rounds to 0.2
    expect(g.unsupported('0.5克'), ['0.5克']);
  });
}
