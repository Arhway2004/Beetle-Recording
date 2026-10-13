import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/ai/breeding_tools.dart';
import '../../domain/ai/labeled_answer.dart';
import '../../domain/models/enums.dart';
import '../database/app_database.dart';

/// Structured, auditable AI memory: each analysis keeps its labeled sections,
/// the records it was based on, user feedback, and whether a prediction later
/// turned out to be correct. Deleting an analysis never touches breeding records.
class AiMemoryRepository {
  AiMemoryRepository(this.db);
  final AppDatabase db;
  static const _parser = LabeledAnswerParser();

  Future<String> saveAnalysis({
    required AnalysisKind kind,
    required String provider,
    String? model,
    String? beetleId,
    String? question,
    required String response,
    List<AnswerSection> sections = const [],
    Set<EvidenceRef> evidence = const {},
  }) {
    return db.transaction(() async {
      final id = newId();
      final hasHypothesis = sections.any((s) => s.kind == ClaimKind.hypothesis);
      await db.into(db.aiAnalyses).insert(AiAnalysesCompanion.insert(
            id: Value(id),
            beetleId: Value(beetleId),
            kind: kind,
            provider: provider,
            model: Value(model),
            question: Value(question),
            response: response,
            sectionsJson: Value(sections.isEmpty ? null : _parser.encode(sections)),
            // Hypotheses become trackable predictions the user can later grade.
            outcome: Value(hasHypothesis ? PredictionOutcome.pending : PredictionOutcome.notApplicable),
          ));
      for (final e in evidence) {
        await db.into(db.evidenceReferences).insert(EvidenceReferencesCompanion.insert(
              analysisId: Value(id),
              recordType: e.type,
              recordId: e.id,
            ));
      }
      return id;
    });
  }

  Stream<List<AiAnalysisRow>> watchAnalyses({String? beetleId, AnalysisKind? kind}) =>
      (db.select(db.aiAnalyses)
            ..where((a) =>
                a.deletedAt.isNull() &
                (beetleId == null ? const Constant(true) : a.beetleId.equals(beetleId)) &
                (kind == null ? const Constant(true) : a.kind.equalsValue(kind)))
            ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
          .watch();

  Future<List<EvidenceReferenceRow>> evidenceFor(String analysisId) =>
      (db.select(db.evidenceReferences)..where((e) => e.analysisId.equals(analysisId))).get();

  List<AnswerSection> sectionsOf(AiAnalysisRow row) => _parser.decode(row.sectionsJson);

  Future<void> setFeedback(String id, AnalysisFeedback? feedback) =>
      _update(id, AiAnalysesCompanion(feedback: Value(feedback)));

  Future<void> setOutcome(String id, PredictionOutcome outcome, {String? note}) =>
      _update(id, AiAnalysesCompanion(outcome: Value(outcome), outcomeNote: Value(note)));

  /// Deletes an analysis: content is wiped and the row tombstoned; evidence links
  /// are removed; reminders keep existing but lose the link. Breeding records are untouched.
  Future<void> deleteAnalysis(String id) {
    return db.transaction(() async {
      await (db.update(db.reminders)..where((r) => r.analysisId.equals(id)))
          .write(const RemindersCompanion(analysisId: Value(null)));
      await (db.delete(db.evidenceReferences)..where((e) => e.analysisId.equals(id))).go();
      await _update(
          id,
          AiAnalysesCompanion(
            deletedAt: Value(nowUtc()),
            response: const Value(''),
            question: const Value(null),
            sectionsJson: const Value(null),
          ));
    });
  }

  Future<int> deleteAllAnalyses() async {
    final rows = await (db.select(db.aiAnalyses)..where((a) => a.deletedAt.isNull())).get();
    for (final r in rows) {
      await deleteAnalysis(r.id);
    }
    return rows.length;
  }

  Future<void> _update(String id, AiAnalysesCompanion c) async {
    final row = await (db.select(db.aiAnalyses)..where((a) => a.id.equals(id))).getSingle();
    await (db.update(db.aiAnalyses)..where((a) => a.id.equals(id))).write(
        c.copyWith(updatedAt: Value(nowUtc()), revision: Value(row.revision + 1)));
  }
}
