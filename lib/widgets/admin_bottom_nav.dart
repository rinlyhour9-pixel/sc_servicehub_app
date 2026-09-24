import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../l10n/app_localizations.dart';

/// Minimal 3-tab bottom bar for the admin shell (Dashboard, Chat, Profile).
class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showChatDot;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showChatDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const icons = [
      Icons.home_rounded,
      Icons.chat_bubble_outline_rounded,
      Icons.person_outline_rounded,
    ];
    final labels = [l10n.navHome, l10n.navUpdates, l10n.navProfile];

    return BottomAppBar(
      color: Colors.white,
      padding: EdgeInsets.zero,
      elevation: 8,
      surfaceTintColor: Colors.white,
      child: SizedBox(
        height: 76,
        child: Row(
          children: List.generate(icons.length, (index) {
            final selected = index == currentIndex;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 42,
                          height: 38,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(
                            icons[index],
                            size: 22,
                            color: selected ? Colors.white : AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    if (index == 1 && showChatDot)
                      Positioned(
                        top: 10,
                        right: 34,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                              color: AppColors.danger, shape: BoxShape.circle),
                        ),
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
