import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/featured_offer.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/pages/job_detail_page.dart';
import 'package:work_hub/features/home_screen/widgets/home_tab.dart';
import 'package:work_hub/features/home_screen/widgets/jobs_tab.dart';
import 'package:work_hub/features/home_screen/widgets/saved_tab.dart';
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
  String _homeSearchQuery = '';
  String _jobSearchQuery = '';

  List<_CategoryItem> _buildJobCategories(S s) => [
    _CategoryItem(
      id: 'international_orgs',
      title: s.categoryInternationalOrganizations,
    ),
    _CategoryItem(id: 'sales', title: s.categorySales),
    _CategoryItem(id: 'administration', title: s.categoryAdministration),
    _CategoryItem(id: 'engineering', title: s.categoryEngineering),
    _CategoryItem(id: 'designer', title: s.categoryDesigner),
    _CategoryItem(id: 'programming', title: s.categoryProgramming),
    _CategoryItem(id: 'marketing', title: s.categoryMarketing),
    _CategoryItem(id: 'customer_support', title: s.categoryCustomerSupport),
  ];

  List<JobPost> _buildJobPosts(S s) {
    final defaultDescription = s.jobDescriptionDefault;
    final defaultSummary = s.jobCompanySummaryDefault;

    return [
      JobPost(
        id: 'quality_supervisor',
        title: s.jobTitleQualitySupervisor,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(6),
        location: s.jobLocationJordan,
        isFeatured: true,
        salary: 'Unspecified',
        experience: '1',
        department: 'Quality',
        educationLevel: 'Bachelor',
        nationality: 'Jordanian',
        city: 'Amman',
        deadline: '2025-11-06',
        description: defaultDescription,
        companySummary: defaultSummary,
      ),
      JobPost(
        id: 'admin_officer',
        title: s.jobTitleAdminOfficer,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(9),
        location: s.jobLocationJordan,
        isFeatured: true,
        salary: '9000 SAR',
        experience: '3',
        department: 'Administration',
        educationLevel: 'Diploma',
        nationality: 'Any',
        city: 'Aqaba',
        deadline: '2025-10-12',
        description: defaultDescription,
        companySummary: defaultSummary,
      ),
      JobPost(
        id: 'internal_auditor',
        title: s.jobTitleInternalAuditor,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(9),
        location: s.jobLocationJordan,
        isFeatured: true,
        salary: 'Unspecified',
        experience: '2',
        department: 'Finance',
        educationLevel: 'Bachelor',
        nationality: 'Any',
        city: 'Amman',
        deadline: '2025-09-01',
        description: defaultDescription,
        companySummary: defaultSummary,
      ),
      JobPost(
        id: 'finance_specialist',
        title: s.jobTitleFinanceSpecialist,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(12),
        location: s.jobLocationSaudi,
        salary: '12000 SAR',
        experience: '4',
        department: 'Finance',
        educationLevel: 'Master',
        nationality: 'Any',
        city: 'Riyadh',
        deadline: '2025-08-15',
        description: defaultDescription,
        companySummary: defaultSummary,
      ),
    ];
  }

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
  final Set<String> _favoriteJobIds = <String>{};
  static const Map<String, List<String>> _categoryKeywordMap = {
    'international_orgs': [
      'international',
      'organizations',
      'international organizations',
      'international orgs',
      'المنظمات',
      'المنظمات الدولية',
      'منظمات دولية',
    ],
    'sales': ['sales', 'selling', 'بيع', 'مبيعات'],
    'administration': [
      'administration',
      'admin',
      'secretary',
      'إدارة',
      'إداري',
      'سكرتارية',
    ],
    'engineering': ['engineering', 'engineer', 'هندسة', 'مهندس'],
    'designer': ['design', 'designer', 'تصميم', 'مصمم'],
    'programming': ['programming', 'developer', 'coding', 'برمجة', 'مطور'],
    'marketing': ['marketing', 'تسويق'],
    'customer_support': ['customer support', 'support', 'دعم', 'دعم العملاء'],
  };
  static const Map<String, List<String>> _jobKeywordMap = {
    'quality_supervisor': [
      'quality supervisor',
      'quality',
      'مشرف جودة',
      'الجودة',
      'jordan',
      'الأردن',
      'amman',
      'عمان',
    ],
    'admin_officer': [
      'admin officer',
      'administration officer',
      'مسؤول إداري',
      'إداري',
      'aqaba',
      'العقبة',
      'jordan',
      'الأردن',
    ],
    'internal_auditor': [
      'internal auditor',
      'auditor',
      'مدقق داخلي',
      'التدقيق',
      'amman',
      'عمان',
      'jordan',
      'الأردن',
    ],
    'finance_specialist': [
      'finance specialist',
      'finance',
      'financial',
      'أخصائي مالي',
      'مالي',
      'riyadh',
      'الرياض',
      'saudi',
      'السعودية',
    ],
  };

  @override
  void initState() {
    super.initState();
    _homeSearchController.addListener(_onHomeSearchChanged);
    _jobSearchController.addListener(_onJobSearchChanged);
  }

  @override
  void dispose() {
    _homeSearchController
      ..removeListener(_onHomeSearchChanged)
      ..dispose();
    _jobSearchController
      ..removeListener(_onJobSearchChanged)
      ..dispose();
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final categoryItems = _buildJobCategories(s);
    final filteredCategoryItems = _filterCategories(categoryItems);
    final filteredCategories =
        filteredCategoryItems.map((item) => item.title).toList();
    final jobPosts = _buildJobPosts(s);
    final filteredJobPosts = _filterJobs(jobPosts);
    final featuredOffers = _buildFeaturedOffers(s);
    final isGuest = FirebaseAuth.instance.currentUser == null;
    final favoriteJobs =
        jobPosts.where((job) => _favoriteJobIds.contains(job.id)).toList();

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
              categories: filteredCategories,
              featuredOffers: featuredOffers,
              showCallToActions: isGuest,
            ),
            JobsTab(
              searchController: _jobSearchController,
              jobPosts: filteredJobPosts,
              onJobSelected: _openJobDetail,
            ),
            SavedTab(favoriteJobs: favoriteJobs, onJobSelected: _openJobDetail),
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

  void _toggleFavorite(JobPost job) {
    setState(() {
      if (_favoriteJobIds.contains(job.id)) {
        _favoriteJobIds.remove(job.id);
      } else {
        _favoriteJobIds.add(job.id);
      }
    });
  }

  Future<void> _openJobDetail(JobPost job) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => JobDetailPage(
              job: job,
              isFavorite: _favoriteJobIds.contains(job.id),
              onToggleFavorite: () => _toggleFavorite(job),
            ),
      ),
    );
  }

  void _onHomeSearchChanged() {
    final value = _homeSearchController.text.trim();
    if (value != _homeSearchQuery) {
      setState(() => _homeSearchQuery = value);
    }
  }

  void _onJobSearchChanged() {
    final value = _jobSearchController.text.trim();
    if (value != _jobSearchQuery) {
      setState(() => _jobSearchQuery = value);
    }
  }

  List<_CategoryItem> _filterCategories(List<_CategoryItem> categories) {
    if (_homeSearchQuery.isEmpty) return categories;
    final query = _homeSearchQuery.toLowerCase();
    return categories.where((item) {
      final keywords = _categoryKeywordMap[item.id] ?? const [];
      return item.title.toLowerCase().contains(query) ||
          keywords.any((keyword) => keyword.toLowerCase().contains(query));
    }).toList();
  }

  List<JobPost> _filterJobs(List<JobPost> jobs) {
    if (_jobSearchQuery.isEmpty) return jobs;
    final query = _jobSearchQuery.toLowerCase();
    return jobs.where((job) {
      final keywords = _jobKeywordMap[job.id] ?? const [];
      return job.title.toLowerCase().contains(query) ||
          job.companyLabel.toLowerCase().contains(query) ||
          job.location.toLowerCase().contains(query) ||
          keywords.any((keyword) => keyword.toLowerCase().contains(query));
    }).toList();
  }
}

class _CategoryItem {
  const _CategoryItem({required this.id, required this.title});

  final String id;
  final String title;
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
