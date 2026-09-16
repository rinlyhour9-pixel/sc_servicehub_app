import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/service_category.dart';
import '../../widgets/greeting_header.dart';
import '../service/service_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSeeAllBookings;
  final VoidCallback onOpenNotifications;

  const HomeScreen({
    super.key,
    required this.onSeeAllBookings,
    required this.onOpenNotifications,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bannerController = PageController();
  Timer? _bannerTimer;
  int _bannerPage = 0;

  static const _banners = [
    AppAssets.banner1,
    AppAssets.banner2,
    AppAssets.banner3,
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          (_bannerPage + 1) % _banners.length,
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const columns = 3;
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 20),
      children: [
        GreetingHeader(
          name: l10n.roleClient,
          subtitle: l10n.greetingSubtitleClient,
          onNotifications: widget.onOpenNotifications,
          notificationCount: 4,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                title: l10n.servicesTitle,
                action: l10n.servicesAvailable(ServiceCategory.all.length),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ServiceCategory.all.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 118,
                ),
                itemBuilder: (context, index) => _CategoryTile(
                  category: ServiceCategory.all[index],
                  onTap: () => _openService(ServiceCategory.all[index]),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _PromotionalBanner(
          controller: _bannerController,
          currentPage: _bannerPage,
          banners: _banners,
          onPageChanged: (page) => setState(() => _bannerPage = page),
        ),
      ],
    );
  }

  void _openService(ServiceCategory category) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ServiceDetailScreen(category: category),
        ),
      );
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String action;
  const _SectionTitle({required this.title, required this.action});

  @override
  Widget build(BuildContext context) => Row(children: [
        Text(title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            )),
        const Spacer(),
        Text(action,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            )),
      ]);
}

class _CategoryTile extends StatelessWidget {
  final ServiceCategory category;
  final VoidCallback onTap;
  const _CategoryTile({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.tileBackground,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(category.iconAsset, fit: BoxFit.contain),
              ),
              const SizedBox(height: 8),
              Text(category.name(AppLocalizations.of(context)!),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  )),
            ],
          ),
        ),
      );
}

class _PromotionalBanner extends StatelessWidget {
  final PageController controller;
  final int currentPage;
  final List<String> banners;
  final ValueChanged<int> onPageChanged;
  const _PromotionalBanner({
    required this.controller,
    required this.currentPage,
    required this.banners,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) => Column(children: [
        AspectRatio(
          aspectRatio: 2.7,
          child: PageView.builder(
            controller: controller,
            itemCount: banners.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(banners[index], fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: index == currentPage ? 16 : 5,
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color:
                    index == currentPage ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ]);
}
