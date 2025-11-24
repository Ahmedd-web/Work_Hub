import 'dart:async';

import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/screens/employer_post_job_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerDashboardPage extends StatefulWidget {
  const EmployerDashboardPage({super.key});

  @override
  State<EmployerDashboardPage> createState() => _EmployerDashboardPageState();
}

class _EmployerDashboardPageState extends State<EmployerDashboardPage> {
  int _currentNavIndex = 0;

  void _openResumesPage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const EmployerResumesPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isArabic ? ar : en;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showMenuButton: true,
            showNotificationButton: true,
            showSearchBar: false,
            overlayChild: _SearchField(onTap: _openResumesPage),
            overlayHeight: 70,
            height: 160,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 100),
              children: [
                const _PromoBanner(),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _PostJobButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EmployerPostJobPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t('أحدث السير الذاتية', 'Latest resumes'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: _openResumesPage,
                      child: Text(t('شاهد المزيد', 'See more')),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _EmptyStateCard(message: t('لا يوجد بيانات', 'No data')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: EmployerBottomNav(
        currentIndex: _currentNavIndex,
        onChanged: (index) {
          if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerAccountPage()),
            );
            return;
          }
          if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerJobsPage()),
            );
            return;
          }
          if (index == 2) {
            _openResumesPage();
            return;
          }
          setState(() => _currentNavIndex = index);
        },
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.9;
    final s = S.of(context);
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final hintColor = (textTheme.bodyMedium?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.45);
    final borderRadius = BorderRadius.circular(28);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: borderRadius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            readOnly: true,
            showCursor: false,
            onTap: onTap,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: s.employerResumesSearchHint,
              hintStyle: textTheme.bodyMedium?.copyWith(color: hintColor),
              prefixIcon: Icon(Icons.search, color: hintColor),
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PromoBanner extends StatefulWidget {
  const _PromoBanner();

  @override
  State<_PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<_PromoBanner> {
  final _controller = PageController(viewportFraction: 0.95);
  int _currentIndex = 0;
  Timer? _autoTimer;
  final List<String> _images = const [
    'lib/assets/photo_1_2025-11-21_17-19-33.jpg',
    'lib/assets/photo_2_2025-11-21_17-19-33.jpg',
    'lib/assets/photo_3_2025-11-21_17-19-33.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_controller.hasClients) return;
      final nextIndex = (_currentIndex + 1) % _images.length;
      _controller.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex = nextIndex);
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(_images[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: 6,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(
                  alpha: isActive ? 0.9 : 0.4,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PostJobButton extends StatelessWidget {
  const _PostJobButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isArabic ? ar : en;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        gradient: const LinearGradient(
          colors: [Color(0xFF24A268), Color(0xFF5F1C8E)],
        ),
      ),
      child: Material(
        color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(38),
            onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  S.of(context).employerPostJobCta,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: theme.cardColor,
      elevation: 0,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colorScheme.outline.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.35 : 0.2,
            ),
          ),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.bannerGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
