// Reusable form field wrappers used in EmployerPostJobPage steps.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_hub/core/theme/app_theme.dart';

class EmployerFormFieldCard extends StatelessWidget {
  const EmployerFormFieldCard({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.6,
            ),
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.2 : 0.05,
                ),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: child,
          ),
        ),
      ],
    );
  }
}

class EmployerPlainTextField extends StatelessWidget {
  const EmployerPlainTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.textDirection = TextDirection.rtl,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextDirection textDirection;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      textDirection: textDirection,
      textAlign:
          textDirection == TextDirection.rtl ? TextAlign.right : TextAlign.left,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: textDirection,
        border: InputBorder.none,
      ),
    );
  }
}

class EmployerDropdownCard extends StatelessWidget {
  const EmployerDropdownCard({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.6,
            ),
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.2 : 0.05,
                ),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: value,
              onChanged: onChanged,
              decoration: const InputDecoration(border: InputBorder.none),
              hint: hint != null ? Text(hint!) : null,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.purple,
              ),
              items:
                  items
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
