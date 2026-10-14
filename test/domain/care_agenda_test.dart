import 'package:beetle_keeper/domain/reminders/care_agenda.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Local times, so day boundaries are the keeper's own.
  final now = DateTime(2026, 10, 14, 15);
  CareAgenda<DateTime> agenda(List<DateTime> due) => CareAgenda.of(due, (d) => d, now: now);

  test('splits tasks into overdue, today and the next 7 days, soonest first', () {
    final a = agenda([
      DateTime(2026, 10, 30), // later than a week: not on the dashboard
      DateTime(2026, 10, 14, 20), // today, later
      DateTime(2026, 10, 13, 9), // yesterday → overdue
      DateTime(2026, 10, 14, 10), // earlier today → overdue
      DateTime(2026, 10, 16), // soon
      DateTime(2026, 10, 21, 23), // last day of the week window
    ]);
    expect(a.overdue, [DateTime(2026, 10, 13, 9), DateTime(2026, 10, 14, 10)]);
    expect(a.today, [DateTime(2026, 10, 14, 20)]);
    expect(a.soon, [DateTime(2026, 10, 16), DateTime(2026, 10, 21, 23)]);
    expect(a.isClear, isFalse);
  });

  test('nothing overdue or due today is "all clear" even with later tasks', () {
    expect(agenda([DateTime(2026, 10, 18)]).isClear, isTrue);
  });
}
