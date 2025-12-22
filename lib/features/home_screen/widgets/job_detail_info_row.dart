import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

/// Header row showing location/experience/salary in the job detail screen.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.location,
    required this.experience,
    required this.salary,
  });

  final String location;
  final String experience;
  final String salary;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardColor = theme.cardColor;
    final dividerColor = theme.dividerColor.withValues(alpha: 0.6);
    final shadowColor = theme.brightness == Brightness.dark
        ? Colors.transparent
        : Colors.black.withValues(alpha: 0.05);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: dividerColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: InfoItem(
                icon: Icons.location_on_outlined,
                label: s.jobDetailLocationLabel,
                value: location,
                color: colorScheme.primary,
              ),
            ),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: dividerColor,
            ),
            Expanded(
              child: InfoItem(
                icon: Icons.timer_outlined,
                label: s.jobDetailExperienceLabel,
                value: experience,
                color: colorScheme.primary,
              ),
            ),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: dividerColor,
            ),
            Expanded(
              child: InfoItem(
                icon: Icons.attach_money,
                label: s.jobDetailSalaryLabel,
                value: salary,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single item in the InfoRow.
class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
