import 'package:flutter/material.dart';

import '../../widgets/admin_bottom_nav.dart';
import '../profile/profile_screen.dart';
import 'admin_dashboard_screen.dart';
import 'admin_notification_screen.dart';

class AdminNavigation extends StatefulWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onLogout;

  const AdminNavigation({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.onLogout,
  });

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  int _index = 0;

  void goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      AdminDashboardScreen(onOpenNotifications: () => goToTab(1)),
      const AdminNotificationScreen(),
      ProfileScreen(
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: screens)),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _index,
        onTap: goToTab,
        showChatDot: true,
      ),
    );
  }
}
