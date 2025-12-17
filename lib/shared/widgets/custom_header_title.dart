// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:flutter/material.dart';

class CustomHeaderTitle extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final Color effectiveTextColor;
  final bool hasOverlayChild;
  final double overlayChildHeight;

  const CustomHeaderTitle({
    super.key,
    required this.title,
    required this.titleWidget,
    required this.effectiveTextColor,
    required this.hasOverlayChild,
    required this.overlayChildHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
