import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/menu_language_pill.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/menu_membership_tile.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/menu_pill_tile.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/menu_theme_toggle.dart';
import 'package:work_hub/generated/l10n.dart';

class WorkHubColors {
  static const purple = AppColors.purple;
  static const green = AppColors.secondary;
  static const pillBg = AppColors.pillBackground;
}

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

class MembershipTileData {
  final String title;
  final String statusText;
  final VoidCallback onTap;
  final Color? statusColor;

  const MembershipTileData({
    required this.title,
    required this.statusText,
    required this.onTap,
    this.statusColor,
  });
}

Future<void> showWorkHubMenuSheet(
  BuildContext context, {
  String? currentLanguage,
  List<String>? languages,
  required ValueChanged<String> onLanguageChanged,
  required bool isDarkMode,
  required ValueChanged<bool> onThemeModeChanged,

  required List<MenuEntry> items,

  MembershipTileData? membershipTile,

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
  final pillColor =
      theme.brightness == Brightness.dark
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
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            margin: EdgeInsets.only(top: media.size.height * 0.08),
            decoration: BoxDecoration(
              color: effectiveBackground,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
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
                Container(
                  width: 56,
                  height: 6,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                MenuLanguagePill(
                  value: resolvedCurrent,
                  options: options,
                  onChanged: onLanguageChanged,
                ),

                const SizedBox(height: 14),
                MenuThemeToggle(
                  isDarkMode: isDarkMode,
                  onChanged: onThemeModeChanged,
                  rootContext: context,
                ),

                const SizedBox(height: 14),

                if (membershipTile != null) ...[
                  MenuMembershipTile(data: membershipTile!),
                  const SizedBox(height: 14),
                ],

                ...items.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: MenuPillTile(
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
        ),
      );
    },
  );
}

class ThemeModeToggle extends StatelessWidget {
  const ThemeModeToggle({required this.isDarkMode, required this.onChanged});

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final s = S.of(context);

    final backgroundColor =
        theme.brightness == Brightness.dark
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
            onChanged: (val) {
              Navigator.of(context).pop();
              onChanged(val);
            },
          ),
        ],
      ),
    );
  }
}

class PillTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color backgroundColor;

  const PillTile({
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
    final borderRadius = BorderRadius.circular(32);
    final Color appliedBackground =
        backgroundColor ??
        (theme.brightness == Brightness.dark
            ? theme.colorScheme.surface.withValues(alpha: 0.2)
            : AppColors.pillBackground);

    return Material(
      color: appliedBackground,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: borderRadius,
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
                  style:
                      style ??
                      const TextStyle(
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

class MembershipTile extends StatelessWidget {
  const MembershipTile({required this.data});

  final MembershipTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark
            ? colorScheme.surfaceVariant.withValues(alpha: 0.3)
            : Colors.white;
    final borderColor =
        isDark
            ? Colors.white.withValues(alpha: 0.08)
            : colorScheme.primary.withValues(alpha: 0.08);
    final badgeColor = data.statusColor ?? AppColors.bannerGreen;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: borderColor),
          boxShadow:
              isDark
                  ? null
                  : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: data.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Text(
                          data.statusText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguagePill extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const LanguagePill({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final s = S.of(context);
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.textTheme.bodyMedium?.color ?? colorScheme.onSurface,
    );
    final pillBackground =
        theme.brightness == Brightness.dark
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
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () => showLanguageSheet(context, options, s),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text(
                      value,
                      style:
                          textStyle ??
                          const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: theme.iconTheme.color ?? AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showLanguageSheet(
    BuildContext context,
    List<String> options,
    S s,
  ) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final media = MediaQuery.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (_) => SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: media.size.height * 0.15),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 18,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Text(
                    s.languageArabic == value
                        ? 'اختيار اللغة'
                        : 'Choose language',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...options.map(
                    (lang) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => Navigator.of(context).pop(lang),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    lang == value
                                        ? colorScheme.primary
                                        : colorScheme.outline.withValues(
                                          alpha: 0.2,
                                        ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  lang == value
                                      ? Icons.check_circle
                                      : Icons.language,
                                  color:
                                      lang == value
                                          ? colorScheme.primary
                                          : colorScheme.outline,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    lang,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
    if (selected != null) {
      onChanged(selected);
    }
  }
}
