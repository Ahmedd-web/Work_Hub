import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerRoundedField extends StatelessWidget {
  const EmployerRoundedField({
    super.key,
    this.label,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.maxLength,
  });

  final String? label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final s = S.of(context);
    final borderColor = colorScheme.outline.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.5 : 0.25,
    );
    final labelWidget =
        label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        GestureDetector(
          onTap: readOnly ? onTap : null,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            onTap: readOnly ? onTap : null,
            keyboardType: keyboardType,
            maxLength: maxLength,
            buildCounter:
                maxLength == null
                    ? null
                    : (
                      context, {
                      required int currentLength,
                      required bool isFocused,
                      required int? maxLength,
                    }) => Text(
                      '$currentLength/$maxLength',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return s.employerEditInfoValidationRequired;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: borderColor),
              ),
              suffixIcon:
                  suffixIcon != null
                      ? Icon(
                        suffixIcon,
                        color: colorScheme.outline.withValues(alpha: 0.7),
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
