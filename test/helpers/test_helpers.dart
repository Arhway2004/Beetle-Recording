// Test-only fakes. Not used by production code.
import 'dart:convert';
import 'dart:io';

import 'package:beetle_keeper/data/database/app_database.dart';
import 'package:beetle_keeper/domain/proactive/care_rules.dart';
import 'package:beetle_keeper/infrastructure/notifications/notification_gateway.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

AppDatabase memoryDb() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(NativeDatabase.memory());
}

/// Reads a shared contract fixture from `packages/api-contracts/fixtures`.
Object? contractFixture(String relative) {
  final file = File('../../packages/api-contracts/fixtures/$relative');
  return jsonDecode(file.readAsStringSync());
}

List<File> contractFixtures(String dir) =>
    Directory('../../packages/api-contracts/fixtures/$dir')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));

class FakeNotificationGateway implements NotificationGateway {
  FakeNotificationGateway({this.permission = true, this.exact = true});

  bool permission;
  bool exact;
  bool permissionRequested = false;
  final Map<int, ({String title, DateTime at, bool exact})> pending = {};

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasPermission() async => permission;

  @override
  Future<bool> requestPermission() async {
    permissionRequested = true;
    return permission;
  }

  @override
  Future<bool> canScheduleExact() async => exact;

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required bool exact,
    String? payload,
  }) async =>
      pending[id] = (title: title, at: at, exact: exact);

  @override
  Future<void> cancel(int id) async => pending.remove(id);

  @override
  Future<Set<int>> pendingIds() async => pending.keys.toSet();

  @override
  Future<void> refreshTimeZone() async {}
}

class FakeCareTexts implements CareTexts {
  CareText _t(String key) => CareText(title: key, message: '$key message', reason: '$key reason', recommendation: '$key rec');

  @override
  CareText weightChange({required String code, required double percent, required double fromG, required double toG}) =>
      _t('weight $code ${percent.toStringAsFixed(1)}');

  @override
  CareText measurementOverdue({required String code, required int? daysSince}) => _t('overdue $code');

  @override
  CareText substrateInspection({required String code, required int daysSinceChange}) => _t('substrate $code');

  @override
  CareText temperatureOutOfRange({required String sensor, required double celsius, double? minC, double? maxC}) =>
      _t('temp $sensor');

  @override
  CareText possiblePrepupa({required String code}) => _t('prepupa $code');

  @override
  CareText emergenceWindow({required String code, required int minDays, required int maxDays}) => _t('emergence $code');
}
