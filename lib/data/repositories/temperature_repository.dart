import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/models/enums.dart';
import '../database/app_database.dart';

class SensorStats {
  const SensorStats({required this.sensor, this.latest, this.minC, this.maxC, this.count = 0});
  final TemperatureSensorRow sensor;
  final TemperatureRecordRow? latest;
  final double? minC;
  final double? maxC;
  final int count;

  bool get latestOutOfRange {
    final c = latest?.celsius;
    if (c == null) return false;
    return (sensor.minThresholdC != null && c < sensor.minThresholdC!) ||
        (sensor.maxThresholdC != null && c > sensor.maxThresholdC!);
  }
}

/// Temperature sensors (manual or, in future, Bluetooth/Wi-Fi) and readings.
class TemperatureRepository {
  TemperatureRepository(this.db);
  final AppDatabase db;

  Stream<List<TemperatureSensorRow>> watchSensors() => (db.select(db.temperatureSensors)
        ..where((s) => s.deletedAt.isNull())
        ..orderBy([(s) => OrderingTerm(expression: s.name)]))
      .watch();

  Future<List<TemperatureSensorRow>> sensors() => (db.select(db.temperatureSensors)
        ..where((s) => s.deletedAt.isNull()))
      .get();

  Future<String> saveSensor({
    String? id,
    required String name,
    String? location,
    SensorKind kind = SensorKind.manual,
    double? minThresholdC,
    double? maxThresholdC,
    double? targetC,
  }) async {
    if (minThresholdC != null && maxThresholdC != null && minThresholdC > maxThresholdC) {
      throw ArgumentError('minThresholdC must not exceed maxThresholdC');
    }
    if (id == null) {
      final newSensorId = newId();
      await db.into(db.temperatureSensors).insert(TemperatureSensorsCompanion.insert(
            id: Value(newSensorId),
            name: name.trim(),
            location: Value(location),
            kind: Value(kind),
            minThresholdC: Value(minThresholdC),
            maxThresholdC: Value(maxThresholdC),
            targetC: Value(targetC),
          ));
      return newSensorId;
    }
    await db.transaction(() async {
      final row =
          await (db.select(db.temperatureSensors)..where((s) => s.id.equals(id))).getSingle();
      await (db.update(db.temperatureSensors)..where((s) => s.id.equals(id)))
          .write(TemperatureSensorsCompanion(
        name: Value(name.trim()),
        location: Value(location),
        kind: Value(kind),
        minThresholdC: Value(minThresholdC),
        maxThresholdC: Value(maxThresholdC),
        targetC: Value(targetC),
        updatedAt: Value(nowUtc()),
        revision: Value(row.revision + 1),
      ));
    });
    return id;
  }

  Future<String> addReading({
    required String sensorId,
    required DateTime recordedAt,
    required double celsius,
    TemperatureSource source = TemperatureSource.manual,
    String? notes,
  }) async {
    if (!celsius.isFinite || celsius < -40 || celsius > 80) {
      throw ArgumentError.value(celsius, 'celsius', 'outside plausible range');
    }
    final id = newId();
    await db.into(db.temperatureRecords).insert(TemperatureRecordsCompanion.insert(
          id: Value(id),
          sensorId: sensorId,
          recordedAt: recordedAt.toUtc(),
          celsius: celsius,
          source: Value(source),
          notes: Value(notes),
        ));
    return id;
  }

  Future<List<TemperatureRecordRow>> readings(String? sensorId, {DateTime? since}) =>
      (db.select(db.temperatureRecords)
            ..where((r) =>
                r.deletedAt.isNull() &
                (sensorId == null ? const Constant(true) : r.sensorId.equals(sensorId)) &
                (since == null ? const Constant(true) : r.recordedAt.isBiggerOrEqualValue(since)))
            ..orderBy([(r) => OrderingTerm(expression: r.recordedAt)]))
          .get();

  Stream<List<TemperatureRecordRow>> watchReadings(String sensorId, {DateTime? since}) =>
      (db.select(db.temperatureRecords)
            ..where((r) =>
                r.deletedAt.isNull() &
                r.sensorId.equals(sensorId) &
                (since == null ? const Constant(true) : r.recordedAt.isBiggerOrEqualValue(since)))
            ..orderBy([(r) => OrderingTerm(expression: r.recordedAt)]))
          .watch();

  /// Current / min / max per sensor over the window (default 7 days).
  Stream<List<SensorStats>> watchStats({Duration window = const Duration(days: 7)}) {
    return watchSensors().asyncMap((sensors) async {
      final since = nowUtc().subtract(window);
      return [
        for (final s in sensors)
          await () async {
            final r = await readings(s.id, since: since);
            final latest = (await (db.select(db.temperatureRecords)
                      ..where((x) => x.sensorId.equals(s.id) & x.deletedAt.isNull())
                      ..orderBy([(x) => OrderingTerm.desc(x.recordedAt)])
                      ..limit(1))
                    .getSingleOrNull());
            return SensorStats(
              sensor: s,
              latest: latest,
              count: r.length,
              minC: r.isEmpty ? null : r.map((e) => e.celsius).reduce((a, b) => a < b ? a : b),
              maxC: r.isEmpty ? null : r.map((e) => e.celsius).reduce((a, b) => a > b ? a : b),
            );
          }(),
      ];
    });
  }
}
