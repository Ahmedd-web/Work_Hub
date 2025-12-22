import 'package:flutter/material.dart';

/// Card displaying labeled rows of job/company details.
class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.items});

  final List<DetailItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withValues(alpha: 0.6);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            DetailRow(label: items[i].label, value: items[i].value),
            if (i != items.length - 1) Divider(height: 1, color: borderColor),
          ],
        ],
      ),
    );
  }
}

/// A single label/value row inside DetailsCard.
class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final secondaryColor = textTheme.bodyMedium?.color?.withValues(alpha: 0.7);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Model representing a single detail row.
class DetailItem {
  const DetailItem({required this.label, required this.value});

  final String label;
  final String value;
}
