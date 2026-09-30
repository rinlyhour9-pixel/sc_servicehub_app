import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../services/api_service.dart';
import 'auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate() || _submitting) return;
    setState(() => _submitting = true);
    try {
      await ApiService.instance.forgotPassword(_emailController.text);
      if (mounted) setState(() => _sent = true);
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_sent) {
      return AuthScaffold(
        child: Column(
          children: [
            const SizedBox(height: 84),
            Container(
              width: 86,
              height: 86,
              decoration: const BoxDecoration(
                  color: AppColors.primaryLight, shape: BoxShape.circle),
              child: const Icon(Icons.mark_email_read_outlined,
                  color: AppColors.primary, size: 42),
            ),
            const SizedBox(height: 26),
            Text(l10n.checkYourPhone,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(l10n.resetInstructionsSent(_emailController.text),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.textSecondary, height: 1.45)),
            const SizedBox(height: 30),
            PrimaryAuthButton(
                label: l10n.backToSignIn,
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      );
    }

    return AuthScaffold(
      showBack: true,
      icon: Icons.lock_reset_rounded,
      title: l10n.forgotPasswordTitle,
      subtitle: l10n.forgotPasswordSubtitle,
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
            const SizedBox(height: 28),
            PrimaryAuthButton(
              label: _submitting ? 'Sending…' : l10n.sendResetLink,
              onPressed: _send,
            ),
          ],
        ),
      ),
    );
  }
}
