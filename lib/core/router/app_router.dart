import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/models.dart';
import '../../presentation/analytics/analytics_screen.dart';
import '../../presentation/assistant/assistant_screen.dart';
import '../../presentation/beetles/beetle_detail_screen.dart';
import '../../presentation/beetles/beetle_form_screen.dart';
import '../../presentation/beetles/beetles_screen.dart';
import '../../presentation/dashboard/dashboard_screen.dart';
import '../../presentation/records/past_records_screen.dart';
import '../../presentation/records/record_form_screen.dart';
import '../../presentation/records/records_screen.dart';
import '../../presentation/reminders/reminder_form_screen.dart';
import '../../presentation/reminders/reminders_screen.dart';
import '../../presentation/settings/ai_memory_screen.dart';
import '../../presentation/settings/ai_settings_screen.dart';
import '../../presentation/settings/backup_screen.dart';
import '../../presentation/settings/care_rules_screen.dart';
import '../../presentation/settings/on_device_ai_screen.dart';
import '../../presentation/settings/sensors_screen.dart';
import '../../presentation/settings/settings_screen.dart';
import '../../presentation/settings/species_screen.dart';
import '../../presentation/settings/suppressions_screen.dart';
import '../../presentation/shell/home_shell.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Top-level destinations, in navigation order.
class AppRoutes {
  static const dashboard = '/dashboard';
  static const beetles = '/beetles';
  static const records = '/records';
  static const assistant = '/assistant';
  static const reminders = '/reminders';
  static const analytics = '/analytics';
  static const settings = '/settings';

  static String beetle(String id) => '/beetles/$id';
  static String editBeetle(String id) => '/beetles/$id/edit';
  static String pastRecords(String id) => '/beetles/$id/history';
  static const newBeetle = '/beetles/new';
  static String newRecord(TimelineType type, {String? beetleId}) =>
      Uri(path: '/records/new', queryParameters: {'type': type.name, if (beetleId != null) 'beetle': beetleId}).toString();
  static String newReminder({String? beetleId}) =>
      Uri(path: '/reminders/new', queryParameters: {if (beetleId != null) 'beetle': beetleId}).toString();
}

GoRoute _modal(String path, Widget Function(GoRouterState s) build) => GoRoute(
      path: path,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) => MaterialPage(fullscreenDialog: true, child: build(state)),
    );

GoRouter buildRouter() => GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.dashboard,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => HomeShell(shell: shell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.dashboard, builder: (_, __) => const DashboardScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: AppRoutes.beetles,
                builder: (_, __) => const BeetlesScreen(),
                routes: [
                  _modal('new', (_) => const BeetleFormScreen()),
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (_, s) => BeetleDetailScreen(beetleId: s.pathParameters['id']!),
                    routes: [
                      _modal('edit', (s) => BeetleFormScreen(beetleId: s.pathParameters['id'])),
                      _modal('history', (s) => PastRecordsScreen(beetleId: s.pathParameters['id']!)),
                    ],
                  ),
                ],
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: AppRoutes.records,
                builder: (_, __) => const RecordsScreen(),
                routes: [
                  _modal('new', (s) => RecordFormScreen(
                        type: TimelineType.values.asNameMap()[s.uri.queryParameters['type']] ??
                            TimelineType.weight,
                        beetleId: s.uri.queryParameters['beetle'],
                      )),
                ],
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.assistant, builder: (_, __) => const AssistantScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: AppRoutes.reminders,
                builder: (_, __) => const RemindersScreen(),
                routes: [
                  _modal('new', (s) => ReminderFormScreen(beetleId: s.uri.queryParameters['beetle'])),
                ],
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.analytics, builder: (_, __) => const AnalyticsScreen()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (_, __) => const SettingsScreen(),
                routes: [
                  GoRoute(path: 'ai', builder: (_, __) => const AiSettingsScreen()),
                  GoRoute(path: 'on-device', builder: (_, __) => const OnDeviceAiScreen()),
                  GoRoute(path: 'rules', builder: (_, __) => const CareRulesScreen()),
                  GoRoute(path: 'species', builder: (_, __) => const SpeciesScreen()),
                  GoRoute(path: 'sensors', builder: (_, __) => const SensorsScreen()),
                  GoRoute(path: 'backup', builder: (_, __) => const BackupScreen()),
                  GoRoute(path: 'memory', builder: (_, __) => const AiMemoryScreen()),
                  GoRoute(path: 'suppressions', builder: (_, __) => const SuppressionsScreen()),
                ],
              ),
            ]),
          ],
        ),
      ],
    );
