import 'dart:io';

import 'package:flutter/foundation.dart';

import '../data/repositories/beetle_repository.dart';
import '../data/repositories/models.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/temperature_repository.dart';
import '../domain/ai/ai_router.dart';
import '../domain/models/enums.dart';
import '../infrastructure/storage/photo_store.dart';
import 'proactive_care_service.dart';

/// Writes breeding records, attaches photos, then runs the proactive care
/// evaluation. Evaluation failures never undo or block the save.
class RecordActions {
  RecordActions({
    required this.beetles,
    required this.temperatures,
    required this.photos,
    required this.proactive,
    required this.settings,
    required this.router,
  });

  final BeetleRepository beetles;
  final TemperatureRepository temperatures;
  final PhotoStore photos;
  final ProactiveCareService proactive;
  final SettingsRepository settings;
  final Future<AiRouter> Function() router;

  Future<int> _afterSave(String? beetleId) async {
    var created = 0;
    try {
      created = await proactive.evaluate(beetleId: beetleId);
    } catch (e, st) {
      debugPrint('rule evaluation failed: $e\n$st');
    }
    if (beetleId != null && await settings.get(SettingsKeys.autoAiInterpretation) == 'true') {
      // Fire and forget: AI is optional and may be offline.
      router()
          .then((r) => proactive.interpretWithAi(beetleId, r))
          .catchError((Object e) {
        debugPrint('auto AI interpretation skipped: $e');
        return const AiInterpretationResult(stored: 0, rejected: 0, errors: []);
      }).ignore();
    }
    return created;
  }

  Future<void> _attach(List<File> files, PhotoOwnerType type, String ownerId, String? beetleId) async {
    for (final f in files) {
      await photos.addPhoto(source: f, ownerType: type, ownerId: ownerId, beetleId: beetleId);
    }
  }

  Future<(String, int)> createBeetle(NewBeetleInput input, {List<File> photos = const []}) async {
    final id = await beetles.createBeetle(input);
    await _attach(photos, PhotoOwnerType.beetle, id, id);
    return (id, await _afterSave(id));
  }

  Future<int> addWeight(String beetleId, DateTime at, double grams,
      {String? notes, List<File> photos = const []}) async {
    final id = await beetles.addWeight(beetleId: beetleId, measuredAt: at, grams: grams, notes: notes);
    await _attach(photos, PhotoOwnerType.weight, id, beetleId);
    return _afterSave(beetleId);
  }

  Future<int> addObservation(String beetleId, DateTime at, ObservationCategory category, String text,
      {List<File> photos = const []}) async {
    final id = await beetles.addObservation(
        beetleId: beetleId, observedAt: at, category: category, description: text);
    await _attach(photos, PhotoOwnerType.observation, id, beetleId);
    return _afterSave(beetleId);
  }

  Future<int> addSubstrateChange({
    required String beetleId,
    required DateTime at,
    String? substrateType,
    String? brand,
    String? batch,
    double? quantityLiters,
    double? beetleWeightGrams,
    String? condition,
    DateTime? nextPlannedAt,
    String? notes,
    List<File> photos = const [],
  }) async {
    final id = await beetles.addSubstrateChange(
      beetleId: beetleId,
      changedAt: at,
      substrateType: substrateType,
      brand: brand,
      batch: batch,
      quantityLiters: quantityLiters,
      beetleWeightGrams: beetleWeightGrams,
      condition: condition,
      nextPlannedAt: nextPlannedAt,
      notes: notes,
    );
    await _attach(photos, PhotoOwnerType.substrate, id, beetleId);
    if (beetleWeightGrams != null) {
      await beetles.addWeight(
          beetleId: beetleId, measuredAt: at, grams: beetleWeightGrams, notes: notes);
    }
    return _afterSave(beetleId);
  }

  Future<int> addContainerChange({
    required String beetleId,
    required DateTime at,
    required double newVolumeLiters,
    double? previousVolumeLiters,
    double? beetleWeightGrams,
    String? condition,
    String? notes,
    List<File> photos = const [],
  }) async {
    final id = await beetles.addContainerChange(
      beetleId: beetleId,
      changedAt: at,
      newVolumeLiters: newVolumeLiters,
      previousVolumeLiters: previousVolumeLiters,
      beetleWeightGrams: beetleWeightGrams,
      condition: condition,
      notes: notes,
    );
    await _attach(photos, PhotoOwnerType.container, id, beetleId);
    if (beetleWeightGrams != null) {
      await beetles.addWeight(
          beetleId: beetleId, measuredAt: at, grams: beetleWeightGrams, notes: notes);
    }
    return _afterSave(beetleId);
  }

  Future<int> addLifeStage(String beetleId, DateTime at, LifeStage stage,
      {L3Phase? l3Phase, bool isEstimated = false, String? notes, List<File> photos = const []}) async {
    final id = await beetles.addLifeStageEvent(
        beetleId: beetleId,
        occurredAt: at,
        stage: stage,
        l3Phase: l3Phase,
        isEstimated: isEstimated,
        notes: notes);
    await _attach(photos, PhotoOwnerType.lifeStage, id, beetleId);
    return _afterSave(beetleId);
  }

  Future<int> addTemperature(String sensorId, DateTime at, double celsius, {String? notes}) async {
    await temperatures.addReading(sensorId: sensorId, recordedAt: at, celsius: celsius, notes: notes);
    return _afterSave(null);
  }
}
