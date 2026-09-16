import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _progressColor = Color(0xFF8BC34A);
  static const _autoAdvanceInterval = Duration(seconds: 2);

  final _controller = PageController();
  Timer? _autoAdvanceTimer;
  int _page = 0;

  static const _images = [
    AppAssets.onboarding1,
    AppAssets.onboarding2,
    AppAssets.onboarding3,
  ];

  List<_OnboardingData> _pages(AppLocalizations l10n) => [
        _OnboardingData(
          image: _images[0],
          title: l10n.onboarding1Title,
          description: l10n.onboarding1Desc,
        ),
        _OnboardingData(
          image: _images[1],
          title: l10n.onboarding2Title,
          description: l10n.onboarding2Desc,
        ),
        _OnboardingData(
          image: _images[2],
          title: l10n.onboarding3Title,
          description: l10n.onboarding3Desc,
        ),
      ];

  bool get _isLastPage => _page == _images.length - 1;
  bool get _showSkip => _page > 0 && !_isLastPage;

  @override
  void initState() {
    super.initState();
    _autoAdvanceTimer = Timer.periodic(_autoAdvanceInterval, (timer) {
      if (_isLastPage) {
        timer.cancel();
        return;
      }
      if (!_controller.hasClients) return;
      _controller.animateToPage(
        _page + 1,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _next() {
    if (_isLastPage) {
      widget.onComplete();
    } else {
      _controller.nextPage(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic);
    }
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = _pages(l10n);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: const Alignment(0, -0.6),
                child: Icon(Icons.settings,
                    size: 480, color: AppColors.primary.withValues(alpha: .04)),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                  child: _showSkip
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: widget.onComplete,
                            label: Text(l10n.skip),
                            icon: const Icon(Icons.chevron_right_rounded),
                            iconAlignment: IconAlignment.end,
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    onPageChanged: (index) => setState(() => _page = index),
                    itemBuilder: (context, index) => _OnboardingPage(
                      data: pages[index],
                      pageCount: pages.length,
                      currentPage: _page,
                      progressColor: _progressColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(_isLastPage ? l10n.getStarted : l10n.next,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
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

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  final int pageCount;
  final int currentPage;
  final Color progressColor;

  const _OnboardingPage({
    required this.data,
    required this.pageCount,
    required this.currentPage,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final imageSize = (width * 0.62).clamp(220.0, 320.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: imageSize,
            height: imageSize,
            child: Image.asset(data.image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                pageCount,
                (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: index == currentPage ? 32 : 22,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          color: index == currentPage
                              ? progressColor
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(10)),
                    )),
          ),
          const SizedBox(height: 32),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              data.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String image;
  final String title;
  final String description;

  const _OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
