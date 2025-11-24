import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerBottomNav extends StatelessWidget {
  const EmployerBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final s = S.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        theme.bottomNavigationBarTheme.backgroundColor ??
        (isDark ? colorScheme.surface : Colors.white);
    final shadowColor = Colors.transparent;
    final homeHighlight =
        isDark
            ? const Color(0x332DAB4D)
            : const Color(0xFFE4F8E8);

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavIcon(
            icon: Icons.person_outline,
            label: s.employerNavAccount,
            active: currentIndex == 3,
            activeColor: AppColors.bannerGreen,
            isDark: isDark,
            onTap: () => onChanged(3),
          ),
          _BottomNavIcon(
            icon: Icons.work_outline,
            label: s.employerNavJobs,
            active: currentIndex == 1,
            activeColor: AppColors.bannerGreen,
            isDark: isDark,
            onTap: () => onChanged(1),
          ),
          _BottomNavIcon(
            icon: Icons.receipt_long_outlined,
            label: s.employerNavResumes,
            active: currentIndex == 2,
            activeColor: AppColors.bannerGreen,
            isDark: isDark,
            onTap: () => onChanged(2),
          ),
          _BottomNavIcon(
            icon: Icons.home_outlined,
            label: s.employerNavHome,
            active: currentIndex == 0,
            activeColor: AppColors.bannerGreen,
            highlightColor: homeHighlight,
            isDark: isDark,
            onTap: () => onChanged(0),
          ),
        ],
      ),
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  const _BottomNavIcon({
    required this.icon,
    required this.label,
    required this.active,
    required this.activeColor,
    this.highlightColor,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final Color activeColor;
  final Color? highlightColor;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inactiveColor =
        isDark
            ? Colors.white.withValues(alpha: 0.85)
            : const Color(0xFF3F1F61);
    final color = active ? activeColor : inactiveColor;
    final backgroundColor =
        active
            ? (highlightColor ??
                activeColor.withValues(alpha: isDark ? 0.25 : 0.12))
            : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
