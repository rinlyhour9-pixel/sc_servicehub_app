import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../l10n/app_localizations.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showBookingDot;
  final bool showChatDot;
  final bool showProfileDot;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showBookingDot = false,
    this.showChatDot = false,
    this.showProfileDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      _NavItem(Icons.home_rounded, l10n.navHome),
      _NavItem(Icons.work_outline_rounded, l10n.navBooking, dot: showBookingDot),
      _NavItem(Icons.notifications_none_rounded, l10n.navUpdates, dot: showChatDot),
      _NavItem(Icons.person_outline_rounded, l10n.navProfile, dot: showProfileDot),
    ];

    return BottomAppBar(
      color: Colors.white,
      padding: EdgeInsets.zero,
      elevation: 8,
      surfaceTintColor: Colors.white,
      child: SizedBox(
        height: 76,
        child: Row(
          children: List.generate(items.length, (index) {
            final selected = index == currentIndex;
            final item = items[index];
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            item.icon,
                            color: selected ? Colors.white : AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(item.label, style: TextStyle(fontSize: 11, fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: selected ? AppColors.primary : AppColors.textSecondary)),
                      ],
                    ),
                    if (item.dot)
                      const Positioned(
                        top: 12,
                        right: 28,
                        child: CircleAvatar(radius: 4, backgroundColor: AppColors.danger),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool dot;
  _NavItem(this.icon, this.label, {this.dot = false});
}
