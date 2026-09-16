import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_colors.dart';
import '../../data/admin_booking_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/admin_booking_entry.dart';
import 'admin_track_booking_screen.dart';

class AdminTodayScheduleScreen extends StatefulWidget {
  const AdminTodayScheduleScreen({super.key});

  @override
  State<AdminTodayScheduleScreen> createState() => _AdminTodayScheduleScreenState();
}

class _AdminTodayScheduleScreenState extends State<AdminTodayScheduleScreen> {
  AdminBookingStage? _filter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final todayLabel = DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.todaysScheduleTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: AdminBookingStore.instance,
        builder: (context, _) {
          final schedule = AdminBookingStore.instance.bookings;
          final filtered =
              _filter == null ? schedule : schedule.where((s) => s.stage == _filter).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(todayLabel,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    Text(l10n.jobsCountSuffix(schedule.length),
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: Row(
                  children: [
                    _FilterTab(
                        label: l10n.filterAll,
                        selected: _filter == null,
                        onTap: () => setState(() => _filter = null)),
                    const SizedBox(width: 8),
                    _FilterTab(
                        label: l10n.statusPending,
                        selected: _filter == AdminBookingStage.pending,
                        onTap: () => setState(() => _filter = AdminBookingStage.pending)),
                    const SizedBox(width: 8),
                    _FilterTab(
                        label: l10n.statusInProgress,
                        selected: _filter == AdminBookingStage.inProgress,
                        onTap: () => setState(() => _filter = AdminBookingStage.inProgress)),
                    const SizedBox(width: 8),
                    _FilterTab(
                        label: l10n.statusComplete,
                        selected: _filter == AdminBookingStage.complete,
                        onTap: () => setState(() => _filter = AdminBookingStage.complete)),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(l10n.noJobsForFilter,
                            style: const TextStyle(color: AppColors.textSecondary)))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) => _ScheduleTimelineTile(
                          entry: filtered[index],
                          isLast: index == filtered.length - 1,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScheduleTimelineTile extends StatelessWidget {
  final AdminBookingEntry entry;
  final bool isLast;

  const _ScheduleTimelineTile({required this.entry, required this.isLast});

  _StatusStyle _style(AppLocalizations l10n) {
    switch (entry.stage) {
      case AdminBookingStage.pending:
        return _StatusStyle(
            label: l10n.statusPending, color: const Color(0xFFE2711D), background: const Color(0xFFFDEBD9));
      case AdminBookingStage.inProgress:
        return _StatusStyle(
            label: l10n.statusInProgress, color: AppColors.primary, background: AppColors.tileBackground);
      case AdminBookingStage.complete:
        return _StatusStyle(
            label: l10n.statusComplete, color: AppColors.success, background: const Color(0xFFE1F5EA));
    }
  }

  /// The `dateTime` field is stored as "20 May 2026, 09:15 AM" — just show
  /// the time portion in the timeline's left column.
  String get _time {
    final parts = entry.dateTime.split(',');
    return parts.length > 1 ? parts.last.trim() : entry.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = _style(l10n);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 66,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(_time,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: style.color,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [BoxShadow(color: style.color.withValues(alpha: .35), blurRadius: 4)],
                ),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: Colors.grey.shade300)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminTrackBookingScreen(bookingId: entry.id),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(entry.service,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: style.background, borderRadius: BorderRadius.circular(20)),
                            child: Text(style.label,
                                style: TextStyle(
                                    color: style.color, fontSize: 11, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text('${entry.customer} • ${entry.id}',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            entry.technician != null
                                ? Icons.engineering_rounded
                                : Icons.person_off_outlined,
                            size: 15,
                            color: entry.technician != null
                                ? AppColors.primary
                                : const Color(0xFFE2711D),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            entry.technician?.name ?? l10n.statusUnassigned,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: entry.technician != null
                                  ? AppColors.textPrimary
                                  : const Color(0xFFE2711D),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusStyle {
  final String label;
  final Color color;
  final Color background;

  const _StatusStyle({required this.label, required this.color, required this.background});
}
