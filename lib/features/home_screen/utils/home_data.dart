// Provides static data used on the job-seeker home page (categories, jobs, offers).
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/featured_offer.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/utils/home_models.dart';
import 'package:work_hub/generated/l10n.dart';

List<CategoryItem> buildJobCategories(S s) => [
  CategoryItem(
    id: 'international_orgs',
    title: s.categoryInternationalOrganizations,
  ),
  CategoryItem(id: 'sales', title: s.categorySales),
  CategoryItem(id: 'administration', title: s.categoryAdministration),
  CategoryItem(id: 'engineering', title: s.categoryEngineering),
  CategoryItem(id: 'designer', title: s.categoryDesigner),
  CategoryItem(id: 'programming', title: s.categoryProgramming),
  CategoryItem(id: 'marketing', title: s.categoryMarketing),
  CategoryItem(id: 'customer_support', title: s.categoryCustomerSupport),
];

/// Returns an empty list so no fake jobs are shown when there is no data.
List<JobPost> buildJobPosts(S s) => const <JobPost>[];

List<FeaturedOffer> buildFeaturedOffers(S s) => [
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
