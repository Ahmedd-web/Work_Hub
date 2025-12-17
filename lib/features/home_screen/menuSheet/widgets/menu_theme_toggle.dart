import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';

/// Used in menu_sheet.dart bottom sheet for dark/light mode toggle.
class MenuThemeToggle extends StatelessWidget {
  const MenuThemeToggle({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final s = S.of(context);

    final backgroundColor = theme.brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.pillBackground;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Icon(
            isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_outlined,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              s.themeDarkModeLabel,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: isDarkMode,
            activeColor: colorScheme.primary,
            onChanged: (val) {
              Navigator.of(context).pop();
              onChanged(val);
            },
          ),
        ],
      ),
    );
  }
}
