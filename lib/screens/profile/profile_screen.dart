import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../services/api_service.dart';
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
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.cancel)),
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
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.myProfileTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(l10n.myProfileSubtitle,
                  style: const TextStyle(color: Colors.white70, height: 1.35)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileCard(user: ApiService.instance.currentUser),
              const SizedBox(height: 20),
              Text(l10n.accountSettings,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x080B5FA8),
                        blurRadius: 14,
                        offset: Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.storefront_outlined,
                      title: l10n.settingsInformation,
                      subtitle: l10n.settingsInformationSubtitle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InformationScreen()),
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.language_outlined,
                      title: l10n.settingsLanguage,
                      subtitle:
                          locale.languageCode == 'km' ? 'ភាសាខ្មែរ' : 'English',
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
                        MaterialPageRoute(
                            builder: (_) => const ContactSupportScreen()),
                      ),
                    ),
                    const Divider(height: 1),
                    _SettingsTile(
                      icon: Icons.description_outlined,
                      title: l10n.settingsTermsPolicy,
                      subtitle: l10n.settingsTermsPolicySubtitle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TermsPolicyScreen()),
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
  final ApiUser? user;
  const _ProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user?.name ?? '—';
    final detail =
        user?.phone?.isNotEmpty == true ? user!.phone! : (user?.email ?? '');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary,
              child: Text('SC',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(detail,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      minVerticalPadding: 12,
      onTap: onTap,
      leading: CircleAvatar(
          backgroundColor: iconBg,
          foregroundColor: iconColor,
          child: Icon(icon, size: 20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded,
          size: 20, color: AppColors.textSecondary),
    );
  }
}
