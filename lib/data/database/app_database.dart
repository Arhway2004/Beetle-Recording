import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// Used by generated code (clientDefault: newId / nowUtc).
import '../../core/utils/ids.dart';

import '../../domain/models/enums.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Built-in reference species. These are taxonomy reference data, not demo
/// records; no beetles are created. Expected pupal durations are left null on
/// purpose so the app does not assert biology the user has not configured.
const builtinSpecies = <({String code, String scientificName, String commonName})>[
  (code: 'DHH', scientificName: 'Dynastes hercules hercules', commonName: '长戟大兜虫'),
  (code: 'CCK', scientificName: 'Chalcosoma chiron kirbyi', commonName: '南洋大兜虫（喀氏亚种）'),
];

/// Fixed UUIDs for built-in species, identical on every device and on the
/// server (database/migrations/V001__initial_schema.sql).
const _builtinSpeciesIds = {
  'DHH': '5c1d6b0e-0d1a-4c7e-9a00-000000000001',
  'CCK': '5c1d6b0e-0d1a-4c7e-9a00-000000000002',
};

String builtinSpeciesId(String code) => _builtinSpeciesIds[code]!;

@DriftDatabase(tables: [
  Species,
  TemperatureSensors,
  Beetles,
  WeightRecords,
  ObservationRecords,
  TemperatureRecords,
  SubstrateChanges,
  ContainerChanges,
  LifeStageEvents,
  PhotoAttachments,
  AiAnalyses,
  Reminders,
  EvidenceReferences,
  SuggestionSuppressions,
  AiProviderSettings,
  AppSettings,
  BackupImports,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// Opens the on-device database (`beetle_keeper.sqlite` in app support dir).
  factory AppDatabase.open() => AppDatabase(driftDatabase(name: 'beetle_keeper'));

  /// Bump together with a new `dart run drift_dev make-migrations` snapshot.
  /// Migrations must stay backward compatible: add columns/tables, never drop data.
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await seedReferenceData();
        },
        onUpgrade: (m, from, to) async {
          // Step-by-step migrations, each covered by a test in test/drift/.
          if (from < 2) {
            // v2: parent links (mirrors database/migrations/V002__beetle_parents.sql).
            await m.addColumn(beetles, beetles.sireId);
            await m.addColumn(beetles, beetles.damId);
            await m.addColumn(beetles, beetles.sireNote);
            await m.addColumn(beetles, beetles.damNote);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> seedReferenceData() async {
    await batch((b) {
      for (final s in builtinSpecies) {
        b.insert(
          species,
          SpeciesCompanion.insert(
            // Deterministic IDs so built-in species are identical on every
            // device and backups restore without code conflicts.
            id: Value(builtinSpeciesId(s.code)),
            code: s.code,
            scientificName: s.scientificName,
            commonName: Value(s.commonName),
            isBuiltin: const Value(true),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
      for (final p in AiProviderKind.values) {
        b.insert(
          aiProviderSettings,
          AiProviderSettingsCompanion.insert(
            provider: p,
            model: Value(p == AiProviderKind.mac ? 'qwen3:8b' : 'qwen3-1.7b-q4_k_m.gguf'),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  /// Exported tables in foreign-key dependency order (parents first).
  List<TableInfo<Table, dynamic>> get tablesInDependencyOrder => [
        species,
        temperatureSensors,
        beetles,
        weightRecords,
        observationRecords,
        temperatureRecords,
        substrateChanges,
        containerChanges,
        lifeStageEvents,
        photoAttachments,
        aiAnalyses,
        reminders,
        evidenceReferences,
        suggestionSuppressions,
        appSettings,
      ];

  /// Device-specific tables that are never exported: provider settings hold
  /// endpoints and consent, which must be granted again on a new device.
  List<TableInfo<Table, dynamic>> get deviceLocalTables => [aiProviderSettings, backupImports];
}
