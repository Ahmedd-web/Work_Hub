import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/menuSheet/about_us.dart';
import 'package:work_hub/features/home_screen/menuSheet/ads_page.dart';
import 'package:work_hub/features/home_screen/menuSheet/contact_us.dart';
import 'package:work_hub/features/home_screen/menuSheet/menu_sheet.dart';
import 'package:work_hub/features/home_screen/menuSheet/privacy_page.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  final Color backgroundColor;

  final Color textColor;

  final bool showBackButton;

  final bool showMenuButton;

  final bool showNotificationButton;

  final bool showSearchBar;

  final VoidCallback? onBackPressed;

  final VoidCallback? onMenuPressed;

  final VoidCallback? onNotificationPressed;

  final ValueChanged<String>? onSearchSubmitted;

  final String searchHint;

  final TextEditingController? searchController;

  const CustomHeader({
    super.key,
    required this.title,
    this.backgroundColor = Colors.cyan,
    this.textColor = Colors.black,
    this.showBackButton = false,
    this.showMenuButton = false,
    this.showNotificationButton = false,
    this.showSearchBar = false,
    this.onBackPressed,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onSearchSubmitted,
    this.searchHint = 'Looking for a job..',
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    const double baseHeight = 200;

    const double searchBarHeight = 56;

    final double overlap = showSearchBar ? searchBarHeight / 2 : 0;

    return SizedBox(
      width: double.infinity,
      height: baseHeight + overlap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _CurvedHeaderPainter(color: backgroundColor),
            ),
          ),

          if (showBackButton || showMenuButton)
            Positioned(
              left: 8,
              top: 12,
              child: IconButton(
                icon: Icon(
                  showBackButton ? Icons.arrow_back : Icons.menu,
                  color: textColor,
                ),
                onPressed: () {
                  showWorkHubMenuSheet(
                    context,
                    onLanguageChanged: (lang) {},
                    items: [
                      MenuEntry(
                        icon: Icons.help_outline,
                        title: 'About Us',
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
                        title: 'Services Ads',
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
                        title: 'Contact us',
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
                        title: 'Privacy Policy and Terms of Use',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPage(),
                            ),
                          );
                        },
                      ),
                      MenuEntry(
                        icon: Icons.login,
                        title: 'Login',
                        onTap: () {
                          /* الذهاب لتسجيل الدخول */
                        },

                        iconColor: WorkHubColors.green,
                        textColor: WorkHubColors.green,
                      ),
                    ],
                  );
                  if (showBackButton) {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  } else if (showMenuButton) {
                    if (onMenuPressed != null) {
                      onMenuPressed!();
                    }
                  }
                },
              ),
            ),
          if (showNotificationButton)
            Positioned(
              right: 8,
              top: 12,
              child: IconButton(
                icon: Icon(Icons.notifications_none, color: textColor),
                onPressed: onNotificationPressed,
              ),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 40,
                bottom: showSearchBar ? searchBarHeight / 2 : 0,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          if (showSearchBar)
            Positioned(
              left: 24,
              right: 24,
              bottom: -searchBarHeight / 2,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(28),
                child: TextField(
                  controller: searchController,
                  onSubmitted: onSearchSubmitted,
                  decoration: InputDecoration(
                    hintText: searchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  final Color color;

  _CurvedHeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const double dipHeight = 46;
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
  bool shouldRepaint(covariant _CurvedHeaderPainter oldDelegate) =>
      oldDelegate.color != color;
}
