import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return FloatingActionButton(
      backgroundColor: theme.cardColor,
      foregroundColor: colorScheme.primary,
      onPressed: onTap,
      child: Icon(Icons.edit, color: colorScheme.primary),
    );
  }
}
