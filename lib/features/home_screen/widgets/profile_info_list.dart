import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

/// قائمة عرض بيانات المستخدم في التبويب الشخصي.
class ProfileInfoList extends StatelessWidget {
  const ProfileInfoList({super.key, required this.fields});

  final List<ProfileField> fields;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < fields.length; i++) ...[
            ProfileInfoRow(field: fields[i]),
            if (i != fields.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: theme.dividerColor),
              ),
          ],
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({required this.field});

  final ProfileField field;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );
    final valueColor =
        field.isLink
            ? AppColors.purple
            : theme.textTheme.bodyLarge?.color ?? AppColors.textPrimary;
    final valueStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: valueColor,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(field.label, textAlign: TextAlign.end, style: labelStyle),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            field.value,
            textAlign: TextAlign.start,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}

class ProfileField {
  const ProfileField({
    required this.label,
    required this.value,
    this.isLink = false,
  });

  final String label;
  final String value;
  final bool isLink;
}
