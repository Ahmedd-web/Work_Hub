import 'package:flutter/widgets.dart';

typedef HeaderBuilder =
    Widget Function(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
    );

class HeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  HeaderSliverDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  }) : assert(maxHeight >= minHeight, 'maxHeight must be >= minHeight');

  final double minHeight;
  final double maxHeight;
  final HeaderBuilder builder;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(covariant HeaderSliverDelegate oldDelegate) {
    // Rebuild whenever any input might have changed (e.g., localization text).
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        builder != oldDelegate.builder;
  }
}
