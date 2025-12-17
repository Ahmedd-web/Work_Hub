import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/widgets/employer_premium_header_chip.dart';
import 'package:work_hub/features/employer/widgets/employer_premium_overview_card.dart';
import 'package:work_hub/features/employer/widgets/employer_premium_plan_card.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerPremiumPlansPage extends StatefulWidget {
  const EmployerPremiumPlansPage({super.key});

  @override
  State<EmployerPremiumPlansPage> createState() => EmployerPremiumPlansPageState();
}

class EmployerPremiumPlansPageState extends State<EmployerPremiumPlansPage> {
  int selectedDuration = 1;

  static const List<PlanDefinition> planDefinitions = [
    PlanDefinition(
      price: 50,
      label: PlanLabel.week,
      jobPosts: 1,
      visibilityDays: 7,
      resumeViews: 20,
      featuredAds: 0,
      editCount: 1,
      isPopular: true,
    ),
    PlanDefinition(
      price: 100,
      label: PlanLabel.month,
      jobPosts: 15,
      visibilityDays: 3,
      resumeViews: 25,
      featuredAds: 3,
      unlimitedEdits: true,
    ),
    PlanDefinition(
      price: 150,
      label: PlanLabel.threeMonths,
      jobPosts: 70,
      visibilityDays: 7,
      resumeViews: 50,
      featuredAds: 15,
      unlimitedEdits: true,
    ),
    PlanDefinition(
      price: 200,
      label: PlanLabel.sixMonths,
      jobPosts: 120,
      visibilityDays: 7,
      resumeViews: 100,
      featuredAds: 25,
      unlimitedEdits: true,
    ),
    PlanDefinition(
      price: 250,
      label: PlanLabel.year,
      jobPosts: 300,
      visibilityDays: 14,
      resumeViews: 100,
      featuredAds: 60,
      unlimitedEdits: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    const arabicDinar = '\u062F\u064A\u0646\u0627\u0631';
    final currencyText = isArabic ? arabicDinar : 'LYD';
    final plans = buildPlans(s);
    final selectedPlan = plans[selectedDuration];
    final Color secondaryTextColor =
        (textTheme.bodyMedium?.color ?? colorScheme.onSurface).withValues(alpha: 0.7);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showBackButton: true,
            showNotificationButton: false,
            showSearchBar: false,
            overlayHeight: 56,
            overlayChild: const EmployerPremiumHeaderChip(),
            height: 130,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              children: [
                const EmployerPremiumOverviewCard(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s.employerPremiumChooseDuration,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.bannerGreen,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.bannerGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      plans.length,
                      (index) => EmployerPremiumPlanCard(
                        plan: plans[index],
                        active: selectedDuration == index,
                        onTap: () => setState(() => selectedDuration = index),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      isArabic
                          ? 'اشترك بـ ${selectedPlan.price} $currencyText'
                          : 'Subscribe for ${selectedPlan.price} $currencyText',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  List<PremiumPlanData> buildPlans(S s) {
    return planDefinitions.map((plan) {
      final label = resolveLabel(plan.label, s);
      final editsLine = plan.unlimitedEdits
          ? s.employerPlanBenefitEditsUnlimited
          : s.employerPlanBenefitEdits(plan.editCount ?? 0);
      return PremiumPlanData(
        price: plan.price,
        label: label,
        description: [
          s.employerPlanBenefitJobPosts(plan.jobPosts),
          s.employerPlanBenefitVisibilityDays(plan.visibilityDays),
          s.employerPlanBenefitResumeViews(plan.resumeViews),
          s.employerPlanBenefitFeaturedAds(plan.featuredAds),
          editsLine,
        ],
        isPopular: plan.isPopular,
      );
    }).toList();
  }

  String resolveLabel(PlanLabel label, S s) {
    switch (label) {
      case PlanLabel.week:
        return s.employerPlanLabelWeek;
      case PlanLabel.month:
        return s.employerPlanLabelMonth;
      case PlanLabel.threeMonths:
        return s.employerPlanLabelThreeMonths;
      case PlanLabel.sixMonths:
        return s.employerPlanLabelSixMonths;
      case PlanLabel.year:
        return s.employerPlanLabelYear;
    }
  }
}

class PlanDefinition {
  const PlanDefinition({
    required this.price,
    required this.label,
    required this.jobPosts,
    required this.visibilityDays,
    required this.resumeViews,
    required this.featuredAds,
    this.editCount,
    this.unlimitedEdits = false,
    this.isPopular = false,
  });

  final int price;
  final PlanLabel label;
  final int jobPosts;
  final int visibilityDays;
  final int resumeViews;
  final int featuredAds;
  final int? editCount;
  final bool unlimitedEdits;
  final bool isPopular;
}

class PremiumPlanData {
  const PremiumPlanData({
    required this.price,
    required this.label,
    required this.description,
    this.isPopular = false,
  });

  final int price;
  final String label;
  final List<String> description;
  final bool isPopular;
}

enum PlanLabel { week, month, threeMonths, sixMonths, year }
