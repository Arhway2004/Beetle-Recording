/// Groups the keeper's confirmed care tasks for the dashboard.
///
/// * overdue: due before now
/// * today:   due from now until the end of the local day
/// * soon:    due within the next [soonDays] days after today
/// Anything later is left to the Reminders screen. Each group is soonest first.
class CareAgenda<T> {
  const CareAgenda({required this.overdue, required this.today, required this.soon});

  final List<T> overdue;
  final List<T> today;
  final List<T> soon;

  bool get isClear => overdue.isEmpty && today.isEmpty;

  static CareAgenda<T> of<T>(
    Iterable<T> tasks,
    DateTime Function(T) dueAt, {
    required DateTime now,
    int soonDays = 7,
  }) {
    final local = now.toLocal();
    final endOfToday = DateTime(local.year, local.month, local.day + 1);
    final endOfSoon = DateTime(local.year, local.month, local.day + 1 + soonDays);
    final sorted = [...tasks]..sort((a, b) => dueAt(a).compareTo(dueAt(b)));
    return CareAgenda(
      overdue: [for (final t in sorted) if (dueAt(t).isBefore(now)) t],
      today: [
        for (final t in sorted)
          if (!dueAt(t).isBefore(now) && dueAt(t).toLocal().isBefore(endOfToday)) t,
      ],
      soon: [
        for (final t in sorted)
          if (!dueAt(t).toLocal().isBefore(endOfToday) && dueAt(t).toLocal().isBefore(endOfSoon)) t,
      ],
    );
  }
}
