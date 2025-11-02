import 'package:flutter/material.dart';

class FeaturedOffer {
  const FeaturedOffer({
    required this.title,
    required this.subtitle,
    required this.badge,
    this.gradient = const [Color(0xFF5C239D), Color(0xFF37B26C)],
    this.icon = Icons.trending_up,
  });

  final String title;
  final String subtitle;
  final String badge;
  final List<Color> gradient;
  final IconData icon;
}
