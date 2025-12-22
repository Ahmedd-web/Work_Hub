// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:flutter/material.dart';

class CustomHeaderNotificationButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final int? badgeCount;

  const CustomHeaderNotificationButton({
    super.key,
    required this.color,
    this.onPressed,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final showBadge = (badgeCount ?? 0) > 0;
    return PositionedDirectional(
      end: 8,
      top: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.notifications_none, color: color),
            onPressed: onPressed,
          ),
          if (showBadge)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Center(
                  child: Text(
                    badgeCount! > 99 ? '99+' : '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
