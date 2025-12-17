// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:flutter/material.dart';

class CustomHeaderHero extends StatelessWidget {
  final Widget heroChild;
  final double heroChildHeight;

  const CustomHeaderHero({
    super.key,
    required this.heroChild,
    required this.heroChildHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: -heroChildHeight / 2,
      child: SizedBox(height: heroChildHeight, child: heroChild),
    );
  }
}
