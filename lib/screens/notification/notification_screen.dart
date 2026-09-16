import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  final VoidCallback onViewBookings;

  const NotificationScreen({super.key, required this.onViewBookings});

  // TODO: replace with data pushed from your booking/notification service.
  Map<String, List<AppNotification>> _grouped(AppLocalizations l10n) => {
        l10n.todayLabel: [
          AppNotification(
            id: '1',
            type: NotificationType.technicianAssigned,
            title: l10n.technicianAssignedLabel,
            message: l10n.notifTechnicianAssignedMsg,
            timeAgo: '5 min ago',
            date: DateTime.now(),
            relatedBookingId: 'BK-250505',
          ),
          AppNotification(
            id: '2',
            type: NotificationType.technicianArrived,
            title: l10n.notifTechnicianArrivedTitle,
            message: l10n.notifTechnicianArrivedMsg,
            timeAgo: '2 min ago',
            date: DateTime.now(),
            relatedBookingId: 'BK-250505',
          ),
        ],
        l10n.yesterdayLabel: [
          AppNotification(
            id: '3',
            type: NotificationType.serviceComplete,
            title: l10n.serviceCompleteStep,
            message: l10n.notifServiceCompleteMsg,
            timeAgo: 'Yesterday',
            date: DateTime.now().subtract(const Duration(days: 1)),
            relatedBookingId: 'BK-250401',
          ),
        ],
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final grouped = _grouped(l10n);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.notificationHeaderTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              Text(l10n.notificationSubtitle,
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: grouped.entries.expand((entry) sync* {
              yield Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 6),
                child: Text(entry.key,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              );
              for (final n in entry.value) {
                yield _NotificationTile(
                    notification: n, onViewBooking: onViewBookings);
              }
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onViewBooking;

  const _NotificationTile(
      {required this.notification, required this.onViewBooking});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            const Border(left: BorderSide(color: AppColors.primary, width: 6)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.tileBackground,
              child: Icon(Icons.headset_mic_outlined,
                  color: AppColors.primary, size: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(notification.message,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(notification.timeAgo,
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 11)),
                    const Spacer(),
                    if (notification.relatedBookingId != null)
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.pendingBg,
                          foregroundColor: AppColors.pendingText,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        ),
                        onPressed: onViewBooking,
                        child: Text(l10n.viewBookingButton,
                            style: const TextStyle(fontSize: 12)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
