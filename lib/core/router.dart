import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/budgets/budgets_screen.dart';
import '../features/habits/habits_screen.dart';
import '../features/money/money_screen.dart';
import '../features/settings/settings_screen.dart';

class _Shell extends StatelessWidget {
  const _Shell(this.shell);
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: shell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: (i) =>
              shell.goBranch(i, initialLocation: i == shell.currentIndex),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.check_circle_outline), label: 'Habits'),
            NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Money'),
            NavigationDestination(icon: Icon(Icons.pie_chart_outline), label: 'Budgets'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      );
}

GoRoute _route(String path, Widget screen) =>
    GoRoute(path: path, builder: (_, _) => screen);

final router = GoRouter(
  initialLocation: '/habits',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, shell) => _Shell(shell),
      branches: [
        StatefulShellBranch(routes: [_route('/habits', const HabitsScreen())]),
        StatefulShellBranch(routes: [_route('/money', const MoneyScreen())]),
        StatefulShellBranch(routes: [_route('/budgets', const BudgetsScreen())]),
        StatefulShellBranch(routes: [_route('/settings', const SettingsScreen())]),
      ],
    ),
  ],
);
