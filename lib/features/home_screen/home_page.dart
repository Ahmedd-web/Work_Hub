import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/featured_offer.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/widgets/home_tab.dart';
import 'package:work_hub/features/home_screen/widgets/jobs_tab.dart';
import 'package:work_hub/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> _galleryImages = [
    'lib/assets/photo_2025-11-06_14-31-56.jpg',
    'lib/assets/photo_2025-11-06_14-00-46.jpg',
    'lib/assets/photo_2025-11-06_13-10-55.jpg',
  ];

  final PageController _galleryController = PageController(
    viewportFraction: 0.9,
  );
  final TextEditingController _homeSearchController = TextEditingController();
  final TextEditingController _jobSearchController = TextEditingController();

  List<String> _buildJobCategories(S s) => [
    s.categoryInternationalOrganizations,
    s.categorySales,
    s.categoryAdministration,
    s.categoryEngineering,
    s.categoryDesigner,
    s.categoryProgramming,
    s.categoryMarketing,
    s.categoryCustomerSupport,
  ];

  List<JobPost> _buildJobPosts(S s) => [
    JobPost(
      title: s.jobTitleQualitySupervisor,
      companyLabel: s.jobCompanyConfidential,
      postedAt: s.jobPostedAt(6),
      location: s.jobLocationJordan,
      isFeatured: true,
    ),
    JobPost(
      title: s.jobTitleAdminOfficer,
      companyLabel: s.jobCompanyConfidential,
      postedAt: s.jobPostedAt(9),
      location: s.jobLocationJordan,
      isFeatured: true,
    ),
    JobPost(
      title: s.jobTitleInternalAuditor,
      companyLabel: s.jobCompanyConfidential,
      postedAt: s.jobPostedAt(9),
      location: s.jobLocationJordan,
      isFeatured: true,
    ),
    JobPost(
      title: s.jobTitleFinanceSpecialist,
      companyLabel: s.jobCompanyConfidential,
      postedAt: s.jobPostedAt(12),
      location: s.jobLocationSaudi,
    ),
  ];

  List<FeaturedOffer> _buildFeaturedOffers(S s) => [
    FeaturedOffer(
      title: s.offerBoostedTitle,
      subtitle: s.offerBoostedSubtitle,
      badge: s.offerBoostedBadge,
      icon: Icons.rocket_launch_outlined,
    ),
    FeaturedOffer(
      title: s.offerUrgentTitle,
      subtitle: s.offerUrgentSubtitle,
      badge: s.offerUrgentBadge,
      gradient: const [AppColors.bannerGreen, AppColors.bannerTeal],
      icon: Icons.flash_on_outlined,
    ),
    FeaturedOffer(
      title: s.offerSpotlightTitle,
      subtitle: s.offerSpotlightSubtitle,
      badge: s.offerSpotlightBadge,
      gradient: const [AppColors.purpleDark, AppColors.purple],
      icon: Icons.star_outline,
    ),
  ];
  int _currentImage = 0;
  int _selectedTab = 0;

  @override
  void dispose() {
    _galleryController.dispose();
    _homeSearchController.dispose();
    _jobSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final jobCategories = _buildJobCategories(s);
    final jobPosts = _buildJobPosts(s);
    final featuredOffers = _buildFeaturedOffers(s);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedTab,
          children: [
            HomeTab(
              galleryController: _galleryController,
              currentImage: _currentImage,
              onImageChanged: (index) {
                setState(() => _currentImage = index);
              },
              searchController: _homeSearchController,
              galleryImages: _galleryImages,
              categories: jobCategories,
              featuredOffers: featuredOffers,
            ),
            JobsTab(searchController: _jobSearchController, jobPosts: jobPosts),
            _PlaceholderTab(label: s.navSaved),
            _PlaceholderTab(label: s.navProfile),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() => _selectedTab = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: s.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.work_outline),
            activeIcon: const Icon(Icons.work),
            label: s.navJobs,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_border),
            activeIcon: const Icon(Icons.bookmark),
            label: s.navSaved,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: s.navProfile,
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Text(
        S.of(context).placeholderTab(label),
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
