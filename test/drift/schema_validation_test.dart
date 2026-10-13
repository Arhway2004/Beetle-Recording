// Verifies that a database created by the current migration strategy matches
// the schema Drift expects. When schemaVersion is bumped, run
// `dart run drift_dev make-migrations`: it snapshots drift_schemas/ and
// generates step-by-step upgrade tests in this folder (v1 → vN).
import 'dart:convert';
import 'dart:io';

import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  test('fresh install matches the expected schema', () async {
    final db = memoryDb();
    addTearDown(db.close);
    await db.customSelect('SELECT 1').get(); // opens and runs onCreate
    await db.validateDatabaseSchema();
  });

  test('a schema snapshot exists for the current schema version', () async {
    final db = memoryDb();
    addTearDown(db.close);
    final file = File('drift_schemas/app_database/drift_schema_v${db.schemaVersion}.json');
    expect(file.existsSync(), isTrue, reason: 'run dart run drift_dev make-migrations');
    final snapshot = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
    final entities = (snapshot['entities']! as List).cast<Map<String, Object?>>();
    final tables = entities.where((e) => e['type'] == 'table').map((e) => (e['data']! as Map)['name']).toSet();
    expect(tables, containsAll(['beetles', 'weight_records', 'reminders', 'ai_analyses', 'evidence_references']));
  });
}
