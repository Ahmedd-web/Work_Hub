import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

/// ألوان قابلة للتعديل سريعًا
class WorkHubColors {
  static const purple = Color(0xFF4B1E82); // عدّل البنفسجي حسب هويتك
  static const green = Color(0xFF31B24A);
  static const pillBg = Color(0xFFF2F3F5); // خلفية العناصر
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

  // بقية العناصر
  required List<MenuEntry> items,

  // خيارات شكلية
  Color backgroundColor = Colors.white,
}) {
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
            color: backgroundColor,
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
                  color: Colors.black12,
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

              // قائمة العناصر
              ...items.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _PillTile(
                    leading: Icon(
                      e.icon,
                      color: e.iconColor ?? WorkHubColors.purple,
                      size: 26,
                    ),
                    title: e.title,
                    textColor: e.textColor ?? const Color(0xFF3D3D3D),
                    onTap: e.onTap,
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
class _PillTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;
  final Color textColor;

  const _PillTile({
    required this.leading,
    required this.title,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WorkHubColors.pillBg,
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
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
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
    return Container(
      decoration: BoxDecoration(
        color: WorkHubColors.pillBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 4),
          const Icon(Icons.language, color: WorkHubColors.purple),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3D3D3D),
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


