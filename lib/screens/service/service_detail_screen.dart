import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/service_category.dart';
import '../booking/booking_form_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceCategory category;

  const ServiceDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(title: l10n.serviceDetailsTitle),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: Image.asset(
                        category.bannerAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.tileBackground,
                          padding: const EdgeInsets.all(48),
                          child: Image.asset(category.iconAsset, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(category.name(l10n), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.verified_rounded, size: 16, color: AppColors.success),
                    const SizedBox(width: 6),
                    Text(l10n.verifiedProsSubtitle, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    category.description(l10n),
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l10n.startingFromLabel, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)), const SizedBox(height: 2), const Text('\$15.00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary))])), Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: AppColors.successBg, shape: BoxShape.circle), child: const Icon(Icons.verified_rounded, color: AppColors.success))]),
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.whatsIncludedTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  ...category.included(l10n).map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                          const SizedBox(width: 10),
                          Expanded(child: Text(item, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(color: AppColors.background, boxShadow: [BoxShadow(color: Color(0x12000000), blurRadius: 14, offset: Offset(0, -4))]),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BookingFormScreen(category: category)),
                    );
                  },
                  child: Text(l10n.bookThisServiceButton, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  const _TopBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 18), onPressed: () => Navigator.pop(context)),
          Expanded(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => Clipboard.setData(ClipboardData(text: l10n.sharedFromAppMsg)),
          ),
        ],
      ),
    );
  }
}
