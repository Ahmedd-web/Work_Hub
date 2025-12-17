// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:flutter/material.dart';

class CustomHeaderNotificationButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;

  const CustomHeaderNotificationButton({
    super.key,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 8,
      top: 24,
      child: IconButton(
        iconSize: 30,
        icon: Icon(Icons.notifications_none, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
