import 'dart:async';

import 'package:flutter/material.dart';

class EmployerPromoBanner extends StatefulWidget {
  const EmployerPromoBanner({super.key});

  @override
  State<EmployerPromoBanner> createState() => EmployerPromoBannerState();
}

class EmployerPromoBannerState extends State<EmployerPromoBanner> {
  final controller = PageController(viewportFraction: 0.95);
  int currentIndex = 0;
  Timer? autoTimer;
  final List<String> images = const [
    'lib/assets/photo_1_2025-11-21_17-19-33.jpg',
    'lib/assets/photo_2_2025-11-21_17-19-33.jpg',
    'lib/assets/photo_3_2025-11-21_17-19-33.jpg',
  ];

  @override
  void initState() {
    super.initState();
    startAutoSlide();
  }

  void startAutoSlide() {
    autoTimer?.cancel();
    autoTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !controller.hasClients) return;
      final nextIndex = (currentIndex + 1) % images.length;
      controller.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() => currentIndex = nextIndex);
    });
  }

  @override
  void dispose() {
    autoTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorscheme = theme.colorScheme;
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: (i) => setState(() => currentIndex = i),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(images[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            final isActive = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: 6,
              decoration: BoxDecoration(
                color: colorscheme.primary.withValues(
                  alpha: isActive ? 0.9 : 0.4,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
