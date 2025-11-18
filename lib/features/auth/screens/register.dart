import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/shared/register_%20job%20_seeker.dart';
import 'package:work_hub/shared/register_employer.dart';

class RegisterPage extends StatelessWidget {
  final int initialTabIndex;

  const RegisterPage({super.key, this.initialTabIndex = 0});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex,
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(
              title: '',
              titleWidget: const SizedBox.shrink(),
              showBackButton: true,
              backgroundColor: AppColors.purple,
              backgroundImage: AppAssets.headerLogo,
              textColor: Colors.white,
              showSearchBar: false,
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: AppColors.bannerGreen,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Text(
                        s.registerTabEmployer,
                        style: textTheme.titleMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        s.registerTabJobSeeker,
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [const EmployerForm(), const JobSeekerForm()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
