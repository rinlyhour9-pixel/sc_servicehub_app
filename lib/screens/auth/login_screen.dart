import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_role.dart';
import '../../services/api_service.dart';
import 'auth_widgets.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onAuthenticated;
  final bool showCreateAccount;
  final UserRole role;
  final VoidCallback? onBack;

  const LoginScreen({
    super.key,
    required this.onAuthenticated,
    this.showCreateAccount = true,
    this.role = UserRole.client,
    this.onBack,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate() || _submitting) return;
    setState(() => _submitting = true);
    try {
      final user = await ApiService.instance.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (user.role != widget.role) {
        await ApiService.instance.logout();
        throw const ApiException(
            'This account does not have the selected role.');
      }
      if (mounted) widget.onAuthenticated();
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  (IconData, String, String) _roleContent(AppLocalizations l10n) =>
      switch (widget.role) {
        UserRole.client => (
            Icons.handyman_rounded,
            l10n.loginWelcomeTitle,
            l10n.loginWelcomeSubtitle,
          ),
        UserRole.technician => (
            Icons.engineering_rounded,
            l10n.loginTechnicianTitle,
            l10n.loginTechnicianSubtitle,
          ),
        UserRole.admin => (
            Icons.admin_panel_settings_rounded,
            l10n.loginAdminTitle,
            l10n.loginAdminSubtitle,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (icon, title, subtitle) = _roleContent(l10n);
    return AuthScaffold(
      icon: icon,
      title: title,
      subtitle: subtitle,
      showBack: widget.onBack != null,
      onBack: widget.onBack,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthField(
              controller: _emailController,
              label: l10n.emailAddress,
              hint: l10n.emailAddressHint,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || !value.contains('@')
                  ? l10n.validatorEmailInvalid
                  : null,
            ),
            const SizedBox(height: 18),
            AuthField(
              controller: _passwordController,
              label: l10n.password,
              hint: l10n.passwordHintSignIn,
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(_obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              ),
              validator: (value) => value == null || value.length < 6
                  ? l10n.validatorPasswordMinLength
                  : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                    value: _rememberMe,
                    activeColor: AppColors.primary,
                    onChanged: (value) =>
                        setState(() => _rememberMe = value ?? false)),
                Text(l10n.rememberMe, style: const TextStyle(fontSize: 13)),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen())),
                  child: Text(l10n.forgotPassword),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PrimaryAuthButton(
              label: _submitting ? 'Signing in...' : l10n.signIn,
              onPressed: _submitting ? () {} : _signIn,
            ),
            if (widget.showCreateAccount) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(l10n.or,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600))),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(l10n.newToApp,
                        style: const TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SignUpScreen(
                                  onAuthenticated: widget.onAuthenticated))),
                      child: Text(l10n.createAnAccount),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
