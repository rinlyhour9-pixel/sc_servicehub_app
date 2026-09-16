import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/app_header_bar.dart';

/// "How can we help you" + contact details page, reachable from every role's
/// Profile > Contact Support tile.
class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  Future<void> _open(BuildContext context, Uri uri) async {
    final l10n = AppLocalizations.of(context)!;
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.couldNotOpenMsg(uri.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeaderBar(title: l10n.settingsContactSupport),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.howCanWeHelp,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 14),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          _HelpTile(
                            icon: Icons.chat_bubble_outline,
                            title: l10n.chatWithUsTitle,
                            subtitle: l10n.chatWithUsSubtitle,
                            onTap: () => _open(context, Uri.parse('https://m.me/softcreative.com.kh')),
                          ),
                          _HelpTile(
                            icon: Icons.mail_outline,
                            title: l10n.emailSupportTitle,
                            subtitle: l10n.emailSupportSubtitle,
                            onTap: () => _open(context, Uri(scheme: 'mailto', path: 'support@softcreative.com.kh')),
                          ),
                          _HelpTile(
                            icon: Icons.call_outlined,
                            title: l10n.callUsTitle,
                            subtitle: l10n.callUsSubtitle,
                            onTap: () => _open(context, Uri(scheme: 'tel', path: '+855123456789')),
                          ),
                          _HelpTile(
                            icon: Icons.help_outline,
                            title: l10n.faqsTitle,
                            subtitle: l10n.faqsSubtitle,
                            onTap: () => _showFaqSheet(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Text(l10n.contactUsTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _ContactRow(
                  icon: Icons.location_on_outlined,
                  label: l10n.ourAddressLabel,
                  value: 'Stueng Mean Chey, Phnom Penh',
                ),
                const SizedBox(height: 12),
                _ContactRow(
                  icon: Icons.language,
                  label: l10n.websiteLabel,
                  value: 'www.softcreative.com.kh',
                  onTap: () => _open(context, Uri.https('www.softcreative.com.kh')),
                ),
                const SizedBox(height: 12),
                _ContactRow(
                  icon: Icons.facebook,
                  label: l10n.facebookLabel,
                  value: 'facebook.com/softcreative.com.kh',
                  onTap: () => _open(context, Uri.https('facebook.com', '/softcreative.com.kh')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFaqSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.frequentlyAskedQuestions,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),
              _FaqItem(question: l10n.faqQ1, answer: l10n.faqA1),
              _FaqItem(question: l10n.faqQ2, answer: l10n.faqA2),
              _FaqItem(question: l10n.faqQ3, answer: l10n.faqA3),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 4),
            Text(answer, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.3)),
          ],
        ),
      );
}

class _HelpTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HelpTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.tileBackground,
                  foregroundColor: AppColors.primary,
                  child: Icon(icon, size: 22),
                ),
                const SizedBox(height: 10),
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
        ),
      );
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.tileBackground,
                  foregroundColor: AppColors.primary,
                  child: Icon(icon, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(
                              color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(value, style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
