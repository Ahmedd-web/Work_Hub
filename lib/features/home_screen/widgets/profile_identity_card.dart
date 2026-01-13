import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

/// بطاقة الهوية في صفحة الملف الشخصي (تُستدعى داخل ProfileScaffold).
class ProfileIdentityCard extends StatelessWidget {
  const ProfileIdentityCard({
    super.key,
    required this.name,
    required this.initials,
    required this.photoUrl,
    required this.onUploadRequested,
    this.compact = false,
    this.minHeight = 120,
    this.avatarRadius = 42,
  });

  final String name;
  final String initials;
  final String photoUrl;
  final VoidCallback onUploadRequested;
  final bool compact;
  final double minHeight;
  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final double verticalPadding = compact ? 12 : 18;
    final double effectiveMinHeight = compact ? minHeight : 120;
    final double effectiveRadius =
        compact ? avatarRadius : math.max(avatarRadius, 42);
    final Color cameraBg =
        isDark ? theme.scaffoldBackgroundColor : Colors.white;
    final Color cameraIconColor = theme.colorScheme.primary;

    return Container(
      constraints: BoxConstraints(minHeight: effectiveMinHeight),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: effectiveRadius,
                backgroundColor: AppColors.pillBackground,
                backgroundImage:
                    photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                child:
                    photoUrl.isEmpty
                        ? Text(
                          initials,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.purple,
                          ),
                        )
                        : null,
              ),
              Positioned(
                bottom: -6,
                left: 0,
                child: GestureDetector(
                  onTap: onUploadRequested,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cameraBg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 14,
                      color: cameraIconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.textTheme.titleMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
