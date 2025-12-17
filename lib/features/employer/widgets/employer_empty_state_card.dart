import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({super.key, required this.message});

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
