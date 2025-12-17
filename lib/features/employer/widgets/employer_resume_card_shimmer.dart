import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton placeholder for resume cards while loading.
class EmployerResumeCardShimmer extends StatelessWidget {
  const EmployerResumeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color baseColor =
        isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade300;
    final Color highlightColor =
        isDark ? Colors.white.withValues(alpha: 0.2) : Colors.grey.shade100;

    Widget shimmerLine({double height = 14, double? width}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerLine(height: 16, width: double.infinity),
                      const SizedBox(height: 8),
                      shimmerLine(height: 14, width: double.infinity),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            shimmerLine(height: 14, width: 120),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                3,
                (index) => Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: shimmerLine(height: 44)),
                const SizedBox(width: 12),
                Expanded(child: shimmerLine(height: 44)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
