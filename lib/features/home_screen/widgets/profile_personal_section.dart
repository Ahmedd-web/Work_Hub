import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/features/home_screen/models/profile_data.dart';

class ProfilePersonalSection extends StatelessWidget {
  const ProfilePersonalSection({super.key, required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          InfoRow(label: s.profileNameLabel, value: data.fullName),
          const Divider(height: 24),
          InfoRow(label: s.profilePhone, value: data.phone),
          const Divider(height: 24),
          InfoRow(label: s.profileEmail, value: data.email),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value.isEmpty ? '-' : value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    );
  }
}
