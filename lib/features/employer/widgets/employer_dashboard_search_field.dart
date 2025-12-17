import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerDashboardSearchField extends StatelessWidget {
  const EmployerDashboardSearchField({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.9;
    final s = S.of(context);
    final locale = Localizations.localeOf(context);
    final isarabic = locale.languageCode == 'ar';
    final texttheme = theme.textTheme;
    final colorscheme = theme.colorScheme;
    final hintcolor = (texttheme.bodyMedium?.color ?? colorscheme.onSurface)
        .withValues(alpha: 0.45);
    final borderradius = BorderRadius.circular(28);
    final fillcolor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: borderradius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            readOnly: true,
            showCursor: false,
            onTap: onTap,
            textDirection: isarabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isarabic ? TextAlign.right : TextAlign.left,
            style: texttheme.bodyMedium,
            decoration: InputDecoration(
              hintText: s.employerResumesSearchHint,
              hintStyle: texttheme.bodyMedium?.copyWith(color: hintcolor),
              prefixIcon: Icon(Icons.search, color: hintcolor),
              filled: true,
              fillColor: fillcolor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: borderradius,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderradius,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderradius,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
