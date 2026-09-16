import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';

enum _AdminNotifType { newBooking, technicianAssigned, serviceCompleted }

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({super.key});

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  int _tab = 0;

  // TODO: replace with data pushed from your admin notification service.
  List<_AdminNotification> _notifications(AppLocalizations l10n) => [
        _AdminNotification(
          type: _AdminNotifType.newBooking,
          title: l10n.newBookingRequestTitle,
          message: l10n.adminNotifNewBookingMsg,
          timeAgo: 'Just now',
          unread: true,
        ),
        _AdminNotification(
          type: _AdminNotifType.technicianAssigned,
          title: l10n.technicianAssignedLabel,
          message: l10n.adminNotifTechAssignedMsg,
          timeAgo: '10 min ago',
        ),
        _AdminNotification(
          type: _AdminNotifType.serviceCompleted,
          title: l10n.serviceCompletedTitle,
          message: l10n.adminNotifServiceCompletedMsg,
          timeAgo: '1 hour ago',
        ),
        _AdminNotification(
          type: _AdminNotifType.newBooking,
          title: l10n.newBookingRequestTitle,
          message: l10n.adminNotifNewBookingMsg,
          timeAgo: 'Just now',
          unread: true,
        ),
        _AdminNotification(
          type: _AdminNotifType.serviceCompleted,
          title: l10n.serviceCompletedTitle,
          message: l10n.adminNotifServiceCompletedMsg,
          timeAgo: '1 hour ago',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final notifications = _notifications(l10n);
    final filtered = switch (_tab) {
      1 => notifications.where((n) => n.unread).toList(),
      2 => notifications
          .where((n) => n.type == _AdminNotifType.newBooking)
          .toList(),
      _ => notifications,
    };

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
                  label: l10n.filterAll, selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
              const SizedBox(width: 10),
              _FilterTab(
                  label: l10n.filterUnread, selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
              const SizedBox(width: 10),
              _FilterTab(
                  label: l10n.filterImportant, selected: _tab == 2, onTap: () => setState(() => _tab = 2)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            itemCount: filtered.length,
            itemBuilder: (context, index) =>
                _AdminNotificationTile(notification: filtered[index]),
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
                color: selected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13)),
      ),
    );
  }
}

class _AdminNotificationTile extends StatelessWidget {
  final _AdminNotification notification;

  const _AdminNotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(notification.type);

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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: style.background, borderRadius: BorderRadius.circular(12)),
            child: Icon(style.icon, color: style.color, size: 22),
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
              child: CircleAvatar(radius: 4, backgroundColor: Color(0xFFE2711D)),
            ),
        ],
      ),
    );
  }

  _NotifStyle _styleFor(_AdminNotifType type) {
    switch (type) {
      case _AdminNotifType.newBooking:
        return const _NotifStyle(
          icon: Icons.event_note_rounded,
          color: Color(0xFFE2711D),
          background: Color(0xFFFDEBD9),
        );
      case _AdminNotifType.technicianAssigned:
        return const _NotifStyle(
          icon: Icons.engineering_rounded,
          color: Color(0xFF1E9E5C),
          background: Color(0xFFE1F5EA),
        );
      case _AdminNotifType.serviceCompleted:
        return const _NotifStyle(
          icon: Icons.check_circle_rounded,
          color: Color(0xFF1E9E5C),
          background: Color(0xFFE1F5EA),
        );
    }
  }
}

class _NotifStyle {
  final IconData icon;
  final Color color;
  final Color background;

  const _NotifStyle(
      {required this.icon, required this.color, required this.background});
}

class _AdminNotification {
  final _AdminNotifType type;
  final String title;
  final String message;
  final String timeAgo;
  final bool unread;

  const _AdminNotification({
    required this.type,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.unread = false,
  });
}
