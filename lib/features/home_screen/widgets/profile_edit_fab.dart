import 'package:flutter/material.dart';

/// زر تعديل عائم في التبويب الشخصي.
class ProfileEditFab extends StatelessWidget {
  const ProfileEditFab({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shape: const CircleBorder(),
      color: backgroundColor,
      child: IconButton(
        icon: Icon(Icons.edit, color: iconColor),
        onPressed: onTap,
      ),
    );
  }
}
