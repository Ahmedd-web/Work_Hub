import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerJobsTabs extends StatelessWidget {
  const EmployerJobsTabs({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final tabs = [
      s.employerJobsStatusActive,
      s.employerJobsStatusArchived,
      s.employerJobsStatusDeleted,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final text = entry.value;
            final active = currentIndex == index;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 8,
                  right: index == tabs.length - 1 ? 0 : 8,
                ),
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 44,
                    decoration: BoxDecoration(
                      color: active ? AppColors.purple : theme.cardColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: active ? Colors.transparent : AppColors.purple,
                      ),
                      boxShadow:
                          active
                              ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: TextStyle(
                        color:
                            active
                                ? Colors.white
                                : textTheme.bodyLarge?.color ??
                                    colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
