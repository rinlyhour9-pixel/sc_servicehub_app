import 'package:flutter/material.dart';

import '../../widgets/admin_bottom_nav.dart';
import '../profile/profile_screen.dart';
import 'technician_dashboard_screen.dart';
import 'technician_notification_screen.dart';

class TechnicianNavigation extends StatefulWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onLogout;

  const TechnicianNavigation({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.onLogout,
  });

  @override
  State<TechnicianNavigation> createState() => _TechnicianNavigationState();
}

class _TechnicianNavigationState extends State<TechnicianNavigation> {
  int _index = 0;

  void goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      TechnicianDashboardScreen(onOpenNotifications: () => goToTab(1)),
      const TechnicianNotificationScreen(),
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
