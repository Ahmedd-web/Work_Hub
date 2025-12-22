import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/generated/l10n.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => AdsPageState();
}

class AdsPageState extends State<AdsPage> {
  int selectedIndex = 1;
  late final List<AdPackage> packages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = S.of(context);
    packages = [
      AdPackage(
        title: s.servicesPkg50Title,
        price: s.servicesPkg50Price,
        perks: [
          s.servicesPerkVis7,
          s.servicesPerkResume20,
          s.servicesPerkEdits1,
        ],
      ),
      AdPackage(
        title: s.servicesPkg100Title,
        price: s.servicesPkg100Price,
        perks: [
          s.servicesPerkPosts3,
          s.servicesPerkFeatured3,
          s.servicesPerkResume25,
        ],
      ),
      AdPackage(
        title: s.servicesPkg150Title,
        price: s.servicesPkg150Price,
        perks: [
          s.servicesPerkPosts5,
          s.servicesPerkBoosted,
          s.servicesPerkSupport,
        ],
      ),
      AdPackage(
        title: s.servicesPkg200Title,
        price: s.servicesPkg200Price,
        perks: [
          s.servicesPerkPosts8,
          s.servicesPerkFeaturedBoost,
          s.servicesPerkResumeViews,
        ],
      ),
      AdPackage(
        title: s.servicesPkg250Title,
        price: s.servicesPkg250Price,
        perks: [
          s.servicesPerkPosts12,
          s.servicesPerkDedicatedMgr,
          s.servicesPerkVip,
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              colorScheme: colorScheme,
              title: s.servicesHeaderTitle,
              subtitle: s.servicesHeaderSubtitle,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionTitle(s.servicesSectionTitle),
                    const SizedBox(height: 12),
                    InfoCard(
                      title: s.servicesInfo1Title,
                      subtitle: s.servicesInfo1Desc,
                      icon: Icons.workspace_premium_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    InfoCard(
                      title: s.servicesInfo2Title,
                      subtitle: s.servicesInfo2Desc,
                      icon: Icons.campaign_outlined,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(height: 12),
                    InfoCard(
                      title: s.servicesInfo3Title,
                      subtitle: s.servicesInfo3Desc,
                      icon: Icons.design_services_outlined,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(height: 24),
                    SectionTitle(s.servicesPackagesTitle),
                    const SizedBox(height: 12),
                    ...List.generate(packages.length, (index) {
                      final pack = packages[index];
                      final isSelected = selectedIndex == index;
                      final baseAccent =
                          isDark ? Colors.green.shade500 : colorScheme.primary;
                      final accent = isSelected
                          ? baseAccent
                          : (isDark
                              ? Colors.green.shade400
                              : colorScheme.primary.withValues(alpha: 0.6));
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == packages.length - 1 ? 0 : 12,
                        ),
                        child: PackageCard(
                          title: pack.title,
                          price: pack.price,
                          perks: pack.perks,
                          accent: accent,
                          highlight: isSelected,
                          onTap: () => setState(() => selectedIndex = index),
                        ),
                      );
                    }),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).maybePop(),
                        child: Text(
                          s.servicesChoosePlan,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.subtitle,
  });

  final ColorScheme colorScheme;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppAssets.headerLogo,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.title,
    required this.price,
    required this.perks,
    required this.accent,
    this.highlight = false,
    this.onTap,
  });

  final String title;
  final String price;
  final List<String> perks;
  final Color accent;
  final bool highlight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: highlight
              ? Border.all(color: accent, width: 1.5)
              : Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: highlight ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    price,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...perks.map(
              (perk) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      highlight ? Icons.check_circle : Icons.circle_outlined,
                      color: accent,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        perk,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      textAlign: TextAlign.start,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class AdPackage {
  final String title;
  final String price;
  final List<String> perks;
  const AdPackage({
    required this.title,
    required this.price,
    required this.perks,
  });
}
