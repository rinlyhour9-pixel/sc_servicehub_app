import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../l10n/app_localizations.dart';

/// Bottom sheet used everywhere the app lets someone switch between English
/// and Khmer, so the picker looks and behaves the same whether it's opened
/// from the role-picker screen or from Profile > Language.
void showLanguagePicker(
  BuildContext context, {
  required Locale current,
  required ValueChanged<Locale> onChanged,
}) {
  final l10n = AppLocalizations.of(context)!;
  showModalBottomSheet<void>(
    context: context,
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
            Text(l10n.chooseLanguage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _LanguageOption(
              label: 'English',
              selected: current.languageCode == 'en',
              onTap: () {
                Navigator.pop(sheetContext);
                onChanged(const Locale('en'));
              },
            ),
            _LanguageOption(
              label: 'ភាសាខ្មែរ',
              selected: current.languageCode == 'km',
              onTap: () {
                Navigator.pop(sheetContext);
                onChanged(const Locale('km'));
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : const Icon(Icons.circle_outlined, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
