import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/labels.dart';
import '../common/widgets.dart';

/// Key of the phone-layout scaffold that owns the navigation drawer.
final shellScaffoldKey = GlobalKey<ScaffoldState>();

/// App bar for top-level pages: adds a drawer button on phones.
PreferredSizeWidget topLevelAppBar(BuildContext context, String title, {List<Widget>? actions, PreferredSizeWidget? bottom}) {
  final wide = MediaQuery.sizeOf(context).width >= 720;
  return AppBar(
    title: Text(title),
    leading: wide
        ? null
        : IconButton(
            icon: const Icon(Icons.menu),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            onPressed: () => shellScaffoldKey.currentState?.openDrawer(),
          ),
    actions: actions,
    bottom: bottom,
  );
}

class _Dest {
  const _Dest(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Responsive navigation: all seven destinations in a rail on wide screens;
/// on phones the five most-used are in the bottom bar and every destination is
/// in the drawer.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  static const bottomBarCount = 5;

  static List<_Dest> _destinations(BuildContext context) {
    final l = context.l10n;
    return [
      _Dest(Icons.space_dashboard_outlined, Icons.space_dashboard, l.navDashboard),
      _Dest(Icons.bug_report_outlined, Icons.bug_report, l.navBeetles),
      _Dest(Icons.timeline_outlined, Icons.timeline, l.navRecords),
      _Dest(Icons.auto_awesome_outlined, Icons.auto_awesome, l.navAssistant),
      _Dest(Icons.notifications_none, Icons.notifications, l.navReminders),
      _Dest(Icons.insights_outlined, Icons.insights, l.navAnalytics),
      _Dest(Icons.settings_outlined, Icons.settings, l.navSettings),
    ];
  }

  void _go(int index) => shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final dests = _destinations(context);
    final wide = MediaQuery.sizeOf(context).width >= 720;
    if (wide) {
      return Scaffold(
        body: Row(children: [
          NavigationRail(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: _go,
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final d in dests)
                NavigationRailDestination(
                    icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: Text(d.label)),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: shell),
        ]),
      );
    }
    // Analytics and Settings live outside the bottom bar. NavigationBar always
    // has a selected index, so when one of them is open every bar destination
    // is drawn in its unselected style instead of highlighting Dashboard.
    final inBar = shell.currentIndex < bottomBarCount;
    final idle = Theme.of(context).colorScheme.onSurfaceVariant;
    return Scaffold(
      key: shellScaffoldKey,
      body: shell,
      drawer: NavigationDrawer(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) {
          Navigator.of(context).pop();
          _go(i);
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 12),
            child: Row(children: [
              const AppLogo(size: 36),
              const SizedBox(width: 12),
              Text(context.l10n.appTitle, style: Theme.of(context).textTheme.titleMedium),
            ]),
          ),
          for (final d in dests)
            NavigationDrawerDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: Text(d.label)),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: inBar ? shell.currentIndex : 0,
        indicatorColor: inBar ? null : Colors.transparent,
        labelTextStyle: inBar
            ? null
            : WidgetStatePropertyAll(Theme.of(context).textTheme.labelMedium?.copyWith(color: idle)),
        onDestinationSelected: _go,
        destinations: [
          for (final d in dests.take(bottomBarCount))
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: inBar ? Icon(d.selectedIcon) : Icon(d.icon, color: idle),
              label: d.label,
            ),
        ],
      ),
    );
  }
}
