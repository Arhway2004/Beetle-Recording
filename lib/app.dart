import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'application/providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/gen/app_localizations.dart';

final routerProvider = Provider<GoRouter>((ref) => buildRouter());

class BeetleKeeperApp extends ConsumerStatefulWidget {
  const BeetleKeeperApp({super.key});

  @override
  ConsumerState<BeetleKeeperApp> createState() => _BeetleKeeperAppState();
}

class _BeetleKeeperAppState extends ConsumerState<BeetleKeeperApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// On resume: refresh the time zone, re-sync OS notifications, re-evaluate
  /// time-based care rules, and re-check AI connectivity.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the ~2 GB on-device model so iOS does not kill the app in the background.
      ref.read(onDeviceRuntimeProvider).unload().ignore();
      return;
    }
    if (state != AppLifecycleState.resumed) return;
    final gateway = ref.read(notificationGatewayProvider);
    gateway
        .refreshTimeZone()
        .then((_) => ref.read(reminderSchedulerProvider).reconcile())
        .then((_) => ref.read(proactiveCareProvider).evaluate())
        .catchError((Object e) {
      debugPrint('resume maintenance failed: $e');
      return 0;
    }).ignore();
    ref.invalidate(providerStatusesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(themeModeProvider),
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(routerProvider),
    );
  }
}
