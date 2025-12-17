import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

/// Reusable search field used in employer resumes list header overlay.
class EmployerResumeSearchField extends StatelessWidget {
  const EmployerResumeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final width = MediaQuery.of(context).size.width * 0.9;
    final hintColor = (textTheme.bodyMedium?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.45);
    final borderRadius = BorderRadius.circular(28);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final s = S.of(context);

    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: borderRadius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: s.employerResumesSearchHint,
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
