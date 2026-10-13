import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/models/enums.dart';

/// Columns shared by every synchronizable record.
///
/// * `id` – stable UUID, never reused.
/// * `created_at` / `updated_at` – UTC instants; `updated_at` changes on every edit.
/// * `deleted_at` – tombstone. Records are soft-deleted so a future sync can
///   propagate deletions; queries filter `deleted_at IS NULL`.
/// * `revision` – incremented on each local edit; used for conflict detection.
mixin SyncColumns on Table {
  TextColumn get id => text().clientDefault(newId)();
  DateTimeColumn get createdAt => dateTime().clientDefault(nowUtc)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(nowUtc)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SpeciesRow')
class Species extends Table with SyncColumns {
  TextColumn get code => text().withLength(min: 2, max: 8).unique()();
  TextColumn get scientificName => text().withLength(min: 1, max: 120)();
  TextColumn get commonName => text().nullable()();
  BoolColumn get isBuiltin => boolean().withDefault(const Constant(false))();

  /// User-configured expected pupal duration. Null = unknown; no window is suggested.
  IntColumn get expectedPupaDaysMin => integer().nullable()();
  IntColumn get expectedPupaDaysMax => integer().nullable()();
  TextColumn get notes => text().nullable()();
}

@DataClassName('TemperatureSensorRow')
class TemperatureSensors extends Table with SyncColumns {
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get location => text().nullable()();
  TextColumn get kind => textEnum<SensorKind>().withDefault(const Constant('manual'))();

  /// Hardware identifier for future Bluetooth / Wi-Fi sensors.
  TextColumn get externalId => text().nullable()();

  /// User-configured thresholds. There are deliberately no defaults: suitable
  /// temperatures depend on species and life stage.
  RealColumn get minThresholdC => real().nullable()();
  RealColumn get maxThresholdC => real().nullable()();
  RealColumn get targetC => real().nullable()();
}

@DataClassName('BeetleRow')
@TableIndex(name: 'idx_beetles_species', columns: {#speciesId})
@TableIndex(name: 'idx_beetles_status', columns: {#status})
class Beetles extends Table with SyncColumns {
  TextColumn get code => text().unique()();
  TextColumn get speciesId => text().references(Species, #id)();
  TextColumn get sex => textEnum<Sex>().withDefault(const Constant('unknown'))();
  TextColumn get status => textEnum<BeetleStatus>().withDefault(const Constant('active'))();
  DateTimeColumn get acquiredAt => dateTime().nullable()();
  DateTimeColumn get hatchDate => dateTime().nullable()();
  DateTimeColumn get estimatedHatchDate => dateTime().nullable()();
  IntColumn get hatchUncertaintyDays => integer().nullable()();
  TextColumn get sensorId => text().nullable().references(TemperatureSensors, #id)();
  TextColumn get notes => text().nullable()();

  // Lineage (schema v2). A parent is a beetle in the collection, or a free-text
  // note when it was never kept here ("WD 125 mm, Sumatra"). Sex and cycle
  // rules are enforced by BeetleRepository.
  TextColumn get sireId => text().nullable().references(Beetles, #id)();
  TextColumn get damId => text().nullable().references(Beetles, #id)();
  TextColumn get sireNote => text().nullable().withLength(max: 200)();
  TextColumn get damNote => text().nullable().withLength(max: 200)();
}

@DataClassName('WeightRecordRow')
@TableIndex(name: 'idx_weight_beetle_time', columns: {#beetleId, #measuredAt})
class WeightRecords extends Table with SyncColumns {
  TextColumn get beetleId => text().references(Beetles, #id)();
  DateTimeColumn get measuredAt => dateTime()();
  // ignore: recursive_getters (Drift check-constraint idiom)
  RealColumn get weightGrams => real().check(weightGrams.isBiggerThanValue(0))();
  TextColumn get notes => text().nullable()();
}

@DataClassName('ObservationRecordRow')
@TableIndex(name: 'idx_observation_beetle_time', columns: {#beetleId, #observedAt})
class ObservationRecords extends Table with SyncColumns {
  TextColumn get beetleId => text().references(Beetles, #id)();
  DateTimeColumn get observedAt => dateTime()();
  TextColumn get category =>
      textEnum<ObservationCategory>().withDefault(const Constant('general'))();
  TextColumn get description => text().withLength(min: 1, max: 4000)();
}

@DataClassName('TemperatureRecordRow')
@TableIndex(name: 'idx_temperature_sensor_time', columns: {#sensorId, #recordedAt})
class TemperatureRecords extends Table with SyncColumns {
  TextColumn get sensorId => text().references(TemperatureSensors, #id)();
  DateTimeColumn get recordedAt => dateTime()();
  RealColumn get celsius => real()();
  TextColumn get source =>
      textEnum<TemperatureSource>().withDefault(const Constant('manual'))();
  TextColumn get notes => text().nullable()();
}

@DataClassName('SubstrateChangeRow')
@TableIndex(name: 'idx_substrate_beetle_time', columns: {#beetleId, #changedAt})
class SubstrateChanges extends Table with SyncColumns {
  TextColumn get beetleId => text().references(Beetles, #id)();
  DateTimeColumn get changedAt => dateTime()();
  TextColumn get substrateType => text().nullable()();
  TextColumn get brand => text().nullable()();
  TextColumn get batch => text().nullable()();
  RealColumn get quantityLiters => real().nullable()();
  RealColumn get beetleWeightGrams => real().nullable()();
  TextColumn get condition => text().nullable()();
  DateTimeColumn get nextPlannedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
}

@DataClassName('ContainerChangeRow')
@TableIndex(name: 'idx_container_beetle_time', columns: {#beetleId, #changedAt})
class ContainerChanges extends Table with SyncColumns {
  TextColumn get beetleId => text().references(Beetles, #id)();
  DateTimeColumn get changedAt => dateTime()();
  RealColumn get previousVolumeLiters => real().nullable()();
  // ignore: recursive_getters (Drift check-constraint idiom)
  RealColumn get newVolumeLiters => real().check(newVolumeLiters.isBiggerThanValue(0))();
  RealColumn get beetleWeightGrams => real().nullable()();
  TextColumn get condition => text().nullable()();
  TextColumn get notes => text().nullable()();
}

@DataClassName('LifeStageEventRow')
@TableIndex(name: 'idx_lifestage_beetle_time', columns: {#beetleId, #occurredAt})
class LifeStageEvents extends Table with SyncColumns {
  TextColumn get beetleId => text().references(Beetles, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get stage => textEnum<LifeStage>()();
  TextColumn get l3Phase => textEnum<L3Phase>().nullable()();

  /// True when the user is unsure of the exact date of the transition.
  BoolColumn get isEstimated => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
}

@DataClassName('PhotoAttachmentRow')
@TableIndex(name: 'idx_photo_owner', columns: {#ownerType, #ownerId})
@TableIndex(name: 'idx_photo_beetle', columns: {#beetleId})
class PhotoAttachments extends Table with SyncColumns {
  TextColumn get ownerType => textEnum<PhotoOwnerType>()();

  /// ID of the record this photo belongs to (polymorphic, see [ownerType]).
  TextColumn get ownerId => text()();
  TextColumn get beetleId => text().nullable().references(Beetles, #id)();

  /// Path relative to the app documents directory (e.g. `photos/<uuid>.jpg`).
  TextColumn get relativePath => text()();
  TextColumn get sha256 => text().withLength(min: 64, max: 64)();
  DateTimeColumn get takenAt => dateTime()();
  TextColumn get caption => text().nullable()();
}

@DataClassName('AiAnalysisRow')
@TableIndex(name: 'idx_analysis_beetle_time', columns: {#beetleId, #createdAt})
class AiAnalyses extends Table with SyncColumns {
  TextColumn get beetleId => text().nullable().references(Beetles, #id)();
  TextColumn get kind => textEnum<AnalysisKind>()();
  TextColumn get provider => text()();
  TextColumn get model => text().nullable()();
  TextColumn get question => text().nullable()();
  TextColumn get response => text()();

  /// JSON array of labeled sections (verified / calculated / observation / hypothesis /
  /// recommendation / unknown). Hypotheses are never promoted to facts.
  TextColumn get sectionsJson => text().nullable()();
  TextColumn get feedback => textEnum<AnalysisFeedback>().nullable()();
  TextColumn get outcome =>
      textEnum<PredictionOutcome>().withDefault(const Constant('notApplicable'))();
  TextColumn get outcomeNote => text().nullable()();
}

@DataClassName('ReminderRow')
@TableIndex(name: 'idx_reminder_status_due', columns: {#status, #dueAt})
@TableIndex(name: 'idx_reminder_dedupe', columns: {#dedupeKey})
@TableIndex(name: 'idx_reminder_beetle_event', columns: {#beetleId, #eventType})
class Reminders extends Table with SyncColumns {
  TextColumn get beetleId => text().nullable().references(Beetles, #id)();
  TextColumn get sensorId => text().nullable().references(TemperatureSensors, #id)();

  /// [CareEventType.wire].
  TextColumn get eventType => text()();
  TextColumn get title => text().withLength(min: 1, max: 80)();
  TextColumn get message => text().withLength(min: 0, max: 500)();
  DateTimeColumn get dueAt => dateTime()();
  TextColumn get status => textEnum<ReminderStatus>()();
  TextColumn get source => textEnum<ReminderSource>()();
  TextColumn get basis => text().nullable()();
  TextColumn get severity => textEnum<Severity>().nullable()();
  TextColumn get confidence => textEnum<Confidence>().nullable()();
  TextColumn get reason => text().nullable()();
  TextColumn get recommendation => text().nullable()();

  /// Identifies "same beetle + event + observation period" to prevent duplicates.
  TextColumn get dedupeKey => text().nullable()();
  DateTimeColumn get periodStart => dateTime().nullable()();
  DateTimeColumn get periodEnd => dateTime().nullable()();
  IntColumn get notificationId => integer().nullable()();
  TextColumn get analysisId => text().nullable().references(AiAnalyses, #id)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get postponedCount => integer().withDefault(const Constant(0))();
}

/// Links an AI analysis or reminder to the stored records it is based on.
@DataClassName('EvidenceReferenceRow')
@TableIndex(name: 'idx_evidence_analysis', columns: {#analysisId})
@TableIndex(name: 'idx_evidence_reminder', columns: {#reminderId})
class EvidenceReferences extends Table with SyncColumns {
  TextColumn get analysisId =>
      text().nullable().references(AiAnalyses, #id, onDelete: KeyAction.cascade)();
  TextColumn get reminderId =>
      text().nullable().references(Reminders, #id, onDelete: KeyAction.cascade)();
  TextColumn get recordType => textEnum<RecordType>()();
  TextColumn get recordId => text()();
}

/// "Disable similar suggestions": blocks rule/AI suggestions of an event type,
/// optionally for one beetle and optionally until a date.
@DataClassName('SuggestionSuppressionRow')
class SuggestionSuppressions extends Table with SyncColumns {
  TextColumn get beetleId => text().nullable().references(Beetles, #id)();
  TextColumn get eventType => text()();
  DateTimeColumn get until => dateTime().nullable()();
}

/// Non-secret AI provider configuration. Credentials live in secure storage.
@DataClassName('AiProviderSettingRow')
class AiProviderSettings extends Table with SyncColumns {
  TextColumn get provider => textEnum<AiProviderKind>().unique()();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  TextColumn get baseUrl => text().nullable()();
  TextColumn get model => text().nullable()();

  /// SHA-256 fingerprint (hex) of a self-signed gateway certificate to pin.
  TextColumn get certSha256 => text().nullable()();
  IntColumn get timeoutSeconds => integer().withDefault(const Constant(60))();

  /// Explicit user consent to send breeding data to this provider.
  DateTimeColumn get consentGrantedAt => dateTime().nullable()();
}

/// Key/value app settings (theme, locale, rule thresholds). Included in backups.
@DataClassName('AppSettingRow')
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().clientDefault(nowUtc)();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// Backups that have been restored, to detect duplicate imports.
@DataClassName('BackupImportRow')
class BackupImports extends Table {
  TextColumn get backupId => text()();
  DateTimeColumn get importedAt => dateTime().clientDefault(nowUtc)();
  IntColumn get insertedCount => integer()();
  IntColumn get updatedCount => integer()();
  IntColumn get skippedCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {backupId};
}
