import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class CompanyAboutSection extends StatelessWidget {
  const CompanyAboutSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final aboutAr = data['about'] as String? ?? '';
    final aboutEn = data['about_en'] as String? ?? '';
    final s = S.of(context);
    return Column(
      children: [
        AboutSummaryTile(label: s.employerAccountAboutArabic, value: aboutAr),
        const SizedBox(height: 14),
        AboutSummaryTile(label: s.employerAccountAboutEnglish, value: aboutEn),
      ],
    );
  }
}

class AboutSummaryTile extends StatelessWidget {
  const AboutSummaryTile({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            value.isEmpty ? '-' : value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
