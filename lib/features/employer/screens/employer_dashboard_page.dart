import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/screens/employer_post_job_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/features/employer/widgets/employer_dashboard_search_field.dart';
import 'package:work_hub/features/employer/widgets/employer_promo_banner.dart';
import 'package:work_hub/features/employer/widgets/employer_post_job_button.dart';
import 'package:work_hub/features/employer/widgets/employer_empty_state_card.dart';
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
            overlayChild: EmployerDashboardSearchField(onTap: openresumespage),
            overlayHeight: 70,
            height: 160,
          ),
          SizedBox(height: 23),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 180),
              children: [
                const EmployerPromoBanner(),
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
                EmployerPostJobButton(
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
                EmptyStateCard(message: t('لا يوجد بيانات', 'No data')),
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
