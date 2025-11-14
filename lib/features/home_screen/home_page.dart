import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/featured_offer.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/pages/job_detail_page.dart';
import 'package:work_hub/features/home_screen/widgets/home_tab.dart';
import 'package:work_hub/features/home_screen/widgets/jobs_tab.dart';
import 'package:work_hub/features/home_screen/widgets/profile_tab.dart';
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
  _JobTimeFilter _selectedJobTimeFilter = _JobTimeFilter.anytime;
  String? _selectedJobCategoryId;

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
    return [
      JobPost(
        id: 'quality_supervisor',
        title: s.jobTitleQualitySupervisor,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(6),
        location: 'Tripoli, Libya',
        isFeatured: true,
        salary: '7,500 LYD',
        experience: '1',
        department: s.jobDeptQuality,
        educationLevel: 'Bachelor',
        nationality: 'Libyan',
        city: 'Tripoli',
        deadline: '2025-11-06',
        description: 'متابعة معايير الجودة في خطوط إنتاج المواد الغذائية داخل مصنع محلي، والتأكد من مطابقتها للمواصفات الليبية والدولية.',
        companySummary: 'شركة تصنيع غذائي تعمل في طرابلس وتستقطب الكفاءات الليبية.',
        postedDaysAgo: 6,
        categoryId: 'quality',
      ),
      JobPost(
        id: 'admin_officer',
        title: s.jobTitleAdminOfficer,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(9),
        location: 'Benghazi, Libya',
        isFeatured: true,
        salary: '8,000 LYD',
        experience: '3',
        department: s.jobDeptAdministration,
        educationLevel: 'Diploma',
        nationality: 'Any',
        city: 'Benghazi',
        deadline: '2025-10-12',
        description: 'تنظيم ملفات الموظفين والمتابعة مع الأقسام المختلفة داخل شركة خدمات لوجستية في مدينة بنغازي.',
        companySummary: 'مؤسسة لوجستية تقدم خدمات الشحن والتوزيع داخل ليبيا.',
        postedDaysAgo: 9,
        categoryId: 'administration',
      ),
      JobPost(
        id: 'internal_auditor',
        title: s.jobTitleInternalAuditor,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(9),
        location: 'Misrata, Libya',
        isFeatured: true,
        salary: '6,500 LYD',
        experience: '2',
        department: s.jobDeptFinance,
        educationLevel: 'Bachelor',
        nationality: 'Any',
        city: 'Misrata',
        deadline: '2025-09-01',
        description: 'مراجعة التقارير المالية وتقديم التوصيات حول تحسين الأنظمة المحاسبية في شركة صناعية بمصراتة.',
        companySummary: 'شركة صناعية ليبية توسّع عملياتها في الغرب الليبي.',
        postedDaysAgo: 9,
        categoryId: 'finance',
      ),
      JobPost(
        id: 'finance_specialist',
        title: s.jobTitleFinanceSpecialist,
        companyLabel: s.jobCompanyConfidential,
        postedAt: s.jobPostedAt(12),
        location: 'Sebha, Libya',
        salary: '10,000 LYD',
        experience: '4',
        department: s.jobDeptFinance,
        educationLevel: 'Master',
        nationality: 'Any',
        city: 'Sebha',
        deadline: '2025-08-15',
        description: 'إعداد الميزانيات والتحليل المالي لمشاريع الطاقة المتجددة في الجنوب الليبي.',
        companySummary: 'مؤسسة تعمل في مجال الطاقة وتبحث عن خبرات مالية لدعم مشاريعها.',
        postedDaysAgo: 12,
        categoryId: 'finance',
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
      'tripoli',
      'طرابلس',
    ],
    'admin_officer': [
      'admin officer',
      'administration officer',
      'مسؤول إداري',
      'إداري',
      'benghazi',
      'بنغازي',
    ],
    'internal_auditor': [
      'internal auditor',
      'auditor',
      'مدقق داخلي',
      'التدقيق',
      'misrata',
      'مصراتة',
    ],
    'finance_specialist': [
      'finance specialist',
      'finance',
      'أخصائي مالي',
      'مالي',
      'sebha',
      'سبها',
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
    final categoryMap = _jobCategoryOptions(jobPosts);
    final filteredJobPosts = _filterJobs(jobPosts);
    final timeOptions = _buildTimeOptions(s);
    final categoryOptions = _buildCategoryOptions(s, categoryMap);
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
              timeOptions: timeOptions,
              selectedTimeValue: _timeFilterValue,
              onTimeChanged: _handleTimeFilterChanged,
              categoryOptions: categoryOptions,
              selectedCategoryValue: _selectedJobCategoryId ?? 'all',
              onCategoryChanged: _handleCategoryFilterChanged,
            ),
            SavedTab(favoriteJobs: favoriteJobs, onJobSelected: _openJobDetail),
            const ProfileTab(),
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
    final query = _jobSearchQuery.trim().toLowerCase();
    return jobs.where((job) {
      if (query.isNotEmpty && !_matchesSearch(job, query)) {
        return false;
      }
      if (!_matchesTimeFilter(job)) return false;
      if (_selectedJobCategoryId != null &&
          job.categoryId != _selectedJobCategoryId) {
        return false;
      }
      return true;
    }).toList();
  }

  bool _matchesSearch(JobPost job, String query) {
    final keywords = _jobKeywordMap[job.id] ?? const [];
    return job.title.toLowerCase().contains(query) ||
        job.companyLabel.toLowerCase().contains(query) ||
        job.location.toLowerCase().contains(query) ||
        keywords.any((keyword) => keyword.toLowerCase().contains(query));
  }

  bool _matchesTimeFilter(JobPost job) {
    switch (_selectedJobTimeFilter) {
      case _JobTimeFilter.last24h:
        return job.postedDaysAgo <= 1;
      case _JobTimeFilter.last7d:
        return job.postedDaysAgo <= 7;
      case _JobTimeFilter.last30d:
        return job.postedDaysAgo <= 30;
      case _JobTimeFilter.anytime:
        return true;
    }
  }

  Map<String, String> _jobCategoryOptions(List<JobPost> jobs) {
    final map = <String, String>{};
    for (final job in jobs) {
      final label = job.department ?? job.categoryId;
      map.putIfAbsent(job.categoryId, () => label);
    }
    return map;
  }

  List<FilterOption> _buildTimeOptions(S s) => [
        FilterOption(value: 'any', label: s.filterAnyTime),
        FilterOption(value: '24h', label: s.filterLast24h),
        FilterOption(value: '7d', label: s.filterLast7d),
        FilterOption(value: '30d', label: s.filterLast30d),
      ];

  List<FilterOption> _buildCategoryOptions(
    S s,
    Map<String, String> categories,
  ) {
    return [
      FilterOption(value: 'all', label: s.filterAllCategories),
      ...categories.entries.map(
        (entry) => FilterOption(value: entry.key, label: entry.value),
      ),
    ];
  }

  String get _timeFilterValue {
    switch (_selectedJobTimeFilter) {
      case _JobTimeFilter.last24h:
        return '24h';
      case _JobTimeFilter.last7d:
        return '7d';
      case _JobTimeFilter.last30d:
        return '30d';
      case _JobTimeFilter.anytime:
        return 'any';
    }
  }

  void _handleTimeFilterChanged(String value) {
    setState(() {
      _selectedJobTimeFilter = switch (value) {
        '24h' => _JobTimeFilter.last24h,
        '7d' => _JobTimeFilter.last7d,
        '30d' => _JobTimeFilter.last30d,
        _ => _JobTimeFilter.anytime,
      };
    });
  }

  void _handleCategoryFilterChanged(String value) {
    setState(() {
      _selectedJobCategoryId = value == 'all' ? null : value;
    });
  }
}

class _CategoryItem {
  const _CategoryItem({required this.id, required this.title});

  final String id;
  final String title;
}

enum _JobTimeFilter { last24h, last7d, last30d, anytime }

