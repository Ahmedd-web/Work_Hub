import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AccountShimmer extends StatelessWidget {
  const AccountShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final baseColor =
        isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade300;
    final highlightColor =
        isDark ? Colors.white.withValues(alpha: 0.18) : Colors.grey.shade100;

    Widget shimmerBlock({double height = 20, double? width}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          const SizedBox(height: 24),
          shimmerBlock(height: 18, width: 160),
          const SizedBox(height: 16),
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  shimmerBlock(height: 38, width: 38),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBlock(height: 14, width: 120),
                        const SizedBox(height: 8),
                        shimmerBlock(height: 16, width: double.infinity),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          shimmerBlock(height: 18, width: 140),
          const SizedBox(height: 16),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ],
      ),
    );
  }
}
