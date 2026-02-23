import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'tabs/dashboard_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/notifications_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const _tabs = [
    _TabItem(
      key: Key('dashboardTab'),
      icon: LucideIcons.layoutDashboard,
      label: 'Dashboard',
    ),
    _TabItem(
      key: Key('exploreTab'),
      icon: LucideIcons.compass,
      label: 'Explore',
    ),
    _TabItem(
      key: Key('notificationsTab'),
      icon: LucideIcons.bell,
      label: 'Alerts',
    ),
    _TabItem(
      key: Key('profileTab'),
      icon: LucideIcons.user,
      label: 'Profile',
    ),
  ];

  static const _screens = [
    DashboardTab(),
    ExploreTab(),
    NotificationsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.border,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          key: const Key('bottomNavBar'),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => _selectedIndex = index),
          backgroundColor: isDark
              ? theme.colorScheme.card
              : theme.colorScheme.background,
          indicatorColor: theme.colorScheme.primary.withValues(alpha: 0.15),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: _tabs
              .map(
                (tab) => NavigationDestination(
                  key: tab.key,
                  icon: Icon(tab.icon, size: 22),
                  selectedIcon: Icon(
                    tab.icon,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                  label: tab.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _TabItem {
  final Key key;
  final IconData icon;
  final String label;

  const _TabItem({
    required this.key,
    required this.icon,
    required this.label,
  });
}
