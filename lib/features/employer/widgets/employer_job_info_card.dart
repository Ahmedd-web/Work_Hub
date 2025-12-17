import 'package:flutter/material.dart';

class EmployerJobInfoCard extends StatelessWidget {
  const EmployerJobInfoCard({super.key, required this.title, this.items, this.description});

  final String title;
  final List<EmployerJobInfoRow>? items;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (items != null)
            ...items!.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.label,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Text(
                      item.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (description != null)
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }
}

class EmployerJobInfoRow {
  const EmployerJobInfoRow({required this.label, required this.value});

  final String label;
  final String value;
}
