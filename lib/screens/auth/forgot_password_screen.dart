import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import 'auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_sent) {
      return AuthScaffold(
        child: Column(
          children: [
            const SizedBox(height: 84),
            Container(width: 86, height: 86, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Icon(Icons.sms_outlined, color: AppColors.primary, size: 42)),
            const SizedBox(height: 26),
            Text(l10n.checkYourPhone, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(l10n.resetInstructionsSent(_phoneController.text), textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, height: 1.45)),
            const SizedBox(height: 30),
            PrimaryAuthButton(label: l10n.backToSignIn, onPressed: () => Navigator.pop(context)),
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
            AuthField(controller: _phoneController, label: l10n.phoneNumber, hint: l10n.phoneNumberHint, icon: Icons.phone_outlined, keyboardType: TextInputType.phone, validator: (value) => value == null || value.trim().length < 8 ? l10n.validatorPhoneInvalid : null),
            const SizedBox(height: 28),
            PrimaryAuthButton(label: l10n.sendResetLink, onPressed: () {
              if (_formKey.currentState!.validate()) setState(() => _sent = true);
            }),
          ],
        ),
      ),
    );
  }
}
