import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmployerJobCardShimmer extends StatelessWidget {
  const EmployerJobCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final baseColor =
        isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade300;
    final highlightColor =
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
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                shimmerLine(width: 100),
                const Spacer(),
                Container(
                  width: 70,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerLine(height: 18, width: double.infinity),
                      const SizedBox(height: 8),
                      shimmerLine(width: 140),
                      const SizedBox(height: 6),
                      shimmerLine(width: 120),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
