import 'package:flutter/material.dart';

/// Section container with title and body used on resume detail page.
class EmployerResumeSectionCard extends StatelessWidget {
  const EmployerResumeSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ],
    );
  }
}
