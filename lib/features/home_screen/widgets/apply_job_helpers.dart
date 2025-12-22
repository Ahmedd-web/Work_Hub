import 'package:flutter/material.dart';

/// Common labeled wrapper used in ApplyJobPage.
class LabeledField extends StatelessWidget {
  const LabeledField({
    required this.label,
    required this.child,
    this.alignment = CrossAxisAlignment.end,
    this.labelAlign = TextAlign.right,
    this.showLabel = true,
    super.key,
  });

  final String label;
  final Widget child;
  final CrossAxisAlignment alignment;
  final TextAlign labelAlign;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: labelAlign,
          ),
          const SizedBox(height: 8),
        ],
        child,
      ],
    );
  }
}

/// Text field that respects RTL/LTR alignment.
class AlignedTextField extends StatelessWidget {
  const AlignedTextField({
    required this.controller,
    required this.isArabic,
    required this.decoration,
    this.keyboardType,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final bool isArabic;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final textAlign = isArabic ? TextAlign.right : TextAlign.left;
    return Directionality(
      textDirection: textDirection,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: textAlign,
        decoration: decoration,
        validator: validator,
      ),
    );
  }
}

/// Phone number field with alignment logic.
class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    required this.controller,
    required this.border,
    required this.colorScheme,
    required this.isArabic,
    required this.hintText,
    required this.requiredText,
    required this.labelText,
    super.key,
  });

  final TextEditingController controller;
  final OutlineInputBorder border;
  final ColorScheme colorScheme;
  final bool isArabic;
  final String hintText;
  final String requiredText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final textAlign = isArabic ? TextAlign.right : TextAlign.left;
    return Directionality(
      textDirection: textDirection,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textAlign: textAlign,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hintText,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator:
            (val) => val == null || val.trim().isEmpty ? requiredText : null,
      ),
    );
  }
}

/// Country code dropdown for phone input.
/// Country code dropdown for phone input.
class PhoneCodeField extends StatelessWidget {
  const PhoneCodeField({
    required this.border,
    required this.colorScheme,
    required this.textDirection,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final OutlineInputBorder border;
  final ColorScheme colorScheme;
  final TextDirection textDirection;
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isArabic = textDirection == TextDirection.rtl;
    return Directionality(
      textDirection: textDirection,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        items: [
          DropdownMenuItem(
            value: '+218',
            child: Text(isArabic ? '+218 ليبيا' : '+218 Libya'),
          ),
          DropdownMenuItem(
            value: '+20',
            child: Text(isArabic ? '+20 مصر' : '+20 Egypt'),
          ),
          DropdownMenuItem(
            value: '+971',
            child: Text(isArabic ? '+971 الإمارات' : '+971 UAE'),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
