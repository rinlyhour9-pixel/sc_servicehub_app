import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/technician_profile.dart';

class AdminTechnicianProfileScreen extends StatelessWidget {
  final TechnicianProfile data;

  const AdminTechnicianProfileScreen({super.key, required this.data});

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
        title: Text(l10n.technicianProfileTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ClipOval(
                      child: Image(
                        image: AssetImage(AppAssets.profileClient),
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(data.name,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                              if (data.topPro)
                                Row(
                                  children: [
                                    const Icon(Icons.workspace_premium_rounded, size: 16, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Text(l10n.topProBadge,
                                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12)),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(data.phone,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: data.online ? const Color(0xFFE1F5EA) : AppColors.tileBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              data.online ? l10n.statusOnline : l10n.statusOffline,
                              style: TextStyle(
                                color: data.online ? AppColors.success : AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatColumn(
                        value: '\$${data.monthlyRate.toStringAsFixed(2)}',
                        label: l10n.monthlyLabel,
                      ),
                    ),
                    const SizedBox(height: 36, child: VerticalDivider(width: 1)),
                    Expanded(
                      child: _StatColumn(
                        value: '${data.perServiceRate.toStringAsFixed(0)}\$',
                        label: l10n.oneServiceLabel,
                      ),
                    ),
                    const SizedBox(height: 36, child: VerticalDivider(width: 1)),
                    Expanded(
                      child: _StatColumn(
                        value: '${data.completedCount}+',
                        label: l10n.statusCompleted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.skillsExpertiseTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: data.skills
                      .map((skill) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.tileBackground,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(skill,
                                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.availabilityTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 20, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Text(data.availabilityDays, style: const TextStyle(color: AppColors.textPrimary)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 20, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Text(data.availabilityHours, style: const TextStyle(color: AppColors.textPrimary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l10n.callAction, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }
}
