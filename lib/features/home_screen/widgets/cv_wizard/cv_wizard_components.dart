import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';

/// Circular step indicator used in the CV wizard header.
class CvStepIndicator extends StatelessWidget {
  const CvStepIndicator({required this.currentStep, required this.totalSteps, super.key});

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final steps = List.generate(totalSteps, (index) => index + 1);
    return Row(
      children: steps.map((step) {
        final isActive = step == currentStep;
        final isCompleted = step < currentStep;
        final color = isActive
            ? AppColors.purple
            : isCompleted
                ? AppColors.purpleDark.withValues(alpha: 0.6)
                : AppColors.pillBackground;
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$step',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (step != totalSteps)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 2,
                  color: AppColors.purple.withValues(alpha: 0.3),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/// Card wrapper with section title for wizard steps.
class CardWrapper extends StatelessWidget {
  const CardWrapper({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.15),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Reusable text field for CV wizard.
class CvTextField extends StatelessWidget {
  const CvTextField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.maxLines = 1,
    this.suffix,
    this.readOnly = false,
    this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? suffix;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

/// Primary filled button for wizard actions.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bannerGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Text(label),
      ),
    );
  }
}

/// List renderer for simple string entries (skills/phones, etc.).
class EntryList extends StatelessWidget {
  const EntryList({required this.entries, required this.onDelete, super.key});

  final List<String> entries;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          S.of(context).cvNoData,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
    return Column(
      children: [
        const SizedBox(height: 8),
        ...entries.asMap().entries.map(
          (entry) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(entry.value),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => onDelete(entry.key),
            ),
          ),
        ),
      ],
    );
  }
}

extension ListExt<E> on List<E> {
  E? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
