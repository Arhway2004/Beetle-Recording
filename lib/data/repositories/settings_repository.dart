import 'package:drift/drift.dart';

import '../../core/utils/ids.dart';
import '../../domain/models/enums.dart';
import '../../domain/proactive/care_rules.dart';
import '../database/app_database.dart';

class SettingsKeys {
  static const themeMode = 'ui.theme_mode'; // system | light | dark
  static const locale = 'ui.locale'; // zh | en | th
  static const routing = 'ai.routing'; // auto | mac | mobile
  static const autoAiInterpretation = 'ai.auto_interpretation'; // true | false
  static const notificationPermissionAsked = 'notifications.permission_asked';
}

/// Key/value settings plus AI provider configuration (non-secret parts).
class SettingsRepository {
  SettingsRepository(this.db);
  final AppDatabase db;

  Stream<Map<String, String>> watchAll() =>
      db.select(db.appSettings).watch().map((rows) => {for (final r in rows) r.key: r.value});

  Future<Map<String, String>> all() async =>
      {for (final r in await db.select(db.appSettings).get()) r.key: r.value};

  Future<String?> get(String key) async =>
      (await (db.select(db.appSettings)..where((s) => s.key.equals(key))).getSingleOrNull())?.value;

  Future<void> set(String key, String value) => db.into(db.appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(key: key, value: value, updatedAt: Value(nowUtc())));

  Future<void> setAll(Map<String, String> values) => db.batch((b) {
        for (final e in values.entries) {
          b.insert(db.appSettings,
              AppSettingsCompanion.insert(key: e.key, value: e.value, updatedAt: Value(nowUtc())),
              onConflict: DoUpdate((_) => AppSettingsCompanion(value: Value(e.value))));
        }
      });

  Future<CareRuleSettings> careRules() async => CareRuleSettings.fromMap(await all());

  Future<void> saveCareRules(CareRuleSettings s) => setAll(s.toMap());

  // ------------------------------------------------------------ AI providers

  Stream<List<AiProviderSettingRow>> watchProviders() => db.select(db.aiProviderSettings).watch();

  Future<AiProviderSettingRow> provider(AiProviderKind kind) =>
      (db.select(db.aiProviderSettings)..where((p) => p.provider.equalsValue(kind))).getSingle();

  Future<void> updateProvider(
    AiProviderKind kind, {
    bool? enabled,
    String? baseUrl,
    String? model,
    String? Function()? certSha256,
    int? timeoutSeconds,
  }) async {
    final row = await provider(kind);
    await (db.update(db.aiProviderSettings)..where((p) => p.id.equals(row.id))).write(
      AiProviderSettingsCompanion(
        enabled: enabled == null ? const Value.absent() : Value(enabled),
        baseUrl: baseUrl == null ? const Value.absent() : Value(baseUrl.trim()),
        model: model == null ? const Value.absent() : Value(model.trim()),
        certSha256: certSha256 == null ? const Value.absent() : Value(certSha256()),
        timeoutSeconds: timeoutSeconds == null ? const Value.absent() : Value(timeoutSeconds),
        updatedAt: Value(nowUtc()),
        revision: Value(row.revision + 1),
      ),
    );
  }

  Future<void> setConsent(AiProviderKind kind, bool granted) async {
    final row = await provider(kind);
    await (db.update(db.aiProviderSettings)..where((p) => p.id.equals(row.id))).write(
        AiProviderSettingsCompanion(
            consentGrantedAt: Value(granted ? nowUtc() : null), updatedAt: Value(nowUtc())));
  }
}
