import 'dart:math' as math;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class CustomHeader extends StatelessWidget {
  final String title;

  final double? height;

  final Color? backgroundColor;

  final Color? textColor;

  final bool showBackButton;

  final bool showMenuButton;

  final bool showNotificationButton;

  final bool showSearchBar;

  final VoidCallback? onBackPressed;

  final VoidCallback? onMenuPressed;

  final VoidCallback? onNotificationPressed;

  final ValueChanged<String>? onSearchSubmitted;

  final String? searchHint;

  final TextEditingController? searchController;
  final Widget? overlayChild;
  final double? overlayHeight;
  final String? backgroundImage;
  final BoxFit backgroundImageFit;
  final Widget? titleWidget;
  final Widget? heroChild;
  final double? heroHeight;

  const CustomHeader({
    super.key,
    required this.title,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.showBackButton = false,
    this.showMenuButton = false,
    this.showNotificationButton = false,
    this.showSearchBar = false,
    this.onBackPressed,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onSearchSubmitted,
    this.searchHint,
    this.searchController,
    this.overlayChild,
    this.overlayHeight,
    this.backgroundImage,
    this.backgroundImageFit = BoxFit.cover,
    this.titleWidget,
    this.heroChild,
    this.heroHeight,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    final bool isArabic = locale.languageCode == 'ar';
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final textAlign = isArabic ? TextAlign.right : TextAlign.left;
    final effectiveBackground = backgroundColor ?? colorScheme.primary;
    final effectiveTextColor = textColor ?? colorScheme.onPrimary;
    final searchFillColor =
        theme.inputDecorationTheme.fillColor ?? colorScheme.surface;
    const double defaultSearchBarHeight = 56;
    final bool hasOverlayChild = overlayChild != null || showSearchBar;
    final bool hasHeroChild = heroChild != null;
    final bool useImageBackground =
        backgroundImage != null && backgroundImage!.isNotEmpty;
    final double overlayChildHeight =
        overlayChild != null ? (overlayHeight ?? 120) : defaultSearchBarHeight;
    final double heroChildHeight = heroChild != null ? (heroHeight ?? 140) : 0;
    final double overlap = [
      hasOverlayChild ? overlayChildHeight / 2 : 0.0,
      hasHeroChild ? heroChildHeight / 2 : 0.0,
    ].reduce(math.max);
    final double baseHeight = height ?? 200;
    final double totalHeight = baseHeight + overlap;

    return SizedBox(
      width: double.infinity,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (useImageBackground)
            Positioned.fill(
              child: ClipPath(
                clipper: CurvedHeaderClipper(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(backgroundImage!, fit: backgroundImageFit),
                    Container(
                      color: effectiveBackground.withValues(alpha: 0.25),
                    ),
                  ],
                ),
              ),
            )
          else
            Positioned.fill(
              child: CustomPaint(
                painter: CurvedHeaderPainter(color: effectiveBackground),
              ),
            ),

          if (showBackButton || showMenuButton)
            PositionedDirectional(
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
                onPressed: () async {
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

                  final appState = MyApp.of(context);
                  final locale = Localizations.localeOf(context);
                  final languages = [s.languageEnglish, s.languageArabic];
                  final currentLanguage =
                      locale.languageCode == 'ar' ? languages[1] : languages[0];
                  final isDarkMode =
                      (appState?.themeMode ?? ThemeMode.light) ==
                      ThemeMode.dark;
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
                                  builder:
                                      (_) => const EmployerMembershipPage(),
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
                          lang == s.languageArabic
                              ? const Locale('ar')
                              : const Locale('en');
                      appState?.setLocale(newLocale);
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    isDarkMode: isDarkMode,
                    onThemeModeChanged: (value) {
                      appState?.setThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
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
                            MaterialPageRoute(
                              builder: (context) => const AboutUsPage(),
                            ),
                          );
                        },
                      ),
                      MenuEntry(
                        icon: Icons.campaign_outlined,
                        title: s.menuServicesAds,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AdsPage(),
                            ),
                          );
                        },
                      ),
                      MenuEntry(
                        icon: Icons.phone_in_talk_outlined,
                        title: s.menuContact,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ContactUsPage(),
                            ),
                          );
                        },
                      ),
                      MenuEntry(
                        icon: Icons.privacy_tip_outlined,
                        title: s.menuPrivacy,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPage(),
                            ),
                          );
                        },
                      ),
                      MenuEntry(
                        icon: Icons.delete_forever,
                        title: s.menuDeleteAccount,
                        onTap: () => handleDeleteAccount(context),
                        iconColor: Colors.redAccent,
                        textColor: Colors.redAccent,
                      ),
                      MenuEntry(
                        icon: Icons.logout,
                        title: s.menuLogout,
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await FirebaseAuth.instance.signOut();
                          navigator.pushNamedAndRemoveUntil(
                            "login",
                            (route) => false,
                          );
                        },

                        iconColor: WorkHubColors.green,
                        textColor: WorkHubColors.green,
                      ),
                    ],
                  );
                },
              ),
            ),
          if (showNotificationButton)
            PositionedDirectional(
              end: 8,
              top: 24,
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.notifications_none, color: effectiveTextColor),
                onPressed: onNotificationPressed,
              ),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 40,
                bottom: hasOverlayChild ? overlayChildHeight / 2 : 0,
              ),
              child:
                  titleWidget ??
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: 0.85 + (0.15 * value),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: effectiveTextColor,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
            ),
          ),
          if (hasOverlayChild)
            Positioned(
              left: 24,
              right: 24,
              bottom: -overlayChildHeight / 2,
              child:
                  overlayChild != null
                      ? SizedBox(
                        height: overlayChildHeight,
                        child: overlayChild,
                      )
                      : Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(28),
                        child: SizedBox(
                          height: overlayChildHeight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: TextField(
                              controller: searchController,
                              onSubmitted: onSearchSubmitted,
                              textDirection: textDirection,
                              textAlign: textAlign,
                              decoration: InputDecoration(
                                hintText: searchHint ?? s.searchHint,
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: searchFillColor,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            ),
          if (hasHeroChild)
            Positioned(
              left: 24,
              right: 24,
              bottom: -heroChildHeight / 2,
              child: SizedBox(height: heroChildHeight, child: heroChild),
            ),
        ],
      ),
    );
  }
}

Future<void> handleDeleteAccount(BuildContext context) async {
  final s = S.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    messenger.showSnackBar(SnackBar(content: Text(s.profileNoData)));
    return;
  }

  bool confirmed = false;
  await AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: s.deleteAccountTitle,
    desc: s.deleteAccountMessage,
    btnCancelText: s.commonCancel,
    btnCancelOnPress: () => confirmed = false,
    btnOkText: s.commonOk,
    btnOkOnPress: () => confirmed = true,
  ).show();
  if (!confirmed) return;

  if (!context.mounted) return;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    await FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.uid)
        .delete()
        .catchError((_) {});
    await user.delete();
  } on FirebaseAuthException catch (e) {
    navigator.pop();
    final message =
        e.code == 'requires-recent-login'
            ? s.deleteAccountReauth
            : (e.message ?? s.dialogErrorTitle);
    messenger.showSnackBar(SnackBar(content: Text(message)));
    return;
  } catch (e) {
    navigator.pop();
    messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    return;
  }

  navigator.pop();
  if (!context.mounted) return;
  await AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    title: s.deleteAccountTitle,
    desc: s.deleteAccountSuccess,
    btnOkText: s.commonOk,
    btnOkOnPress: () {},
  ).show();
  navigator.pushNamedAndRemoveUntil("login", (route) => false);
}

class CurvedHeaderPainter extends CustomPainter {
  final Color color;

  CurvedHeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final double sideY = size.height - 52;

    final Path path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, sideY)
          ..quadraticBezierTo(
            size.width,
            size.height,
            size.width * 0.5,
            size.height,
          )
          ..quadraticBezierTo(0, size.height, 0, sideY)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CurvedHeaderPainter oldDelegate) =>
      oldDelegate.color != color;
}

class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double sideY = size.height - 52;
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, sideY)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width * 0.5,
        size.height,
      )
      ..quadraticBezierTo(0, size.height, 0, sideY)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
