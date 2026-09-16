import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/technician_job.dart';
import 'technician_job_in_progress_screen.dart';

Future<void> _openJobLocation(BuildContext context, TechnicianJob job) async {
  final l10n = AppLocalizations.of(context)!;
  final hasPin = job.latitude != null && job.longitude != null;
  final mapUrl = hasPin
      ? Uri.https('www.google.com', '/maps/search/', {
          'api': '1',
          'query': '${job.latitude},${job.longitude}',
        })
      : Uri.https('www.google.com', '/maps/search/', {
          'api': '1',
          'query': job.address,
        });
  final opened = await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.unableOpenMap)),
    );
  }
}

class TechnicianJobDetailScreen extends StatelessWidget {
  final TechnicianJob job;
  final JobSubmitCallback onSubmitted;

  const TechnicianJobDetailScreen({
    super.key,
    required this.job,
    required this.onSubmitted,
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
        title: Text(l10n.jobDetailTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                      Text(l10n.bookingIdAllCaps,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                      const SizedBox(height: 4),
                      Text(job.bookingId,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(l10n.bookedOnPrefix(job.bookedOn),
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Text(l10n.statusAssigned,
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.customerName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 2),
                          Text(job.customerPhone,
                              style: const TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    _CircleIconButton(icon: Icons.call_rounded, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                _SectionLabel(l10n.serviceInformationLabel),
                const SizedBox(height: 14),
                _InfoRow(label: l10n.labelService, value: job.service),
                const SizedBox(height: 12),
                _InfoRow(label: l10n.dateTimeLabel, value: job.scheduledDateTime),
                const SizedBox(height: 12),
                _InfoRow(label: l10n.labelAddress, value: job.address),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => _openJobLocation(context, job),
                    icon: const Icon(Icons.map_outlined, size: 18),
                    label: Text(l10n.viewLocationButton),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 20),
                _SectionLabel(l10n.problemDescriptionLabel),
                const SizedBox(height: 10),
                Text(job.problemDescription,
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                _SectionLabel(l10n.customerPhotosLabel),
                const SizedBox(height: 12),
                _PhotoRow(count: job.photoCount),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TechnicianJobInProgressScreen(
                          job: job,
                          onSubmitted: onSubmitted,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(l10n.startJobButton,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.tileBackground,
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}

class _PhotoRow extends StatelessWidget {
  final int count;
  const _PhotoRow({required this.count});

  @override
  Widget build(BuildContext context) {
    const maxShown = 3;
    final shown = count < maxShown ? count : maxShown;
    final more = count - shown;

    return Row(
      children: [
        for (var i = 0; i < shown; i++) ...[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.tileBackground, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.ac_unit_rounded, color: AppColors.primary),
              ),
            ),
          ),
          if (i != shown - 1 || more > 0) const SizedBox(width: 10),
        ],
        if (more > 0)
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.border, borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text('+$more',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: AppColors.textSecondary))),
              ),
            ),
          ),
      ],
    );
  }
}
