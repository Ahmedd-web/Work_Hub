import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

/// أزرار التبويب بين المعلومات الشخصية والسيرة.
class ProfileTabs extends StatelessWidget {
  const ProfileTabs({
    super.key,
    required this.showPersonal,
    required this.personalLabel,
    required this.resumeLabel,
    required this.onChanged,
  });

  final bool showPersonal;
  final String personalLabel;
  final String resumeLabel;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TabButton(
                label: personalLabel,
                selected: showPersonal,
                onTap: () => onChanged(true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TabButton(
                label: resumeLabel,
                selected: !showPersonal,
                onTap: () => onChanged(false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        selected
            ? Colors.white
            : theme.textTheme.bodyMedium?.color ?? AppColors.textPrimary;
    final borderColor =
        !selected
            ? theme.dividerColor.withValues(alpha: 0.5)
            : Colors.transparent;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.bannerGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: borderColor, width: selected ? 0 : 1.2),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
