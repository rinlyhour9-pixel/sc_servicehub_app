import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/api_service.dart';
import 'auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onAuthenticated;

  const SignUpScreen({super.key, required this.onAuthenticated});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate() || _submitting) return;
    setState(() => _submitting = true);
    try {
      await ApiService.instance.register(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      widget.onAuthenticated();
      Navigator.of(context).popUntil((route) => route.isFirst);
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
    return AuthScaffold(
      showBack: true,
      icon: Icons.person_add_alt_1_rounded,
      title: l10n.signUpTitle,
      subtitle: l10n.signUpSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthField(
                controller: _nameController,
                label: l10n.fullName,
                hint: l10n.fullNameHint,
                icon: Icons.person_outline,
                validator: (value) => value == null || value.trim().isEmpty
                    ? l10n.validatorNameRequired
                    : null),
            const SizedBox(height: 18),
            AuthField(
                controller: _emailController,
                label: l10n.emailAddress,
                hint: l10n.emailAddressHint,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains('@')
                    ? l10n.validatorEmailInvalid
                    : null),
            const SizedBox(height: 18),
            AuthField(
                controller: _phoneController,
                label: l10n.phoneNumber,
                hint: l10n.phoneNumberHint,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.trim().length < 8
                    ? l10n.validatorPhoneInvalid
                    : null),
            const SizedBox(height: 18),
            AuthField(
              controller: _passwordController,
              label: l10n.password,
              hint: l10n.passwordHintSignUp,
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined)),
              validator: (value) => value == null || value.length < 8
                  ? l10n.validatorPasswordMinLength
                  : null,
            ),
            const SizedBox(height: 12),
            Text(l10n.signUpTerms,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF7A7F87), height: 1.4)),
            const SizedBox(height: 26),
            PrimaryAuthButton(
              label: _submitting ? 'Creating account...' : l10n.createAccount,
              onPressed: _submitting ? () {} : _createAccount,
            ),
            const SizedBox(height: 18),
            Center(
                child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.alreadyHaveAccount))),
          ],
        ),
      ),
    );
  }
}
