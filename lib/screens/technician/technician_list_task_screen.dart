import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/completed_job_record.dart';
import '../../models/technician_job.dart';
import 'technician_job_detail_screen.dart';
import 'technician_job_report_screen.dart';

enum _TaskFilter { all, assigned, completed }

class TechnicianListTaskScreen extends StatefulWidget {
  final List<TechnicianJob> assigned;
  final List<CompletedJobRecord> completed;
  final JobCompletionCallback onJobSubmitted;

  const TechnicianListTaskScreen({
    super.key,
    required this.assigned,
    required this.completed,
    required this.onJobSubmitted,
  });

  @override
  State<TechnicianListTaskScreen> createState() => _TechnicianListTaskScreenState();
}

class _TechnicianListTaskScreenState extends State<TechnicianListTaskScreen> {
  _TaskFilter _filter = _TaskFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final showAssigned = _filter != _TaskFilter.completed;
    final showCompleted = _filter != _TaskFilter.assigned;
    final total = widget.assigned.length + widget.completed.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.listTaskLabel,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Row(
              children: [
                _FilterTab(
                    label: l10n.allCountTemplate(total),
                    selected: _filter == _TaskFilter.all,
                    onTap: () => setState(() => _filter = _TaskFilter.all)),
                const SizedBox(width: 8),
                _FilterTab(
                    label: l10n.assignedCountTemplate(widget.assigned.length),
                    selected: _filter == _TaskFilter.assigned,
                    onTap: () => setState(() => _filter = _TaskFilter.assigned)),
                const SizedBox(width: 8),
                _FilterTab(
                    label: l10n.completedCountTemplate(widget.completed.length),
                    selected: _filter == _TaskFilter.completed,
                    onTap: () => setState(() => _filter = _TaskFilter.completed)),
              ],
            ),
          ),
          Expanded(
            child: total == 0
                ? Center(
                    child: Text(l10n.noTasksYet, style: const TextStyle(color: AppColors.textSecondary)))
                : ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    children: [
                      if (showAssigned)
                        for (final job in widget.assigned)
                          _TaskTile(
                            title: job.service,
                            subtitle: '${job.customerName} • ${job.bookingId}',
                            statusLabel: l10n.statusAssigned,
                            statusColor: AppColors.primary,
                            statusBackground: AppColors.tileBackground,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TechnicianJobDetailScreen(
                                  job: job,
                                  onSubmitted: (description, startedAt, endedAt) =>
                                      widget.onJobSubmitted(job, description, startedAt, endedAt),
                                ),
                              ),
                            ),
                          ),
                      if (showCompleted)
                        for (final record in widget.completed)
                          _TaskTile(
                            title: record.job.service,
                            subtitle: '${record.job.customerName} • ${record.job.bookingId}',
                            statusLabel: l10n.statusCompleted,
                            statusColor: AppColors.success,
                            statusBackground: const Color(0xFFE1F5EA),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TechnicianJobReportScreen(record: record),
                              ),
                            ),
                          ),
                    ],
                  ),
          ),
        ],
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String statusLabel;
  final Color statusColor;
  final Color statusBackground;
  final VoidCallback onTap;

  const _TaskTile({
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBackground,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration:
                    BoxDecoration(color: statusBackground, borderRadius: BorderRadius.circular(20)),
                child: Text(statusLabel,
                    style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
