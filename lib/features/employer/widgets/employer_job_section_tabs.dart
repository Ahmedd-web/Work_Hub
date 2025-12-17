import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

class EmployerJobSectionTabs extends StatelessWidget {
  const EmployerJobSectionTabs({super.key, required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final tabs = ['تفاصيل الوظيفة', 'وصف الوظيفة', 'معلومات إضافية'];
    return Row(
      children: List.generate(tabs.length, (i) {
        final active = i == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              margin: EdgeInsets.only(right: i == tabs.length - 1 ? 0 : 8),
              height: 44,
              decoration: BoxDecoration(
                color: active ? AppColors.purple : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: active ? Colors.transparent : AppColors.purple,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                tabs[i],
                style: TextStyle(
                  color: active ? Colors.white : AppColors.purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
