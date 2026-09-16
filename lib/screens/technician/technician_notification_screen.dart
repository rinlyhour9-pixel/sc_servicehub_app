import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';

class TechnicianNotificationScreen extends StatefulWidget {
  const TechnicianNotificationScreen({super.key});

  @override
  State<TechnicianNotificationScreen> createState() =>
      _TechnicianNotificationScreenState();
}

class _TechnicianNotificationScreenState
    extends State<TechnicianNotificationScreen> {
  bool _unreadOnly = false;

  // TODO: replace with data pushed from your technician notification service.
  List<_TechnicianNotification> _notifications(AppLocalizations l10n) => [
        _TechnicianNotification(
          icon: Icons.notifications_none_rounded,
          title: l10n.reminderTitle,
          message: l10n.jobTomorrowMsg,
          timeAgo: 'Just Now',
        ),
        _TechnicianNotification(
          icon: Icons.calendar_month_rounded,
          title: l10n.newJobAssignedTitle,
          message: l10n.newJobAssignedMsg,
          timeAgo: '10:30 AM',
          unread: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final notifications = _notifications(l10n);
    final filtered =
        _unreadOnly ? notifications.where((n) => n.unread).toList() : notifications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          color: AppColors.primary,
          child: Text(l10n.notificationHeaderTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              _FilterTab(
                  label: l10n.filterAll,
                  selected: !_unreadOnly,
                  onTap: () => setState(() => _unreadOnly = false)),
              const SizedBox(width: 10),
              _FilterTab(
                  label: l10n.filterUnread,
                  selected: _unreadOnly,
                  onTap: () => setState(() => _unreadOnly = true)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            itemCount: filtered.length,
            itemBuilder: (context, index) =>
                _TechnicianNotificationTile(notification: filtered[index]),
          ),
        ),
      ],
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterTab(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13)),
      ),
    );
  }
}

class _TechnicianNotificationTile extends StatelessWidget {
  final _TechnicianNotification notification;

  const _TechnicianNotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    final accent =
        notification.unread ? AppColors.primary : AppColors.textSecondary;
    final iconBg =
        notification.unread ? AppColors.tileBackground : const Color(0xFFF0F1F3);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
            left: BorderSide(color: AppColors.primary, width: 6)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(notification.icon, color: accent, size: 20),
          ),
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
                Text(notification.timeAgo,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          if (notification.unread)
            const Padding(
              padding: EdgeInsets.only(left: 6, top: 2),
              child: CircleAvatar(radius: 4, backgroundColor: AppColors.primary),
            ),
        ],
      ),
    );
  }
}

class _TechnicianNotification {
  final IconData icon;
  final String title;
  final String message;
  final String timeAgo;
  final bool unread;

  const _TechnicianNotification({
    required this.icon,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.unread = false,
  });
}
