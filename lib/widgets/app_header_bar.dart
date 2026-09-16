import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// Blue rounded-bottom header with a back button, used by pushed detail
/// pages such as Information, Contact Support, and Terms of Policy.
class AppHeaderBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const AppHeaderBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top + 8, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onBack ?? () => Navigator.of(context).pop(),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}
