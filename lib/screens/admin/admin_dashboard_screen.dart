import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/status_labels.dart';
import '../../data/admin_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/admin_booking_entry.dart';
import '../../models/technician_profile.dart';
import '../../widgets/greeting_header.dart';
import 'admin_booking_list_screen.dart';
import 'admin_customer_list_screen.dart';
import 'admin_technician_list_screen.dart';
import 'admin_today_schedule_screen.dart';
import 'admin_track_booking_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final VoidCallback onOpenNotifications;

  const AdminDashboardScreen({super.key, required this.onOpenNotifications});

  List<_StatData> _stats(AppLocalizations l10n) {
    final store = AdminBookingStore.instance;
    return [
      _StatData(
        iconAsset: 'assets/admin_icon/totalbooking_icon.png',
        color: AppColors.primary,
        label: l10n.totalBookingTitle,
        value: '${store.bookings.length}',
        subtitle: l10n.thisMonth,
      ),
      _StatData(
        iconAsset: 'assets/admin_icon/pending_icon.png',
        color: const Color(0xFF2F6FE0),
        label: l10n.statusPending,
        value: '${store.countByStage(AdminBookingStage.pending)}',
        subtitle: l10n.needAction,
      ),
      _StatData(
        iconAsset: 'assets/admin_icon/inprogress_icon.png',
        color: const Color(0xFF1E9BD7),
        label: l10n.statusInProgress,
        value: '${store.countByStage(AdminBookingStage.inProgress)}',
        subtitle: l10n.ongoing,
      ),
      _StatData(
        iconAsset: 'assets/admin_icon/complete_icon.png',
        color: const Color(0xFF1E9BD7),
        label: l10n.statusComplete,
        value: '${store.countByStage(AdminBookingStage.complete)}',
        subtitle: l10n.thisMonth,
      ),
      _StatData(
        iconAsset: 'assets/admin_icon/listcustomer_icon.png',
        color: AppColors.primary,
        label: l10n.listCustomerLabel,
        value: '${store.customerCount}',
        subtitle: l10n.invoiceLabel,
      ),
      _StatData(
        iconAsset: 'assets/admin_icon/listtechnician_icon.png',
        color: AppColors.primary,
        label: l10n.listTechnicianLabel,
        value: '${TechnicianProfile.demoDirectory.length}',
        subtitle: l10n.personLabel,
      ),
    ];
  }

  List<_ActivityData> _recentActivity(AppLocalizations l10n) => [
        _ActivityData(
          icon: Icons.event_note_rounded,
          color: const Color(0xFFE2711D),
          background: const Color(0xFFFDEBD9),
          title: l10n.newBookingRequestTitle,
          message: l10n.newBookingRequestMsg,
          timeAgo: 'Just now',
        ),
        _ActivityData(
          icon: Icons.engineering_rounded,
          color: AppColors.success,
          background: const Color(0xFFE1F5EA),
          title: l10n.technicianAssignedLabel,
          message: l10n.technicianAssignedActivityMsg,
          timeAgo: '10 min ago',
        ),
        _ActivityData(
          icon: Icons.check_circle_rounded,
          color: AppColors.success,
          background: const Color(0xFFE1F5EA),
          title: l10n.serviceCompletedTitle,
          message: l10n.serviceCompletedMsg,
          timeAgo: '1 hour ago',
        ),
      ];

  void _openStat(BuildContext context, int index) {
    final Widget destination = switch (index) {
      1 => const AdminBookingListScreen(initialFilter: AdminBookingStage.pending),
      2 => const AdminBookingListScreen(initialFilter: AdminBookingStage.inProgress),
      3 => const AdminBookingListScreen(initialFilter: AdminBookingStage.complete),
      4 => const AdminCustomerListScreen(),
      5 => const AdminTechnicianListScreen(),
      _ => const AdminBookingListScreen(),
    };
    Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AdminBookingStore.instance,
      builder: (context, _) {
        final l10n = AppLocalizations.of(context)!;
        final stats = _stats(l10n);
        final recentActivity = _recentActivity(l10n);
        final schedule = AdminBookingStore.instance.bookings.take(3).toList();
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          children: [
            GreetingHeader(
              name: l10n.roleAdmin,
              subtitle: l10n.adminGreetingSubtitle,
              onNotifications: onOpenNotifications,
            ),
            const SizedBox(height: 22),
            Text(l10n.adminDashboardTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 116,
              ),
              itemBuilder: (context, index) => _StatCard(
                data: stats[index],
                onTap: () => _openStat(context, index),
              ),
            ),
            const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Text(l10n.todaysScheduleTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminTodayScheduleScreen()),
              ),
              child: Text(l10n.viewAll),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: schedule.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(l10n.noJobsScheduled,
                      style: const TextStyle(color: AppColors.textSecondary)),
                )
              : Column(
                  children: List.generate(schedule.length * 2 - 1, (index) {
                    if (index.isOdd) return const Divider(height: 1);
                    return _ScheduleRow(entry: schedule[index ~/ 2]);
                  }),
                ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Text(l10n.recentActivityTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            TextButton(
              onPressed: onOpenNotifications,
              child: Text(l10n.viewAll),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Column(
            children: List.generate(recentActivity.length * 2 - 1, (index) {
              if (index.isOdd) return const Divider(height: 1);
              return _ActivityRow(data: recentActivity[index ~/ 2]);
            }),
          ),
        ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  final VoidCallback? onTap;

  const _StatCard({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: data.color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(data.iconAsset, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(data.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text(data.value,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: data.color)),
                      const SizedBox(height: 1),
                      Text(data.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final _ActivityData data;

  const _ActivityRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration:
                BoxDecoration(color: data.background, borderRadius: BorderRadius.circular(10)),
            child: Icon(data.icon, size: 18, color: data.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 2),
                Text(data.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(data.timeAgo,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final AdminBookingEntry entry;

  const _ScheduleRow({required this.entry});

  /// The `dateTime` field is stored as "20 May 2026, 09:15 AM" — just show
  /// the time portion in this compact row.
  String get _time {
    final parts = entry.dateTime.split(',');
    return parts.length > 1 ? parts.last.trim() : entry.dateTime;
  }

  (Color, Color) get _statusColors => switch (entry.stage) {
        AdminBookingStage.pending => (const Color(0xFFFDEBD9), const Color(0xFFE2711D)),
        AdminBookingStage.inProgress => (AppColors.pendingBg, AppColors.pendingText),
        AdminBookingStage.complete => (const Color(0xFFE1F5EA), AppColors.success),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (background, textColor) = _statusColors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AdminTrackBookingScreen(bookingId: entry.id)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 62,
                child: Text(_time,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.service,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(entry.customer,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 74,
                child: Text(entry.id,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: background, borderRadius: BorderRadius.circular(20)),
                child: Text(adminStageLabel(l10n, entry.stage),
                    style: TextStyle(
                        color: textColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityData {
  final IconData icon;
  final Color color;
  final Color background;
  final String title;
  final String message;
  final String timeAgo;

  const _ActivityData({
    required this.icon,
    required this.color,
    required this.background,
    required this.title,
    required this.message,
    required this.timeAgo,
  });
}

class _StatData {
  final String iconAsset;
  final Color color;
  final String label;
  final String value;
  final String subtitle;

  const _StatData({
    required this.iconAsset,
    required this.color,
    required this.label,
    required this.value,
    required this.subtitle,
  });
}
