import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

/// Used in menu_sheet.dart for each menu action row (rounded pill style).
class MenuPillTile extends StatelessWidget {
  const MenuPillTile({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
  });

  final Widget leading;
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.titleMedium?.copyWith(
      color: textColor,
      fontWeight: FontWeight.w600,
    );
    final borderRadius = BorderRadius.circular(32);
    final Color appliedBackground =
        backgroundColor ??
        (
          theme.brightness == Brightness.dark
              ? theme.colorScheme.surface.withValues(alpha: 0.2)
              : AppColors.pillBackground
        );

    return Material(
      color: appliedBackground,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                child: leading,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: style ??
                      const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
