import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../data/database/app_database.dart';
import '../data/repositories/ai_memory_repository.dart';
import '../data/repositories/beetle_repository.dart';
import '../data/repositories/breeding_read_model.dart';
import '../data/repositories/reminder_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/temperature_repository.dart';
import '../domain/ai/ai_orchestrator.dart';
import '../domain/ai/ai_provider.dart';
import '../domain/ai/ai_router.dart';
import '../domain/ai/breeding_tools.dart';
import '../domain/ai/vision.dart';
import '../domain/models/enums.dart';
import '../infrastructure/ai/model_store.dart';
import '../infrastructure/ai/on_device_runtime.dart';
import '../infrastructure/ai/providers.dart';
import '../infrastructure/backup/backup_service.dart';
import '../infrastructure/notifications/notification_gateway.dart';
import '../infrastructure/notifications/reminder_scheduler.dart';
import '../infrastructure/storage/photo_store.dart';
import '../infrastructure/storage/secure_store.dart';
import '../l10n/gen/app_localizations.dart';
import 'l10n_care_texts.dart';
import 'proactive_care_service.dart';
import 'record_actions.dart';
import 'reminder_actions.dart';

// ------------------------------------------------------------- platform roots
// Overridden in bootstrap (and in tests with in-memory implementations).

final databaseProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('databaseProvider'));
final documentsDirProvider = Provider<Directory>((ref) => throw UnimplementedError('documentsDirProvider'));

/// Application Support: re-downloadable data such as on-device models (not Documents,
/// which iOS includes in iCloud backups).
final supportDirProvider = Provider<Directory>((ref) => throw UnimplementedError('supportDirProvider'));
final secretStoreProvider = Provider<SecretStore>((ref) => PlatformSecretStore());
final notificationGatewayProvider = Provider<NotificationGateway>((ref) => LocalNotificationGateway());
final appVersionProvider = Provider<String>((ref) => '1.0.0');

// ---------------------------------------------------------------- repositories

final beetleRepoProvider = Provider((ref) => BeetleRepository(ref.watch(databaseProvider)));
final temperatureRepoProvider = Provider((ref) => TemperatureRepository(ref.watch(databaseProvider)));
final reminderRepoProvider = Provider((ref) => ReminderRepository(ref.watch(databaseProvider)));
final aiMemoryRepoProvider = Provider((ref) => AiMemoryRepository(ref.watch(databaseProvider)));
final settingsRepoProvider = Provider((ref) => SettingsRepository(ref.watch(databaseProvider)));
final readModelProvider = Provider(
    (ref) => DriftBreedingReadModel(ref.watch(beetleRepoProvider), ref.watch(temperatureRepoProvider)));
final photoStoreProvider =
    Provider((ref) => PhotoStore(ref.watch(databaseProvider), ref.watch(documentsDirProvider)));
final backupServiceProvider = Provider((ref) => BackupService(
    ref.watch(databaseProvider), ref.watch(documentsDirProvider),
    appVersion: ref.watch(appVersionProvider)));

// -------------------------------------------------------------------- settings

final settingsMapProvider = StreamProvider<Map<String, String>>(
    (ref) => ref.watch(settingsRepoProvider).watchAll());

/// Settings loaded before `runApp`, so the first frame has the right theme/locale.
final initialSettingsProvider = Provider<Map<String, String>>((ref) => const {});

Map<String, String> _settings(Ref ref) =>
    ref.watch(settingsMapProvider).valueOrNull ?? ref.watch(initialSettingsProvider);

final themeModeProvider = Provider<ThemeMode>((ref) => switch (_settings(ref)[SettingsKeys.themeMode]) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    });

const supportedLanguageCodes = ['zh', 'en', 'th'];

/// Stored language preference meaning "follow the device".
const systemLanguage = 'system';

/// The stored choice: a code from [supportedLanguageCodes] or [systemLanguage].
/// Simplified Chinese stays the default when nothing was chosen.
final languagePreferenceProvider = Provider<String>((ref) {
  final code = _settings(ref)[SettingsKeys.locale];
  return code == systemLanguage || supportedLanguageCodes.contains(code) ? code! : 'zh';
});

/// The device language if the app supports it (any Chinese variant → zh), else zh.
Locale resolveSupportedLocale(Locale? device) =>
    Locale(supportedLanguageCodes.contains(device?.languageCode) ? device!.languageCode : 'zh');

/// The language actually shown, also used for text built outside widgets
/// (notifications, care texts). Invalidated when the device language changes.
final localeProvider = Provider<Locale>((ref) {
  final pref = ref.watch(languagePreferenceProvider);
  return pref == systemLanguage ? resolveSupportedLocale(WidgetsBinding.instance.platformDispatcher.locale) : Locale(pref);
});

final l10nProvider = Provider<AppLocalizations>((ref) => lookupAppLocalizations(ref.watch(localeProvider)));

final routingPreferenceProvider = Provider<AiRoutingPreference>((ref) {
  final v = _settings(ref)[SettingsKeys.routing];
  return AiRoutingPreference.values.where((p) => p.name == v).firstOrNull ?? AiRoutingPreference.auto;
});

// -------------------------------------------------------------------------- AI

final providerSettingsProvider = StreamProvider<List<AiProviderSettingRow>>(
    (ref) => ref.watch(settingsRepoProvider).watchProviders());

final gatewayTokenProvider =
    FutureProvider<String?>((ref) => ref.watch(secretStoreProvider).read(SecretKeys.gatewayToken));

final aiProvidersProvider = FutureProvider<Map<AiProviderKind, AiProvider>>((ref) async {
  final rows = await ref.watch(providerSettingsProvider.future);
  final token = await ref.watch(gatewayTokenProvider.future);
  final mac = rows.firstWhere((r) => r.provider == AiProviderKind.mac);
  final mobile = rows.firstWhere((r) => r.provider == AiProviderKind.mobile);
  return {
    AiProviderKind.mac: MacGatewayProvider(settings: mac, token: token),
    AiProviderKind.mobile: MobileLlamaProvider(
      settings: mobile,
      store: ref.watch(modelStoreProvider),
      runtime: ref.watch(onDeviceRuntimeProvider),
    ),
  };
});

/// Downloaded on-device models live in `<app support>/models/`; they are never part of app backups.
final modelStoreProvider =
    Provider<ModelStore>((ref) => ModelStore(Directory(p.join(ref.watch(supportDirProvider).path, 'models'))));

/// One runtime for the app's lifetime so the loaded model survives settings changes.
final onDeviceRuntimeProvider = Provider<OnDeviceRuntime>((ref) {
  final runtime = LlamaDartRuntime();
  ref.onDispose(runtime.unload);
  return runtime;
});

final aiRouterProvider = FutureProvider<AiRouter>((ref) async => AiRouter(
      providers: await ref.watch(aiProvidersProvider.future),
      preference: ref.watch(routingPreferenceProvider),
    ));

final providerStatusesProvider = FutureProvider<List<ProviderStatus>>((ref) async {
  final providers = await ref.watch(aiProvidersProvider.future);
  return [for (final p in providers.values) await p.status()];
});

final breedingToolsProvider = Provider((ref) => BreedingTools(ref.watch(readModelProvider)));

final orchestratorProvider = FutureProvider<AiOrchestrator>((ref) async =>
    AiOrchestrator(router: await ref.watch(aiRouterProvider.future), tools: ref.watch(breedingToolsProvider)));

final visionProviderProvider = Provider<VisionProvider>((ref) => const UnavailableVisionProvider());

// ------------------------------------------------------------------- services

final reminderSchedulerProvider = Provider(
    (ref) => ReminderScheduler(ref.watch(reminderRepoProvider), ref.watch(notificationGatewayProvider)));

final reminderActionsProvider = Provider((ref) => ReminderActions(
      ref.watch(reminderRepoProvider),
      ref.watch(reminderSchedulerProvider),
      ref.watch(notificationGatewayProvider),
      ref.watch(settingsRepoProvider),
    ));

final proactiveCareProvider = Provider((ref) => ProactiveCareService(
      readModel: ref.watch(readModelProvider),
      reminders: ref.watch(reminderRepoProvider),
      settings: ref.watch(settingsRepoProvider),
      memory: ref.watch(aiMemoryRepoProvider),
      texts: () => L10nCareTexts(ref.read(l10nProvider)),
    ));

final recordActionsProvider = Provider((ref) => RecordActions(
      beetles: ref.watch(beetleRepoProvider),
      temperatures: ref.watch(temperatureRepoProvider),
      photos: ref.watch(photoStoreProvider),
      proactive: ref.watch(proactiveCareProvider),
      settings: ref.watch(settingsRepoProvider),
      router: () => ref.read(aiRouterProvider.future),
    ));
