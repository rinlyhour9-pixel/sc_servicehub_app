import 'package:flutter/material.dart';
import '../core/app_colors.dart';

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
    const icons = [
      Icons.home_rounded,
      Icons.chat_bubble_outline_rounded,
      Icons.person_outline_rounded,
    ];

    return BottomAppBar(
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 72,
        child: Row(
          children: List.generate(icons.length, (index) {
            final selected = index == currentIndex;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icons[index],
                        size: 24,
                        color: selected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                    if (index == 1 && showChatDot)
                      Positioned(
                        top: 4,
                        right: 26,
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
