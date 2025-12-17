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
    final jobPosts = buildJobPosts(s);
    final categoryMap = jobCategoryOptions(jobPosts);
    final filteredJobPosts = filterJobs(
      jobs: jobPosts,
      query: jobSearchQuery,
      timeFilter: selectedJobTimeFilter,
      selectedCategoryId: selectedJobCategoryId,
    );
    final timeOptions = buildTimeOptions(s);
    final categoryOptions = buildCategoryOptions(s, categoryMap);
    final featuredOffers = buildFeaturedOffers(s);
    final isGuest = FirebaseAuth.instance.currentUser == null;
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
