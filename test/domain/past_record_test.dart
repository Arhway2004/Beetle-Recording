import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:beetle_keeper/domain/records/past_record.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 10, 14);

  test('reports each invalid row and ignores fully empty rows', () {
    final problems = validatePastRecords([
      PastRecordDraft(date: DateTime.utc(2026, 3, 1), grams: 12), // ok
      const PastRecordDraft(date: null), // empty → ignored
      const PastRecordDraft(date: null, grams: 5),
      PastRecordDraft(date: DateTime.utc(2027, 1, 1), stage: LifeStage.l3),
      PastRecordDraft(date: DateTime.utc(2026, 4, 1)),
      PastRecordDraft(date: DateTime.utc(2026, 4, 1), grams: 0),
    ], now);
    expect(problems, {
      2: PastRecordProblem.missingDate,
      3: PastRecordProblem.futureDate,
      4: PastRecordProblem.nothingToSave,
      5: PastRecordProblem.invalidWeight,
    });
  });

  test('savable rows are sorted oldest first', () {
    final rows = savablePastRecords([
      PastRecordDraft(date: DateTime.utc(2026, 5, 1), grams: 20),
      const PastRecordDraft(date: null),
      PastRecordDraft(date: DateTime.utc(2026, 1, 1), stage: LifeStage.l2),
    ]);
    expect(rows.map((r) => r.date!.month), [1, 5]);
  });
}
