import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/completed_job_record.dart';

/// Read-only recap of a job the technician already submitted a report for.
class TechnicianJobReportScreen extends StatelessWidget {
  final CompletedJobRecord record;

  const TechnicianJobReportScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final job = record.job;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.jobReportTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.share_rounded, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.bookingId,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(job.service, style: const TextStyle(color: Colors.white, fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(l10n.completedOnPrefix(record.completedOnLabel),
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Text(l10n.statusCompleted,
                      style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(l10n.customerInformationLabel),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const ClipOval(
                      child: Image(
                        image: AssetImage(AppAssets.profileClient),
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.customerName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(job.customerPhone,
                              style: const TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                _SectionLabel(l10n.workDescriptionLabel),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border)),
                  child: Text(
                    record.workDescription.trim().isEmpty
                        ? l10n.noWorkDescriptionProvided
                        : record.workDescription,
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                _SectionLabel(l10n.workDurationLabel),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _DurationColumn(label: l10n.startTimeLabel, value: record.startLabel)),
                    Expanded(child: _DurationColumn(label: l10n.endTimeLabel, value: record.endLabel)),
                    Expanded(
                      child: _DurationColumn(
                          label: l10n.totalLabel, value: record.durationLabel, valueColor: AppColors.primary),
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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: .4,
            color: AppColors.textPrimary));
  }
}

class _DurationColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DurationColumn({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: valueColor ?? AppColors.textPrimary)),
      ],
    );
  }
}
