import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

class EmployerJobMetricChip extends StatelessWidget {
  const EmployerJobMetricChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.purple),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
