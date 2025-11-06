import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/featured_offer.dart';
import 'package:work_hub/features/home_screen/widgets/header_sliver_delegate.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/generated/l10n.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
    required this.galleryController,
    required this.currentImage,
    required this.onImageChanged,
    required this.searchController,
    required this.galleryImages,
    required this.categories,
    required this.featuredOffers,
  });

  final PageController galleryController;
  final int currentImage;
  final ValueChanged<int> onImageChanged;
  final TextEditingController searchController;
  final List<String> galleryImages;
  final List<String> categories;
  final List<FeaturedOffer> featuredOffers;

  static const double _headerBaseHeight = 130;
  static const double _searchOverlap = 28;
  static const double _headerExtent = _headerBaseHeight + _searchOverlap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final displayedImages = galleryImages.take(3).toList();
    return CustomScrollView(
      key: const PageStorageKey('home'),
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HeaderSliverDelegate(
            minHeight: _headerExtent,
            maxHeight: _headerExtent,
            builder: (context, shrinkOffset, overlapsContent) {
              return SizedBox.expand(
                child: CustomHeader(
                  title: s.appTitle,
                  showBackButton: false,
                  showMenuButton: true,
                  showNotificationButton: true,
                  showSearchBar: true,
                  searchController: searchController,
                  backgroundColor: AppColors.purple,
                  searchHint: s.searchHint,
                  height: _headerBaseHeight,
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 65),
              if (displayedImages.isNotEmpty) ...[
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: galleryController,
                    itemCount: displayedImages.length,
                    onPageChanged: onImageChanged,
                    itemBuilder: (context, index) {
                      final path = displayedImages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _GalleryImageCard(imagePath: path),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(displayedImages.length, (index) {
                    final bool isActive = index == currentImage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: isActive ? 28 : 10,
                      decoration: BoxDecoration(
                        color:
                            isActive ? AppColors.purple : AppColors.purpleMuted,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _GradientActionButton(
                      label: s.actionCreateResume,
                      icon: Icons.add,
                      colors: const [
                        AppColors.bannerGreen,
                        AppColors.bannerTeal,
                      ],
                    ),
                    const SizedBox(height: 16),
                    _GradientActionButton(
                      label: s.actionPostJob,
                      icon: Icons.work_outline,
                      colors: const [AppColors.purple, AppColors.bannerTeal],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Text(
                          s.sectionJobCategories,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(s.actionSeeMore),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        for (var i = 0; i < categories.length; i += 2) ...[
                          Row(
                            children: [
                              Expanded(
                                child: _CategoryCard(title: categories[i]),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child:
                                    i + 1 < categories.length
                                        ? _CategoryCard(
                                          title: categories[i + 1],
                                        )
                                        : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          if (i + 2 < categories.length)
                            const SizedBox(height: 12),
                        ],
                      ],
                    ),
                    if (featuredOffers.isNotEmpty) ...[
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Text(
                            s.sectionFeaturedOffers,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 170,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(right: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: featuredOffers.length,
                          separatorBuilder:
                              (context, index) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final offer = featuredOffers[index];
                            return _FeaturedOfferCard(offer: offer);
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.label,
    required this.icon,
    this.colors = const [AppColors.purple, AppColors.bannerGreen],
  });

  final String label;
  final IconData icon;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryImageCard extends StatelessWidget {
  const _GalleryImageCard({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.purple, AppColors.purpleDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      constraints: const BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

class _FeaturedOfferCard extends StatelessWidget {
  const _FeaturedOfferCard({required this.offer});

  final FeaturedOffer offer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: offer.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: offer.gradient.last.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                offer.badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              offer.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                offer.subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(offer.icon, color: AppColors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
