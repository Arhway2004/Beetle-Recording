import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

/// Simplified Chinese is the default language.
final localeProvider = Provider<Locale>((ref) {
  final code = _settings(ref)[SettingsKeys.locale];
  return Locale(supportedLanguageCodes.contains(code) ? code! : 'zh');
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
  return {
    AiProviderKind.mac: MacGatewayProvider(settings: mac, token: token),
    AiProviderKind.mobile: const MobileLlamaProvider(),
  };
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
