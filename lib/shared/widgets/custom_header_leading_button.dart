// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/employer_session.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_membership_page.dart';
import 'package:work_hub/features/home_screen/menuSheet/about_us.dart';
import 'package:work_hub/features/home_screen/menuSheet/ads_page.dart';
import 'package:work_hub/features/home_screen/menuSheet/contact_us.dart';
import 'package:work_hub/features/home_screen/menuSheet/menu_sheet.dart';
import 'package:work_hub/features/home_screen/menuSheet/privacy_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/main.dart';

class CustomHeaderLeadingButton extends StatelessWidget {
  final bool showBackButton;
  final bool showMenuButton;
  final Color effectiveTextColor;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final Future<void> Function(BuildContext context) onDeleteAccount;

  const CustomHeaderLeadingButton({
    super.key,
    required this.showBackButton,
    required this.showMenuButton,
    required this.effectiveTextColor,
    required this.onDeleteAccount,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: 8,
      top: 24,
      child: IconButton(
        iconSize: 30,
        icon:
            showBackButton
                ? IconTheme(
                  data: IconThemeData(color: effectiveTextColor),
                  child: const BackButtonIcon(),
                )
                : Icon(Icons.menu, color: effectiveTextColor),
        onPressed: () => _handlePress(context),
      ),
    );
  }

  Future<void> _handlePress(BuildContext context) async {
    if (showBackButton) {
      if (onBackPressed != null) {
        onBackPressed!();
      } else {
        Navigator.of(context).maybePop();
      }
      return;
    }

    if (!showMenuButton) {
      return;
    }

    if (onMenuPressed != null) {
      onMenuPressed!();
      return;
    }

    final s = S.of(context);
    final appState = MyApp.of(context);
    final locale = Localizations.localeOf(context);
    final languages = [s.languageEnglish, s.languageArabic];
    final currentLanguage =
        locale.languageCode == 'ar' ? languages[1] : languages[0];
    final isDarkMode =
        (appState?.themeMode ?? ThemeMode.light) == ThemeMode.dark;
    final isEmployerUser = await EmployerSession.isEmployer();
    final membershipTile =
        isEmployerUser
            ? MembershipTileData(
              title: s.menuMembershipTitle,
              statusText: s.menuMembershipStatusFree,
              statusColor: AppColors.bannerGreen,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const EmployerMembershipPage(),
                  ),
                );
              },
            )
            : null;

    showWorkHubMenuSheet(
      context,
      currentLanguage: currentLanguage,
      languages: languages,
      onLanguageChanged: (lang) {
        final Locale newLocale =
            lang == s.languageArabic ? const Locale('ar') : const Locale('en');
        appState?.setLocale(newLocale);
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      isDarkMode: isDarkMode,
      onThemeModeChanged: (value) {
        appState?.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      membershipTile: membershipTile,
      items: [
        MenuEntry(
          icon: Icons.help_outline,
          title: s.menuAbout,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AboutUsPage()),
            );
          },
        ),
        MenuEntry(
          icon: Icons.campaign_outlined,
          title: s.menuServicesAds,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AdsPage()),
            );
          },
        ),
        MenuEntry(
          icon: Icons.phone_in_talk_outlined,
          title: s.menuContact,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ContactUsPage()),
            );
          },
        ),
        MenuEntry(
          icon: Icons.privacy_tip_outlined,
          title: s.menuPrivacy,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PrivacyPage()),
            );
          },
        ),
        MenuEntry(
          icon: Icons.delete_forever,
          title: s.menuDeleteAccount,
          onTap: () => onDeleteAccount(context),
          iconColor: Colors.redAccent,
          textColor: Colors.redAccent,
        ),
        MenuEntry(
          icon: Icons.logout,
          title: s.menuLogout,
          onTap: () async {
            final navigator = Navigator.of(context);
            await FirebaseAuth.instance.signOut();
            navigator.pushNamedAndRemoveUntil("login", (route) => false);
          },
          iconColor: WorkHubColors.green,
          textColor: WorkHubColors.green,
        ),
      ],
    );
  }
}
