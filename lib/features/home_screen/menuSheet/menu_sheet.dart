import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';

/// ألوان قابلة للتعديل سريعًا
class WorkHubColors {
  static const purple = AppColors.purple; // عدّل البنفسجي حسب هويتك
  static const green = AppColors.secondary;
  static const pillBg = AppColors.pillBackground; // خلفية العناصر
}

/// نموذج عنصر قائمة (باستثناء اختيار اللغة)
class MenuEntry {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const MenuEntry({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });
}

/// استدع هذه الدالة عند الضغط على زر القائمة
Future<void> showWorkHubMenuSheet(
  BuildContext context, {
  // لغة حالية + تغيير اللغة
  String? currentLanguage,
  List<String>? languages,
  required ValueChanged<String> onLanguageChanged,
  required bool isDarkMode,
  required ValueChanged<bool> onThemeModeChanged,

  // بقية العناصر
  required List<MenuEntry> items,

  // خيارات شكلية
  Color? backgroundColor,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final s = S.of(context);
  final locale = Localizations.localeOf(context);
  final defaultLanguages = <String>[s.languageEnglish, s.languageArabic];
  final options =
      (languages != null && languages.isNotEmpty)
          ? List<String>.from(languages)
          : List<String>.from(defaultLanguages);
  final fallbackLanguage =
      locale.languageCode == 'ar' ? s.languageArabic : s.languageEnglish;
  if (!options.contains(fallbackLanguage)) {
    options.insert(0, fallbackLanguage);
  }
  final resolvedCurrent =
      currentLanguage != null && options.contains(currentLanguage)
          ? currentLanguage
          : fallbackLanguage;
  final effectiveBackground = backgroundColor ?? colorScheme.surface;
  final pillColor = theme.brightness == Brightness.dark
      ? colorScheme.surface.withValues(alpha: 0.2)
      : AppColors.pillBackground;
  final defaultIconColor = colorScheme.primary;
  final defaultTextColor =
      theme.textTheme.bodyLarge?.color ?? colorScheme.onSurface;
  final media = MediaQuery.of(context);
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          margin: EdgeInsets.only(top: media.size.height * 0.08),
          decoration: BoxDecoration(
            color: effectiveBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 18,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // الـ grab handle
              Container(
                width: 56,
                height: 6,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              // عنصر اختيار اللغة (يشبه Dropdown كبير داخل كبسولة)
              _LanguagePill(
                value: resolvedCurrent,
                options: options,
                onChanged: onLanguageChanged,
              ),

              const SizedBox(height: 14),
              _ThemeModeToggle(
                isDarkMode: isDarkMode,
                onChanged: onThemeModeChanged,
              ),

              const SizedBox(height: 14),

              // قائمة العناصر
              ...items.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _PillTile(
                    leading: Icon(
                      e.icon,
                      color: e.iconColor ?? defaultIconColor,
                      size: 26,
                    ),
                    title: e.title,
                    textColor: e.textColor ?? defaultTextColor,
                    onTap: () {
                      Navigator.of(context).pop();
                      e.onTap();
                    },
                    backgroundColor: pillColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// كبسولة عنصر عام (Icon + Label)

class _ThemeModeToggle extends StatelessWidget {
  const _ThemeModeToggle({required this.isDarkMode, required this.onChanged});

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final s = S.of(context);

    final backgroundColor = theme.brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.pillBackground;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Icon(
            isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_outlined,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              s.themeDarkModeLabel,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: isDarkMode,
            activeColor: colorScheme.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _PillTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color backgroundColor;

  const _PillTile({
    required this.leading,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.titleMedium?.copyWith(
      color: textColor,
      fontWeight: FontWeight.w600,
    );

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                child: leading,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: style ?? const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

/// كبسولة اختيار اللغة (Globe + Dropdown Arrow)
class _LanguagePill extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _LanguagePill({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.textTheme.bodyMedium?.color ?? colorScheme.onSurface,
    );
    final pillBackground = theme.brightness == Brightness.dark
        ? colorScheme.surface.withValues(alpha: 0.2)
        : AppColors.pillBackground;
    final borderColor = theme.dividerColor.withValues(alpha: 0.6);

    return Container(
      decoration: BoxDecoration(
        color: pillBackground,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 4),
          Icon(Icons.language, color: colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.iconTheme.color ?? AppColors.textSecondary,
                ),
                style: textStyle ??
                    const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                items:
                    options
                        .map(
                          (lang) =>
                              DropdownMenuItem(value: lang, child: Text(lang)),
                        )
                        .toList(),
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


