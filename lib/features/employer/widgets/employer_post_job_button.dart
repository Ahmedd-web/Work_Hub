import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerPostJobButton extends StatelessWidget {
  const EmployerPostJobButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isarabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isarabic ? ar : en;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        gradient: const LinearGradient(
          colors: [Color(0xFF24A268), Color(0xFF5F1C8E)],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(38),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  S.of(context).employerPostJobCta,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
