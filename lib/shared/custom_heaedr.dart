import 'dart:math' as math;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';
import 'widgets/custom_header_background.dart';
import 'widgets/custom_header_hero.dart';
import 'widgets/custom_header_leading_button.dart';
import 'widgets/custom_header_notification_button.dart';
import 'widgets/custom_header_overlay.dart';
import 'widgets/custom_header_title.dart';

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
          CustomHeaderBackground(
            useImageBackground: useImageBackground,
            backgroundImage: backgroundImage,
            backgroundImageFit: backgroundImageFit,
            effectiveBackground: effectiveBackground,
          ),
          if (showBackButton || showMenuButton)
            CustomHeaderLeadingButton(
              showBackButton: showBackButton,
              showMenuButton: showMenuButton,
              effectiveTextColor: effectiveTextColor,
              onBackPressed: onBackPressed,
              onMenuPressed: onMenuPressed,
              onDeleteAccount: handleDeleteAccount,
            ),
          if (showNotificationButton)
            CustomHeaderNotificationButton(
              color: effectiveTextColor,
              onPressed: onNotificationPressed,
            ),
          CustomHeaderTitle(
            title: title,
            titleWidget: titleWidget,
            effectiveTextColor: effectiveTextColor,
            hasOverlayChild: hasOverlayChild,
            overlayChildHeight: overlayChildHeight,
          ),
          if (hasOverlayChild)
            CustomHeaderOverlay(
              overlayChild: overlayChild,
              overlayChildHeight: overlayChildHeight,
              searchController: searchController,
              onSearchSubmitted: onSearchSubmitted,
              searchHint: searchHint ?? s.searchHint,
              textDirection: textDirection,
              textAlign: textAlign,
              searchFillColor: searchFillColor,
            ),
          if (hasHeroChild)
            CustomHeaderHero(
              heroChild: heroChild!,
              heroChildHeight: heroChildHeight,
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
