import 'package:beetle_keeper/domain/growth/growth_metrics.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  final fixture = contractFixture('growth/cases.json')! as Map<String, Object?>;
  final tolerance = (fixture['tolerance']! as num).toDouble();

  group('GrowthMetrics matches shared contract vectors', () {
    for (final c in (fixture['cases']! as List).cast<Map<String, Object?>>()) {
      test(c['name']! as String, () {
        final points = [
          for (final r in (c['records']! as List).cast<Map<String, Object?>>())
            WeightPoint(
              id: r['id']! as String,
              measuredAt: DateTime.parse(r['measured_at']! as String),
              grams: (r['weight_grams']! as num).toDouble(),
            ),
        ];
        final actual = GrowthMetrics.compute(points).toJson();
        final expected = c['expected']! as Map<String, Object?>;
        for (final e in expected.entries) {
          final a = actual[e.key];
          final x = e.value;
          if (x is num) {
            expect(a, isA<num>(), reason: e.key);
            expect((a! as num).toDouble(), closeTo(x.toDouble(), tolerance), reason: e.key);
          } else if (e.key == 'max_at' && x != null) {
            expect(DateTime.parse(a! as String), DateTime.parse(x as String), reason: e.key);
          } else {
            expect(a, x, reason: e.key);
          }
        }
      });
    }
  });

  test('window filter is inclusive and does not assume linear growth', () {
    final pts = [
      WeightPoint(id: 'a', measuredAt: DateTime.utc(2026, 1, 1), grams: 10),
      WeightPoint(id: 'b', measuredAt: DateTime.utc(2026, 2, 1), grams: 30),
      WeightPoint(id: 'c', measuredAt: DateTime.utc(2026, 3, 1), grams: 31),
    ];
    final m = GrowthMetrics.compute(pts, from: DateTime.utc(2026, 2, 1));
    expect(m.count, 2);
    expect(m.first!.id, 'b');
    expect(m.changeSincePrevious, closeTo(1, 1e-9));
  });
}
