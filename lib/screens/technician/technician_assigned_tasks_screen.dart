import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/technician_job.dart';
import 'technician_job_detail_screen.dart';

class TechnicianAssignedTasksScreen extends StatelessWidget {
  final List<TechnicianJob> tasks;
  final JobCompletionCallback onJobSubmitted;

  const TechnicianAssignedTasksScreen({
    super.key,
    required this.tasks,
    required this.onJobSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.assignedTasksTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: tasks.isEmpty
          ? _EmptyState(
              icon: Icons.assignment_turned_in_rounded,
              message: l10n.noTasksAssignedRightNow)
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              itemCount: tasks.length,
              itemBuilder: (context, index) => _AssignedTaskCard(
                job: tasks[index],
                onTakeTask: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TechnicianJobDetailScreen(
                      job: tasks[index],
                      onSubmitted: (description, startedAt, endedAt) =>
                          onJobSubmitted(tasks[index], description, startedAt, endedAt),
                    ),
                  ),
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
                    color: AppColors.tileBackground, borderRadius: BorderRadius.circular(10)),
                child: Icon(job.icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.service,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text('${job.customerName} • ${job.bookingId}',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(child: Text(job.address, style: const TextStyle(fontSize: 13))),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l10n.takeTask,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: AppColors.textSecondary),
          const SizedBox(height: 10),
          Text(message, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
