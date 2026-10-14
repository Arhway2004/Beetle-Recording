import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/models/enums.dart';
import '../common/labels.dart';
import '../common/widgets.dart';
import '../shell/home_shell.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _languageNames = {'zh': '简体中文', 'en': 'English', 'th': 'ไทย'};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final settings = ref.watch(settingsRepoProvider);
    final theme = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final routing = ref.watch(routingPreferenceProvider);
    final autoAi = ref.watch(settingsMapProvider).valueOrNull?[SettingsKeys.autoAiInterpretation] == 'true';

    Widget header(String text) => Padding(
          padding: const EdgeInsets.fromLTRB(Insets.m, Insets.l, Insets.m, Insets.s),
          child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
        );
    Widget link(IconData icon, String title, String path, {String? subtitle}) => ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.go('${AppRoutes.settings}/$path'),
        );

    return Scaffold(
      appBar: topLevelAppBar(context, l.navSettings),
      body: ListView(children: [
        header(l.settingsAppearance),
        ListTile(
          leading: const Icon(Icons.palette_outlined),
          title: Text(l.settingsTheme),
          trailing: SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: ThemeMode.system, label: Text(l.themeSystem)),
              ButtonSegment(value: ThemeMode.light, label: Text(l.themeLight)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l.themeDark)),
            ],
            selected: {theme},
            onSelectionChanged: (s) => settings.set(SettingsKeys.themeMode, s.first.name),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.translate),
          title: Text(l.settingsLanguage),
          trailing: DropdownButton<String>(
            value: locale.languageCode,
            underline: const SizedBox.shrink(),
            items: [
              for (final code in supportedLanguageCodes)
                DropdownMenuItem(value: code, child: Text(_languageNames[code]!)),
            ],
            onChanged: (v) => v == null ? null : settings.set(SettingsKeys.locale, v),
          ),
        ),
        header(l.settingsAi),
        link(Icons.computer, l.settingsMacGateway, 'ai'),
        ListTile(
          leading: const Icon(Icons.alt_route),
          title: Text(l.settingsRouting),
          trailing: DropdownButton<AiRoutingPreference>(
            value: routing,
            underline: const SizedBox.shrink(),
            items: [
              DropdownMenuItem(value: AiRoutingPreference.auto, child: Text(l.routingAuto)),
              DropdownMenuItem(value: AiRoutingPreference.mac, child: Text(l.routingMac)),
              DropdownMenuItem(value: AiRoutingPreference.mobile, child: Text(l.routingMobile)),
            ],
            onChanged: (v) => v == null ? null : settings.set(SettingsKeys.routing, v.name),
          ),
        ),
        link(Icons.phone_iphone, l.settingsMobileAi, 'on-device', subtitle: l.settingsMobileAiStatus),
        ListTile(
          leading: const Icon(Icons.image_search),
          title: Text(l.settingsVision),
          subtitle: Text(l.assistantImageUnavailable),
        ),
        SwitchListTile.adaptive(
          secondary: const Icon(Icons.auto_awesome_outlined),
          title: Text(l.settingsAutoAi),
          subtitle: Text(l.settingsAutoAiHelper),
          value: autoAi,
          onChanged: (v) => settings.set(SettingsKeys.autoAiInterpretation, '$v'),
        ),
        link(Icons.psychology_outlined, l.settingsAiMemory, 'memory'),
        header(l.settingsCareRules),
        link(Icons.rule, l.settingsCareRules, 'rules'),
        link(Icons.notifications_off_outlined, l.settingsSuppressions, 'suppressions'),
        link(Icons.category_outlined, l.settingsSpecies, 'species'),
        link(Icons.thermostat, l.settingsSensors, 'sensors'),
        header(l.settingsBackup),
        link(Icons.backup_outlined, l.settingsBackup, 'backup', subtitle: l.backupExportHelper),
        header(l.settingsPrivacy),
        ListTile(leading: const Icon(Icons.lock_outline), title: Text(l.privacyBody)),
        header(l.settingsAbout),
        ListTile(
          leading: const AppLogo(size: 32),
          title: Text(l.appTitle),
          subtitle: Text(l.aboutVersion(ref.watch(appVersionProvider))),
        ),
        const SizedBox(height: Insets.xl),
      ]),
    );
  }
}
