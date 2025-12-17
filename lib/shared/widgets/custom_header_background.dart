// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:flutter/material.dart';

class CustomHeaderBackground extends StatelessWidget {
  final String backgroundImage;
  final BoxFit backgroundImageFit;
  final Color effectiveBackground;

  const CustomHeaderBackground({
    super.key,
    required this.backgroundImage,
    required this.backgroundImageFit,
    required this.effectiveBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipPath(
        clipper: CurvedHeaderClipper(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(backgroundImage, fit: backgroundImageFit),
            Container(color: effectiveBackground.withValues(alpha: 0.25)),
          ],
        ),
      ),
    );
  }
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
