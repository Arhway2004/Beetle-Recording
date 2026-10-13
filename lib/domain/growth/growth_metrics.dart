/// Deterministic growth calculations. The language model never computes these
/// numbers; it receives them from tools. Semantics are pinned by the shared test
/// vectors in `packages/api-contracts/fixtures/growth/cases.json`.
library;

class WeightPoint {
  const WeightPoint({required this.id, required this.measuredAt, required this.grams});

  final String id;
  final DateTime measuredAt;
  final double grams;
}

class GrowthMetrics {
  const GrowthMetrics({
    required this.count,
    required this.latest,
    required this.first,
    required this.previous,
    required this.max,
    required this.spanDays,
  });

  /// Computes metrics for the points within `[from, to]` (inclusive, optional).
  factory GrowthMetrics.compute(Iterable<WeightPoint> points, {DateTime? from, DateTime? to}) {
    final sorted = points
        .where((p) => from == null || !p.measuredAt.isBefore(from))
        .where((p) => to == null || !p.measuredAt.isAfter(to))
        .toList()
      ..sort((a, b) {
        final c = a.measuredAt.compareTo(b.measuredAt);
        return c != 0 ? c : a.id.compareTo(b.id);
      });
    if (sorted.isEmpty) {
      return const GrowthMetrics(
          count: 0, latest: null, first: null, previous: null, max: null, spanDays: null);
    }
    var max = sorted.first;
    for (final p in sorted.skip(1)) {
      if (p.grams > max.grams) max = p; // strict: earliest wins ties
    }
    final span = sorted.last.measuredAt.difference(sorted.first.measuredAt);
    return GrowthMetrics(
      count: sorted.length,
      latest: sorted.last,
      first: sorted.first,
      previous: sorted.length >= 2 ? sorted[sorted.length - 2] : null,
      max: max,
      spanDays: span.inMicroseconds / Duration.microsecondsPerDay,
    );
  }

  final int count;
  final WeightPoint? latest;
  final WeightPoint? first;
  final WeightPoint? previous;
  final WeightPoint? max;
  final double? spanDays;

  double? get changeSincePrevious =>
      (latest != null && previous != null) ? latest!.grams - previous!.grams : null;

  double? get percentChangeSincePrevious {
    final change = changeSincePrevious;
    if (change == null || previous!.grams == 0) return null;
    return change / previous!.grams * 100;
  }

  double? get totalChange => count >= 2 ? latest!.grams - first!.grams : null;

  /// Average change per day between the first and last record. Null when the
  /// span is shorter than one day, because short-span rates are misleading.
  double? get avgDailyChange {
    final total = totalChange;
    if (total == null || spanDays == null || spanDays! < 1) return null;
    return total / spanDays!;
  }

  double? get avgWeeklyChange => avgDailyChange == null ? null : avgDailyChange! * 7;

  bool get isLosingWeight => (changeSincePrevious ?? 0) < 0;

  /// JSON form used by AI tools and matched against the shared fixtures.
  Map<String, Object?> toJson() => {
        'count': count,
        'latest_grams': latest?.grams,
        'latest_at': latest?.measuredAt.toUtc().toIso8601String(),
        'first_grams': first?.grams,
        'previous_grams': previous?.grams,
        'change_since_previous_grams': changeSincePrevious,
        'percent_change_since_previous': percentChangeSincePrevious,
        'total_change_grams': totalChange,
        'span_days': spanDays,
        'avg_daily_change_grams': avgDailyChange,
        'avg_weekly_change_grams': avgWeeklyChange,
        'max_grams': max?.grams,
        'max_at': max?.measuredAt.toUtc().toIso8601String(),
        'is_losing_weight': isLosingWeight,
        'record_ids': [if (first != null) first!.id, if (latest != null) latest!.id],
      };
}
