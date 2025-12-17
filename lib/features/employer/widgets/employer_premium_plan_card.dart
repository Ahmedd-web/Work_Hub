// Used in EmployerPremiumPlansPage to render each selectable plan card.
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_premium_plans_page.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerPremiumPlanCard extends StatelessWidget {
  const EmployerPremiumPlanCard({
    super.key,
    required this.plan,
    required this.active,
    required this.onTap,
  });

  final PremiumPlanData plan;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    const arabicDinar = '\u062F\u064A\u0646\u0627\u0631';
    final currencyText = isArabic ? arabicDinar : 'LYD';
    final baseColor = active
        ? theme.cardColor
        : colorScheme.surfaceContainerHighest.withValues(alpha: isDark ? 0.45 : 1);
    final borderColor =
        active ? AppColors.bannerGreen : colorScheme.outline.withValues(alpha: isDark ? 0.5 : 0.35);
    final shadowColor = Colors.black.withValues(alpha: isDark ? 0.35 : 0.1);
    final bodyColor = (textTheme.bodySmall?.color ?? colorScheme.onSurface).withValues(alpha: 0.8);
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
          boxShadow: active
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
                    '$currencyText ${plan.price}',
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
                          height: 1.35,
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
