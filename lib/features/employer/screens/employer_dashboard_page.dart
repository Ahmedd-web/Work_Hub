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
  State<EmployerDashboardPage> createState() => EmployerDashboardPageState();
}

class EmployerDashboardPageState extends State<EmployerDashboardPage> {
  int currentnavindex = 0;

  void openresumespage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const EmployerResumesPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorscheme = theme.colorScheme;
    final isarabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isarabic ? ar : en;
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
            overlayChild: searchfield(onTap: openresumespage),
            overlayHeight: 70,
            height: 160,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 100),
              children: [
                const promobanner(),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorscheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                postjobbutton(
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
                      onPressed: openresumespage,
                      child: Text(t('شاهد المزيد', 'See more')),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                emptystatecard(message: t('لا يوجد بيانات', 'No data')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: EmployerBottomNav(
        currentIndex: currentnavindex,
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
            openresumespage();
            return;
          }
          setState(() => currentnavindex = index);
        },
      ),
    );
  }
}

class searchfield extends StatelessWidget {
  const searchfield({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.9;
    final s = S.of(context);
    final locale = Localizations.localeOf(context);
    final isarabic = locale.languageCode == 'ar';
    final texttheme = theme.textTheme;
    final colorscheme = theme.colorScheme;
    final hintcolor = (texttheme.bodyMedium?.color ?? colorscheme.onSurface)
        .withValues(alpha: 0.45);
    final borderradius = BorderRadius.circular(28);
    final fillcolor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: borderradius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            readOnly: true,
            showCursor: false,
            onTap: onTap,
            textDirection: isarabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isarabic ? TextAlign.right : TextAlign.left,
            style: texttheme.bodyMedium,
            decoration: InputDecoration(
              hintText: s.employerResumesSearchHint,
              hintStyle: texttheme.bodyMedium?.copyWith(color: hintcolor),
              prefixIcon: Icon(Icons.search, color: hintcolor),
              filled: true,
              fillColor: fillcolor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: borderradius,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderradius,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderradius,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class promobanner extends StatefulWidget {
  const promobanner({super.key});

  @override
  State<promobanner> createState() => promobannerstate();
}

class promobannerstate extends State<promobanner> {
  final controller = PageController(viewportFraction: 0.95);
  int currentindex = 0;
  Timer? autotimer;
  final List<String> images = const [
    'lib/assets/photo_1_2025-11-21_17-19-33.jpg',
    'lib/assets/photo_2_2025-11-21_17-19-33.jpg',
    'lib/assets/photo_3_2025-11-21_17-19-33.jpg',
  ];

  @override
  void initState() {
    super.initState();
    startautoslide();
  }

  void startautoslide() {
    autotimer?.cancel();
    autotimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !controller.hasClients) return;
      final nextindex = (currentindex + 1) % images.length;
      controller.animateToPage(
        nextindex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() => currentindex = nextindex);
    });
  }

  @override
  void dispose() {
    autotimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorscheme = theme.colorScheme;
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: (i) => setState(() => currentindex = i),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(images[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            final isactive = index == currentindex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isactive ? 12 : 8,
              height: 6,
              decoration: BoxDecoration(
                color: colorscheme.primary.withValues(
                  alpha: isactive ? 0.9 : 0.4,
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

class postjobbutton extends StatelessWidget {
  const postjobbutton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isarabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isarabic ? ar : en;
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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

class emptystatecard extends StatelessWidget {
  const emptystatecard({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorscheme = theme.colorScheme;
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
            color: colorscheme.outline.withValues(
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
