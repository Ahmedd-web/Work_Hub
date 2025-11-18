import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

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
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavIcon(
            icon: Icons.person_outline,
            label: 'الحساب',
            active: currentIndex == 3,
            activeColor: AppColors.purple,
            onTap: () => onChanged(3),
          ),
          _BottomNavIcon(
            icon: Icons.work_outline,
            label: 'وظائف',
            active: currentIndex == 1,
            activeColor: AppColors.purple,
            onTap: () => onChanged(1),
          ),
          _BottomNavIcon(
            icon: Icons.receipt_long_outlined,
            label: 'سير ذاتية',
            active: currentIndex == 2,
            activeColor: AppColors.purple,
            onTap: () => onChanged(2),
          ),
          _BottomNavIcon(
            icon: Icons.home_outlined,
            label: 'الرئيسية',
            active: currentIndex == 0,
            activeColor: const Color(0xFF2DAB4D),
            highlightColor: const Color(0xFFE4F8E8),
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
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final Color activeColor;
  final Color? highlightColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? activeColor : const Color(0xFF3F1F61);
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              active
                  ? (highlightColor ?? activeColor.withValues(alpha: 0.12))
                  : Colors.transparent,
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

