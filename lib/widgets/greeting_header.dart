import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../l10n/app_localizations.dart';

/// Shared "location + greeting + avatar" banner used atop each role's home tab.
class GreetingHeader extends StatelessWidget {
  final String name;
  final String subtitle;
  final String avatarAsset;
  final VoidCallback? onNotifications;
  final int? notificationCount;

  const GreetingHeader({
    super.key,
    required this.name,
    required this.subtitle,
    this.avatarAsset = AppAssets.profileClient,
    this.onNotifications,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    final headerHeight =
        (MediaQuery.sizeOf(context).width * .32).clamp(110.0, 150.0);
    final avatarSize = headerHeight * .52;

    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A0B5FA8), blurRadius: 16, offset: Offset(0, 8)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.infoBanner, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 25, color: AppColors.textPrimary),
                    const SizedBox(width: 7),
                    const Expanded(
                      child: Text('Preysor, Phnom Penh',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          )),
                    ),
                    if (onNotifications != null)
                      IconButton(
                        onPressed: onNotifications,
                        tooltip: AppLocalizations.of(context)!.notificationsTooltip,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(
                            width: 36, height: 36),
                        icon: Stack(clipBehavior: Clip.none, children: [
                          const Icon(Icons.notifications_none_rounded,
                              size: 27, color: AppColors.textPrimary),
                          if (notificationCount != null)
                            Positioned(
                              right: -3,
                              top: -4,
                              child: Container(
                                width: 15,
                                height: 15,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.danger,
                                  shape: BoxShape.circle,
                                ),
                                child: Text('$notificationCount',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                        ]),
                      ),
                  ]),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 86),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(height: 1),
                            Text(subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 18,
              bottom: 10,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(avatarAsset, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
