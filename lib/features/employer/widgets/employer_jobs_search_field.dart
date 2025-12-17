import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerJobsSearchField extends StatelessWidget {
  const EmployerJobsSearchField({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
  });

  final String initialValue;
  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.9;
    final s = S.of(context);
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final hintColor = (textTheme.bodyMedium?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.45);
    final borderRadius = BorderRadius.circular(28);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: borderRadius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText.isEmpty ? s.employerJobsSearchHint : hintText,
              hintStyle: textTheme.bodyMedium?.copyWith(color: hintColor),
              prefixIcon: Icon(Icons.search, color: hintColor),
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
