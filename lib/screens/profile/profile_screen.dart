import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/language_picker.dart';
import 'contact_support_screen.dart';
import 'information_screen.dart';
import 'terms_policy_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.onLogout,
  });

  Future<void> _confirmLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logOutConfirmTitle),
        content: Text(l10n.logOutConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(l10n.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.logOut),
          ),
        ],
      ),
    );
    if (shouldLogout == true) onLogout();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.myProfileTitle, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(l10n.myProfileSubtitle, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileCard(),
              const SizedBox(height: 20),
              Text(l10n.accountSettings, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.storefront_outlined,
                      title: l10n.settingsInformation,
                      subtitle: l10n.settingsInformationSubtitle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const InformationScreen()),
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.language_outlined,
                      title: l10n.settingsLanguage,
                      subtitle: locale.languageCode == 'km' ? 'ភាសាខ្មែរ' : 'English',
                      onTap: () => showLanguagePicker(
                        context,
                        current: locale,
                        onChanged: onLocaleChanged,
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.support_agent_outlined,
                      title: l10n.settingsContactSupport,
                      subtitle: l10n.settingsContactSupportSubtitle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ContactSupportScreen()),
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.description_outlined,
                      title: l10n.settingsTermsPolicy,
                      subtitle: l10n.settingsTermsPolicySubtitle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TermsPolicyScreen()),
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.logout_rounded,
                      iconColor: AppColors.danger,
                      iconBg: const Color(0xFFFDE7E7),
                      title: l10n.logOut,
                      subtitle: l10n.logOutSubtitle,
                      onTap: () => _confirmLogout(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: const Row(
        children: [
          CircleAvatar(radius: 30, backgroundColor: AppColors.primaryDark, child: Text('SC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rin Lyhour', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 4),
                Text('+855 12 345 678', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    this.iconColor = AppColors.primary,
    this.iconBg = AppColors.tileBackground,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(backgroundColor: iconBg, foregroundColor: iconColor, child: Icon(icon, size: 20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20),
    );
  }
}
