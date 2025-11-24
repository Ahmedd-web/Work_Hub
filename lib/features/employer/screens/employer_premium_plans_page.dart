import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerPremiumPlansPage extends StatefulWidget {
  const EmployerPremiumPlansPage({super.key});

  @override
  State<EmployerPremiumPlansPage> createState() =>
      _EmployerPremiumPlansPageState();
}

class _EmployerPremiumPlansPageState extends State<EmployerPremiumPlansPage> {
  int _selectedDuration = 1;

  static const List<_PlanDefinition> _planDefinitions = [
    _PlanDefinition(
      price: 50,
      label: _PlanLabel.week,
      jobPosts: 1,
      visibilityDays: 7,
      resumeViews: 20,
      featuredAds: 0,
      editCount: 1,
      isPopular: true,
    ),
    _PlanDefinition(
      price: 100,
      label: _PlanLabel.month,
      jobPosts: 15,
      visibilityDays: 3,
      resumeViews: 25,
      featuredAds: 3,
      unlimitedEdits: true,
    ),
    _PlanDefinition(
      price: 150,
      label: _PlanLabel.threeMonths,
      jobPosts: 70,
      visibilityDays: 7,
      resumeViews: 50,
      featuredAds: 15,
      unlimitedEdits: true,
    ),
    _PlanDefinition(
      price: 200,
      label: _PlanLabel.sixMonths,
      jobPosts: 120,
      visibilityDays: 7,
      resumeViews: 100,
      featuredAds: 25,
      unlimitedEdits: true,
    ),
    _PlanDefinition(
      price: 250,
      label: _PlanLabel.year,
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
    final plans = _buildPlans(s);
    final selectedPlan = plans[_selectedDuration];
    final Color secondaryTextColor = (textTheme.bodyMedium?.color ??
            colorScheme.onSurface)
        .withValues(alpha: 0.7);

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
            overlayChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFD0A446),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    s.employerPremiumHeaderLabel,
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            height: 130,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.35 : 0.08,
                        ),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.apartment,
                            color: Color(0xFF7A7A7A),
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            s.employerPremiumOverviewTitle,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  textTheme.titleLarge?.color ??
                                  colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        s.employerPremiumOverviewBody,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: secondaryTextColor,
                          height: 1.6,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      (index) => _PremiumPlanCard(
                        plan: plans[index],
                        active: _selectedDuration == index,
                        onTap: () => setState(() => _selectedDuration = index),
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
                      'اشترك بـ ${selectedPlan.price} دينار',
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

  List<_PremiumPlanData> _buildPlans(S s) {
    return _planDefinitions.map((plan) {
      final label = _resolveLabel(plan.label, s);
      final editsLine =
          plan.unlimitedEdits
              ? s.employerPlanBenefitEditsUnlimited
              : s.employerPlanBenefitEdits(plan.editCount ?? 0);
      return _PremiumPlanData(
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

  String _resolveLabel(_PlanLabel label, S s) {
    switch (label) {
      case _PlanLabel.week:
        return s.employerPlanLabelWeek;
      case _PlanLabel.month:
        return s.employerPlanLabelMonth;
      case _PlanLabel.threeMonths:
        return s.employerPlanLabelThreeMonths;
      case _PlanLabel.sixMonths:
        return s.employerPlanLabelSixMonths;
      case _PlanLabel.year:
        return s.employerPlanLabelYear;
    }
  }
}

class _PremiumPlanCard extends StatelessWidget {
  const _PremiumPlanCard({
    required this.plan,
    required this.active,
    required this.onTap,
  });

  final _PremiumPlanData plan;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final baseColor =
        active
            ? theme.cardColor
            : colorScheme.surfaceContainerHighest.withValues(
              alpha: isDark ? 0.45 : 1,
            );
    final borderColor =
        active
            ? AppColors.bannerGreen
            : colorScheme.outline.withValues(alpha: isDark ? 0.5 : 0.35);
    final shadowColor = Colors.black.withValues(alpha: isDark ? 0.35 : 0.1);
    final bodyColor = (textTheme.bodySmall?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.8);
    final s = S.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: borderColor, width: active ? 2 : 1),
          boxShadow:
              active
                  ? [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${plan.price} دينار',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (plan.isPopular) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade300,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          s.employerPremiumPopularBadge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              plan.label,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            ...plan.description.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.bannerGreen,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        line,
                        style: textTheme.bodySmall?.copyWith(
                          color: bodyColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PlanLabel { week, month, threeMonths, sixMonths, year }

class _PlanDefinition {
  const _PlanDefinition({
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
  final _PlanLabel label;
  final int jobPosts;
  final int visibilityDays;
  final int resumeViews;
  final int featuredAds;
  final int? editCount;
  final bool unlimitedEdits;
  final bool isPopular;
}

class _PremiumPlanData {
  const _PremiumPlanData({
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
