import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerDescriptionField extends StatelessWidget {
  const EmployerDescriptionField({
    super.key,
    required this.label,
    required this.controller,
    required this.textDirection,
  });

  final String label;
  final TextEditingController controller;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = colorScheme.outline.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.5 : 0.25,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 6,
          minLines: 4,
          textDirection: textDirection,
          textAlign:
              textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          validator:
              (value) =>
                  (value ?? '').trim().isEmpty
                      ? S.of(context).employerEditAboutValidationRequired
                      : null,
        ),
      ],
    );
  }
}
