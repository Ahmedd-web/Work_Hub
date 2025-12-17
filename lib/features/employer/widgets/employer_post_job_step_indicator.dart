// Used in EmployerPostJobPage to show step progress at the top of the form.
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

class EmployerPostJobStepIndicator extends StatelessWidget {
  const EmployerPostJobStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  final int steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps, (index) {
        final isActive = index == currentStep;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? AppColors.purple : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }
}
