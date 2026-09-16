import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_role.dart';
import '../../widgets/language_picker.dart';

/// Splash screen that settles into a role picker before onboarding.
class StartScreen extends StatefulWidget {
  final ValueChanged<UserRole> onRoleSelected;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const StartScreen({
    super.key,
    required this.onRoleSelected,
    required this.locale,
    required this.onLocaleChanged,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _showRoles = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _showRoles = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Icon(Icons.settings,
                      size: 480, color: AppColors.primary.withValues(alpha: .04)),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 20,
              child: _LanguageChip(
                locale: widget.locale,
                onTap: () => showLanguagePicker(
                  context,
                  current: widget.locale,
                  onChanged: widget.onLocaleChanged,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _LogoBadge(),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: _showRoles ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !_showRoles,
                        child: Column(
                          children: [
                            const SizedBox(height: 28),
                            Text(
                              l10n.appTagline,
                              style: const TextStyle(
                                  fontSize: 18, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 56),
                            _RoleButton(
                              label: l10n.roleClient,
                              onTap: () =>
                                  widget.onRoleSelected(UserRole.client),
                            ),
                            const SizedBox(height: 14),
                            _RoleButton(
                              label: l10n.roleTechnician,
                              onTap: () =>
                                  widget.onRoleSelected(UserRole.technician),
                            ),
                            const SizedBox(height: 14),
                            _RoleButton(
                              label: l10n.roleAdmin,
                              onTap: () =>
                                  widget.onRoleSelected(UserRole.admin),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: .28),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(AppAssets.logoSoftCreative, fit: BoxFit.cover),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final Locale locale;
  final VoidCallback onTap;

  const _LanguageChip({required this.locale, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = locale.languageCode == 'km' ? 'ខ្មែរ' : 'English';
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 1,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.language_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(width: 2),
              const Icon(Icons.expand_more_rounded, size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RoleButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(label,
            style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
