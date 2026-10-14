import '../models/enums.dart';

/// One row of history recorded before the keeper started using the app:
/// a weight, a stage, or both, observed on [date].
class PastRecordDraft {
  const PastRecordDraft({
    required this.date,
    this.grams,
    this.stage,
    this.l3Phase,
    this.dateIsApproximate = false,
    this.note,
  });

  final DateTime? date;
  final double? grams;
  final LifeStage? stage;
  final L3Phase? l3Phase;

  /// The keeper is not sure of the exact day. Stored on the stage event
  /// (`is_estimated`); weights have no such flag, so it goes into their note.
  final bool dateIsApproximate;
  final String? note;

  bool get isEmpty => grams == null && stage == null && (note == null || note!.trim().isEmpty);
}

enum PastRecordProblem { missingDate, futureDate, nothingToSave, invalidWeight }

/// Returns the problems per row index; an empty map means every row can be
/// saved. Fully empty rows are ignored rather than reported.
Map<int, PastRecordProblem> validatePastRecords(List<PastRecordDraft> rows, DateTime now) {
  final problems = <int, PastRecordProblem>{};
  for (final (i, r) in rows.indexed) {
    if (r.isEmpty && r.date == null) continue;
    if (r.date == null) {
      problems[i] = PastRecordProblem.missingDate;
    } else if (r.date!.isAfter(now)) {
      problems[i] = PastRecordProblem.futureDate;
    } else if (r.grams == null && r.stage == null) {
      problems[i] = PastRecordProblem.nothingToSave;
    } else if (r.grams != null && (!r.grams!.isFinite || r.grams! <= 0 || r.grams! >= 1000)) {
      problems[i] = PastRecordProblem.invalidWeight;
    }
  }
  return problems;
}

/// The rows that will be saved, oldest first.
List<PastRecordDraft> savablePastRecords(List<PastRecordDraft> rows) =>
    [for (final r in rows) if (r.date != null && (r.grams != null || r.stage != null)) r]
      ..sort((a, b) => a.date!.compareTo(b.date!));
