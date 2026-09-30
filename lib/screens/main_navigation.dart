import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../state/client_booking_store.dart';
import '../widgets/app_bottom_nav.dart';
import 'home/home_screen.dart';
import 'booking/my_booking_screen.dart';
import 'notification/notification_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onLogout;

  const MainNavigation({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.onLogout,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _refreshBookings();
  }

  Future<void> _refreshBookings() async {
    ClientBookingStore.instance.clear();
    try {
      ClientBookingStore.instance
          .replaceWithApiBookings(await ApiService.instance.bookings());
    } on ApiException catch (error) {
      debugPrint('Could not load bookings: ${error.message}');
    }
  }

  void goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
          onSeeAllBookings: () => goToTab(1),
          onOpenNotifications: () => goToTab(2)),
      const MyBookingScreen(),
      NotificationScreen(onViewBookings: () => goToTab(1)),
      ProfileScreen(
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: screens)),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: goToTab,
        showChatDot: true,
      ),
    );
  }
}
