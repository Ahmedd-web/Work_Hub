// Used in EmployerPremiumPlansPage as the golden header chip inside CustomHeader overlay.
import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerPremiumHeaderChip extends StatelessWidget {
  const EmployerPremiumHeaderChip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFD0A446),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.workspace_premium,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            s.employerPremiumHeaderLabel,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
