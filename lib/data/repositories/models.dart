import '../../domain/models/enums.dart';

/// Read model for lists and profile headers. "Current" values are derived from
/// the latest event of each kind; history is never overwritten.
class BeetleSummary {
  const BeetleSummary({
    required this.id,
    required this.code,
    required this.speciesId,
    required this.speciesCode,
    required this.speciesName,
    required this.speciesCommonName,
    required this.sex,
    required this.status,
    required this.acquiredAt,
    required this.hatchDate,
    required this.estimatedHatchDate,
    required this.hatchUncertaintyDays,
    required this.sensorId,
    required this.notes,
    required this.createdAt,
    required this.sireId,
    required this.damId,
    required this.sireCode,
    required this.damCode,
    required this.sireNote,
    required this.damNote,
    required this.stage,
    required this.l3Phase,
    required this.stageAt,
    required this.latestWeightGrams,
    required this.latestWeightAt,
    required this.maxWeightGrams,
    required this.containerLiters,
    required this.substrateType,
    required this.substrateBrand,
  });

  final String id;
  final String code;
  final String speciesId;
  final String speciesCode;
  final String speciesName;
  final String? speciesCommonName;
  final Sex sex;
  final BeetleStatus status;
  final DateTime? acquiredAt;
  final DateTime? hatchDate;
  final DateTime? estimatedHatchDate;
  final int? hatchUncertaintyDays;
  final String? sensorId;
  final String? notes;
  final DateTime createdAt;

  /// Parents in the collection (id + code), or free-text notes for parents
  /// that were never kept here.
  final String? sireId;
  final String? damId;
  final String? sireCode;
  final String? damCode;
  final String? sireNote;
  final String? damNote;

  bool get hasParents => sireId != null || damId != null || sireNote != null || damNote != null;
  final LifeStage? stage;
  final L3Phase? l3Phase;
  final DateTime? stageAt;
  final double? latestWeightGrams;
  final DateTime? latestWeightAt;
  final double? maxWeightGrams;
  final double? containerLiters;
  final String? substrateType;
  final String? substrateBrand;

  Map<String, Object?> toToolJson() => {
        'id': id,
        'beetle_id': code,
        'species_code': speciesCode,
        'species': speciesName,
        'sex': sex.name,
        'status': status.name,
        'acquired_at': acquiredAt?.toUtc().toIso8601String(),
        'hatch_date': hatchDate?.toUtc().toIso8601String(),
        'estimated_hatch_date': estimatedHatchDate?.toUtc().toIso8601String(),
        'hatch_date_uncertainty_days': hatchUncertaintyDays,
        'current_stage': stage?.name,
        'l3_phase': l3Phase?.name,
        'stage_recorded_at': stageAt?.toUtc().toIso8601String(),
        'latest_weight_grams': latestWeightGrams,
        'latest_weight_at': latestWeightAt?.toUtc().toIso8601String(),
        'max_weight_grams': maxWeightGrams,
        'container_liters': containerLiters,
        'substrate_type': substrateType,
        'substrate_brand': substrateBrand,
        'sire': sireCode ?? sireNote,
        'dam': damCode ?? damNote,
        'notes': notes,
      };
}

class BeetleFilter {
  const BeetleFilter({this.speciesId, this.sex, this.stage, this.status, this.query});
  final String? speciesId;
  final Sex? sex;
  final LifeStage? stage;
  final BeetleStatus? status;
  final String? query;

  bool matches(BeetleSummary b) =>
      (speciesId == null || b.speciesId == speciesId) &&
      (sex == null || b.sex == sex) &&
      (stage == null || b.stage == stage) &&
      (status == null || b.status == status) &&
      (query == null ||
          query!.isEmpty ||
          b.code.toLowerCase().contains(query!.toLowerCase()) ||
          (b.notes ?? '').toLowerCase().contains(query!.toLowerCase()));
}

enum TimelineType { weight, observation, substrate, container, lifeStage, temperature }

/// One row of the unified record history.
class TimelineEntry {
  const TimelineEntry({
    required this.type,
    required this.id,
    required this.at,
    required this.beetleId,
    required this.beetleCode,
    this.num1,
    this.num2,
    this.text1,
    this.text2,
  });

  final TimelineType type;
  final String id;
  final DateTime at;
  final String? beetleId;
  final String? beetleCode;
  final double? num1;
  final double? num2;
  final String? text1;
  final String? text2;
}

/// Input for creating a beetle together with its initial history events.
class NewBeetleInput {
  const NewBeetleInput({
    required this.code,
    required this.speciesId,
    required this.sex,
    this.acquiredAt,
    this.hatchDate,
    this.estimatedHatchDate,
    this.hatchUncertaintyDays,
    this.initialStage,
    this.initialL3Phase,
    this.initialWeightGrams,
    this.containerLiters,
    this.substrateType,
    this.substrateBrand,
    this.sensorId,
    this.notes,
    this.sireId,
    this.damId,
    this.sireNote,
    this.damNote,
  });

  final String code;
  final String speciesId;
  final Sex sex;
  final DateTime? acquiredAt;
  final DateTime? hatchDate;
  final DateTime? estimatedHatchDate;
  final int? hatchUncertaintyDays;
  final LifeStage? initialStage;
  final L3Phase? initialL3Phase;
  final double? initialWeightGrams;
  final double? containerLiters;
  final String? substrateType;
  final String? substrateBrand;
  final String? sensorId;
  final String? notes;
  final String? sireId;
  final String? damId;
  final String? sireNote;
  final String? damNote;
}

enum ParentError { self, sameParent, notFound, wrongSex, cycle, sexConflictsWithOffspring }

/// A parent link would be impossible (wrong sex, own ancestor, ...).
class ParentException implements Exception {
  ParentException(this.error, {this.role});
  final ParentError error;

  /// `sire` or `dam`, when the error concerns one of them.
  final String? role;

  @override
  String toString() => 'ParentException(${error.name}${role == null ? '' : ', $role'})';
}

class DuplicateCodeException implements Exception {
  DuplicateCodeException(this.code);
  final String code;
}
