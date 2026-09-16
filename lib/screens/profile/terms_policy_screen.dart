import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/app_header_bar.dart';

/// Terms of use and privacy policy, reachable from every role's
/// Profile > Terms of Policy tile.
class TermsPolicyScreen extends StatelessWidget {
  const TermsPolicyScreen({super.key});

  List<_PolicySection> _sections(AppLocalizations l10n) => [
        _PolicySection(title: l10n.termsSection1Title, body: l10n.termsSection1Body),
        _PolicySection(title: l10n.termsSection2Title, body: l10n.termsSection2Body),
        _PolicySection(title: l10n.termsSection3Title, body: l10n.termsSection3Body),
        _PolicySection(title: l10n.termsSection4Title, body: l10n.termsSection4Body),
        _PolicySection(title: l10n.termsSection5Title, body: l10n.termsSection5Body),
        _PolicySection(title: l10n.termsSection6Title, body: l10n.termsSection6Body),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sections = _sections(l10n);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeaderBar(title: l10n.settingsTermsPolicy),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: sections.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == sections.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      l10n.lastUpdatedLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  );
                }
                return _PolicyCard(section: sections[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicySection {
  final String title;
  final String body;
  const _PolicySection({required this.title, required this.body});
}

class _PolicyCard extends StatelessWidget {
  final _PolicySection section;
  const _PolicyCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.card,
        collapsedBackgroundColor: AppColors.card,
        iconColor: AppColors.primary,
        collapsedIconColor: AppColors.textSecondary,
        title: Text(section.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              section.body,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
