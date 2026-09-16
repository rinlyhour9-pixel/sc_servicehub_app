import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/app_header_bar.dart';

/// Lets the signed-in user review and edit their account details.
/// Shared across every role (client, technician, admin) via ProfileScreen.
class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _nameController = TextEditingController(text: 'Rin Lyhour');
  final _phoneController = TextEditingController(text: '+855 12 345 678');
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController(text: '#123, St 2004, Preysor');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.informationSavedMsg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeaderBar(title: l10n.yourInformationTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primaryDark,
                        child: Text('RL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_nameController.text,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Text(_phoneController.text,
                                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel(l10n.nameLabel),
                      _InputBox(controller: _nameController),
                      const SizedBox(height: 16),
                      _FieldLabel(l10n.phoneNumber),
                      _InputBox(controller: _phoneController, keyboardType: TextInputType.phone),
                      const SizedBox(height: 16),
                      _FieldLabel(l10n.labelDescription),
                      _InputBox(
                        controller: _descriptionController,
                        maxLines: 3,
                        hint: l10n.tellUsHint,
                        icon: Icons.description_outlined,
                      ),
                      const SizedBox(height: 16),
                      _FieldLabel(l10n.labelAddress),
                      _InputBox(controller: _addressController),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _save,
                    child: Text(l10n.saveButton, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      );
}

class _InputBox extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String? hint;
  final IconData? icon;
  final TextInputType? keyboardType;

  const _InputBox({
    required this.controller,
    this.maxLines = 1,
    this.hint,
    this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, size: 20, color: AppColors.textSecondary) : null,
        filled: true,
        fillColor: AppColors.tileBackground.withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
