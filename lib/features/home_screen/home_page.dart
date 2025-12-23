import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/pages/job_detail_page.dart';
import 'package:work_hub/features/home_screen/utils/home_constants.dart';
import 'package:work_hub/features/home_screen/utils/home_data.dart';
import 'package:work_hub/features/home_screen/utils/home_filters.dart';
import 'package:work_hub/features/home_screen/utils/home_models.dart';
import 'package:work_hub/features/home_screen/widgets/home_page_shell.dart';
import 'package:work_hub/features/home_screen/widgets/home_tab.dart';
import 'package:work_hub/features/home_screen/widgets/jobs_tab.dart';
import 'package:work_hub/features/home_screen/widgets/profile_tab.dart';
import 'package:work_hub/features/home_screen/widgets/saved_tab.dart';
import 'package:work_hub/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController galleryController = PageController(
    viewportFraction: 0.9,
  );
  final TextEditingController homeSearchController = TextEditingController();
  final TextEditingController jobSearchController = TextEditingController();
  String homeSearchQuery = '';
  String jobSearchQuery = '';
  int currentImage = 0;
  int selectedTab = 0;
  final Set<String> favoriteJobIds = <String>{};
  JobTimeFilter selectedJobTimeFilter = JobTimeFilter.anytime;
  String? selectedJobCategoryId;

  Stream<List<JobPost>> jobsStream(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final s = S.of(context);
    final cutoff = DateTime.now().subtract(const Duration(days: 1));
    return FirebaseFirestore.instance
        .collection('job_posts')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.where((doc) {
            final created =
                (doc.data()['created_at'] as Timestamp?)?.toDate();
            if (created == null) return true;
            return created.isAfter(cutoff);
          }).map((doc) {
            final data = doc.data();
            final createdAt =
                (data['created_at'] as Timestamp?)?.toDate() ??
                DateTime.now();
            final daysAgo = DateTime.now().difference(createdAt).inDays;
            final titleAr = (data['arabic_title'] as String?)?.trim();
            final titleEn = (data['english_title'] as String?)?.trim();
            final title =
                isArabic ? (titleAr ?? titleEn ?? '') : (titleEn ?? titleAr ?? '');
            // company location (free text) stored in "cityController" -> backend field "city"
            final location = (data['city'] as String?)?.trim() ?? '';
            // predefined city option (طرابلس/بنغازي/مصراتة) stored in "country"
            final selectedCity = (data['country'] as String?)?.trim();
            final department = (data['department'] as String?)?.trim();
            final description = (data['description'] as String?)?.trim();
            final companyLabel = s.jobCompanyConfidential;
            return JobPost(
              id: doc.id,
              title: title.isEmpty ? s.jobCompanyConfidential : title,
              companyLabel: companyLabel,
              postedAt: s.jobPostedAt(daysAgo),
              location: location.isEmpty ? 'N/A' : location,
              isFeatured: (data['highlight'] as bool?) ?? false,
              ownerId: (data['owner_uid'] as String?) ?? '',
              salary: salaryRange(data),
              experience: (data['experience_years'] as String?)?.trim(),
              department: department,
              educationLevel: (data['education_level'] as String?)?.trim(),
              nationality: (data['nationality'] as String?)?.trim(),
              city: selectedCity,
              deadline: (data['deadline'] as String?)?.trim(),
              description: description,
              companySummary: description,
              postedDaysAgo: daysAgo,
              categoryId: department ?? 'general',
            );
          }).toList(),
        );
  }

  @override
  void initState() {
    super.initState();
    homeSearchController.addListener(onHomeSearchChanged);
    jobSearchController.addListener(onJobSearchChanged);
  }

  @override
  void dispose() {
    homeSearchController
      ..removeListener(onHomeSearchChanged)
      ..dispose();
    jobSearchController
      ..removeListener(onJobSearchChanged)
      ..dispose();
    galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final categoryItems = buildJobCategories(s);
    final filteredCategoryItems = filterCategories(
      categoryItems,
      homeSearchQuery,
    );
    final filteredCategories =
        filteredCategoryItems.map((item) => item.title).toList();
    final timeOptions = buildTimeOptions(s);
    final featuredOffers = buildFeaturedOffers(s);
    final isGuest = FirebaseAuth.instance.currentUser == null;

    return StreamBuilder<List<JobPost>>(
      stream: jobsStream(context),
      builder: (context, snapshot) {
        final jobPosts = snapshot.data ?? const <JobPost>[];
        final categoryMap = jobCategoryOptions(jobPosts);
        final filteredJobPosts = filterJobs(
          jobs: jobPosts,
          query: jobSearchQuery,
          timeFilter: selectedJobTimeFilter,
          selectedCategoryId: (selectedJobCategoryId == null ||
                  selectedJobCategoryId == 'all')
              ? null
              : selectedJobCategoryId,
        );
        final categoryOptions = buildCategoryOptions(s, categoryMap);
        final favoriteJobs =
            jobPosts.where((job) => favoriteJobIds.contains(job.id)).toList();

        return HomePageShell(
          s: s,
          selectedTab: selectedTab,
          onTabChanged: (index) => setState(() => selectedTab = index),
          homeTab: HomeTab(
            galleryController: galleryController,
            currentImage: currentImage,
            onImageChanged: (index) {
              setState(() => currentImage = index);
            },
            searchController: homeSearchController,
            galleryImages: galleryImages,
            categories: filteredCategories,
            featuredOffers: featuredOffers,
            showCallToActions: isGuest,
          ),
          jobsTab: JobsTab(
            searchController: jobSearchController,
            jobPosts: filteredJobPosts,
            onJobSelected: openJobDetail,
            timeOptions: timeOptions,
            selectedTimeValue: timeFilterValue(selectedJobTimeFilter),
            onTimeChanged: handleTimeFilterChanged,
            categoryOptions: categoryOptions,
            selectedCategoryValue: selectedJobCategoryId ?? 'all',
            onCategoryChanged: handleCategoryFilterChanged,
          ),
          savedTab: SavedTab(
            favoriteJobs: favoriteJobs,
            onJobSelected: openJobDetail,
          ),
          profileTab: const ProfileTab(),
        );
      },
    );
  }

  String? salaryRange(Map<String, dynamic> data) {
    final salarySpecified = (data['salary_specified'] as bool?) ?? true;
    if (!salarySpecified) return null;
    final from = (data['salary_from'] as String?)?.trim() ?? '';
    final to = (data['salary_to'] as String?)?.trim() ?? '';
    final currency = (data['currency'] as String?)?.trim();
    final currLabel = (currency != null && currency.isNotEmpty) ? currency : 'LYD';
    if (from.isEmpty && to.isEmpty) return null;
    if (from.isNotEmpty && to.isNotEmpty) return '$from - $to $currLabel';
    if (from.isNotEmpty) return '$from $currLabel';
    return '$to $currLabel';
  }

  void toggleFavorite(JobPost job) {
    setState(() {
      if (favoriteJobIds.contains(job.id)) {
        favoriteJobIds.remove(job.id);
      } else {
        favoriteJobIds.add(job.id);
      }
    });
  }

  Future<void> openJobDetail(JobPost job) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => JobDetailPage(
              job: job,
              isFavorite: favoriteJobIds.contains(job.id),
              onToggleFavorite: () => toggleFavorite(job),
            ),
      ),
    );
  }

  void onHomeSearchChanged() {
    final value = homeSearchController.text.trim();
    if (value != homeSearchQuery) {
      setState(() => homeSearchQuery = value);
    }
  }

  void onJobSearchChanged() {
    final value = jobSearchController.text.trim();
    if (value != jobSearchQuery) {
      setState(() => jobSearchQuery = value);
    }
  }

  void handleTimeFilterChanged(String value) {
    setState(() {
      selectedJobTimeFilter = timeFilterFromValue(value);
    });
  }

  void handleCategoryFilterChanged(String value) {
    setState(() {
      selectedJobCategoryId = value == 'all' ? null : value;
    });
  }
}
