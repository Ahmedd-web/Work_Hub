// Used in EmployerPremiumPlansPage to show the purple overview card at top of the plans list.
import 'package:flutter/material.dart';

import 'package:work_hub/generated/l10n.dart';

class EmployerPremiumOverviewCard extends StatelessWidget {
  const EmployerPremiumOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final s = S.of(context);
    final Color secondaryTextColor = (textTheme.bodyMedium?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.7);

    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                  color: textTheme.titleLarge?.color ?? colorScheme.onSurface,
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
    );
  }
}
