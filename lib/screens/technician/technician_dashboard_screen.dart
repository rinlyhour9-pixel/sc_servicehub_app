import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/completed_job_record.dart';
import '../../models/technician_job.dart';
import '../../widgets/greeting_header.dart';
import 'technician_assigned_tasks_screen.dart';
import 'technician_completed_tasks_screen.dart';
import 'technician_job_detail_screen.dart';
import 'technician_list_task_screen.dart';

class TechnicianDashboardScreen extends StatefulWidget {
  final VoidCallback onOpenNotifications;

  const TechnicianDashboardScreen({super.key, required this.onOpenNotifications});

  @override
  State<TechnicianDashboardScreen> createState() => _TechnicianDashboardScreenState();
}

class _TechnicianDashboardScreenState extends State<TechnicianDashboardScreen> {
  List<_TaskShortcut> _todayTasks(AppLocalizations l10n) => [
        _TaskShortcut(iconAsset: 'assets/technician_icon/listtask_icon.png', label: l10n.listTaskLabel),
        _TaskShortcut(iconAsset: 'assets/technician_icon/assigned_icon.png', label: l10n.assignedAllCaps),
        _TaskShortcut(iconAsset: 'assets/technician_icon/completed_icon.png', label: l10n.completedAllCaps),
      ];

  // TODO: replace with data from your technician task API.
  final List<TechnicianJob> _assignedTasks = [
    const TechnicianJob(
      icon: Icons.ac_unit_rounded,
      bookingId: '#BK240521001',
      bookedOn: '20 May 2024, 09:15 AM',
      customerName: 'Jonh Smith',
      customerPhone: '081 755 432',
      service: 'AC Repair Service',
      scheduledDateTime: 'Tue, 21 May 2026, 10:00 AM',
      address: '#12, Street 123, Prey Sar, Phnom Penh, Cambodia',
      latitude: 11.5445,
      longitude: 104.8922,
      problemDescription:
          'AC not cooling well and making strange noise from the indoor blower unit.',
      photoCount: 4,
    ),
  ];

  final List<CompletedJobRecord> _completedRecords = [
    CompletedJobRecord(
      job: const TechnicianJob(
        icon: Icons.tv_rounded,
        bookingId: '#BK240520003',
        bookedOn: '15 May 2026, 11:00 AM',
        customerName: 'Mary Janeeeee',
        customerPhone: '012 456 789',
        service: 'TV Repair',
        scheduledDateTime: '15 May 2026, 11:00 AM',
        address: '#12, St. 310, Boeung Keng Kang, Phnom Penh',
        problemDescription: 'No display on power on.',
        photoCount: 2,
      ),
      workDescription:
          'Replaced faulty capacitor on the power board and tested display for 15 minutes.',
      startedAt: DateTime(2026, 5, 15, 11, 10),
      endedAt: DateTime(2026, 5, 15, 12, 5),
    ),
  ];

  void _handleSubmitted(
      TechnicianJob job, String workDescription, DateTime startedAt, DateTime endedAt) {
    setState(() {
      _assignedTasks.remove(job);
      _completedRecords.insert(
        0,
        CompletedJobRecord(
          job: job,
          workDescription: workDescription,
          startedAt: startedAt,
          endedAt: endedAt,
        ),
      );
    });
  }

  void _openJob(TechnicianJob job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TechnicianJobDetailScreen(
          job: job,
          onSubmitted: (description, startedAt, endedAt) =>
              _handleSubmitted(job, description, startedAt, endedAt),
        ),
      ),
    );
  }

  void _openListTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TechnicianListTaskScreen(
          assigned: _assignedTasks,
          completed: _completedRecords,
          onJobSubmitted: _handleSubmitted,
        ),
      ),
    );
  }

  void _openAssigned() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TechnicianAssignedTasksScreen(
          tasks: _assignedTasks,
          onJobSubmitted: _handleSubmitted,
        ),
      ),
    );
  }

  void _openCompleted() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TechnicianCompletedTasksScreen(records: _completedRecords),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final todayTasks = _todayTasks(l10n);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        GreetingHeader(
          name: l10n.roleTechnician,
          subtitle: l10n.technicianGreetingSubtitle,
          onNotifications: widget.onOpenNotifications,
        ),
        const SizedBox(height: 22),
        Text(l10n.todayTaskTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        Row(
          children: List.generate(todayTasks.length, (index) {
            final task = todayTasks[index];
            final onTap = switch (index) {
              0 => _openListTask,
              1 => _openAssigned,
              _ => _openCompleted,
            };
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    right: index == todayTasks.length - 1 ? 0 : 10),
                child: _TaskShortcutTile(data: task, onTap: onTap),
              ),
            );
          }),
        ),
        const SizedBox(height: 22),
        Text(l10n.taskAssignByAdminTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        if (_assignedTasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border)),
            child: Column(
              children: [
                const Icon(Icons.task_alt_rounded, size: 32, color: AppColors.textSecondary),
                const SizedBox(height: 8),
                Text(l10n.noTasksAssignedRightNow,
                    style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          )
        else
          for (final task in _assignedTasks)
            _AssignedTaskCard(job: task, onTakeTask: () => _openJob(task)),
      ],
    );
  }
}

class _TaskShortcutTile extends StatelessWidget {
  final _TaskShortcut data;
  final VoidCallback onTap;

  const _TaskShortcutTile({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.tileBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Column(
            children: [
              Image.asset(data.iconAsset, width: 34, height: 34),
              const SizedBox(height: 10),
              Text(data.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssignedTaskCard extends StatelessWidget {
  final TechnicianJob job;
  final VoidCallback onTakeTask;

  const _AssignedTaskCard({required this.job, required this.onTakeTask});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.tileBackground,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(job.icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.service,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text('${job.customerName} • ${job.bookingId}',
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(job.address,
                    style: const TextStyle(fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onTakeTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l10n.takeTask,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskShortcut {
  final String iconAsset;
  final String label;

  const _TaskShortcut({required this.iconAsset, required this.label});
}
