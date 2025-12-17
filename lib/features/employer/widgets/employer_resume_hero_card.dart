import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

/// Hero card shown under header on resume detail screen.
class EmployerResumeHeroCard extends StatelessWidget {
  const EmployerResumeHeroCard({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.updated,
  });

  final String name;
  final String role;
  final String location;
  final String updated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.bannerGreen.withValues(alpha: 0.2),
            child: Text(
              name.isEmpty ? '?' : name.characters.first,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.purple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.place, size: 16, color: AppColors.purple),
                    const SizedBox(width: 4),
                    Text(location, style: theme.textTheme.bodySmall),
                    const Spacer(),
                    Text(
                      updated,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.bannerGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
