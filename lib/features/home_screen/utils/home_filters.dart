// Filtering and option builders for the job-seeker home page.
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/utils/home_constants.dart';
import 'package:work_hub/features/home_screen/utils/home_models.dart';
import 'package:work_hub/features/home_screen/widgets/jobs_tab.dart';
import 'package:work_hub/generated/l10n.dart';

List<CategoryItem> filterCategories(
  List<CategoryItem> categories,
  String query,
) {
  if (query.isEmpty) return categories;
  final lowered = query.toLowerCase();
  return categories.where((item) {
    final keywords = categoryKeywordMap[item.id] ?? const [];
    return item.title.toLowerCase().contains(lowered) ||
        keywords.any((keyword) => keyword.toLowerCase().contains(lowered));
  }).toList();
}

List<JobPost> filterJobs({
  required List<JobPost> jobs,
  required String query,
  required JobTimeFilter timeFilter,
  required String? selectedCategoryId,
}) {
  final lowered = query.trim().toLowerCase();
  return jobs.where((job) {
    if (lowered.isNotEmpty && !matchesSearch(job, lowered)) {
      return false;
    }
    if (!matchesTimeFilter(job, timeFilter)) return false;
    if (selectedCategoryId != null && job.categoryId != selectedCategoryId) {
      return false;
    }
    return true;
  }).toList();
}

bool matchesSearch(JobPost job, String query) {
  final keywords = jobKeywordMap[job.id] ?? const [];
  return job.title.toLowerCase().contains(query) ||
      job.companyLabel.toLowerCase().contains(query) ||
      job.location.toLowerCase().contains(query) ||
      keywords.any((keyword) => keyword.toLowerCase().contains(query));
}

bool matchesTimeFilter(JobPost job, JobTimeFilter filter) {
  switch (filter) {
    case JobTimeFilter.last24h:
      return job.postedDaysAgo <= 1;
    case JobTimeFilter.last7d:
      return job.postedDaysAgo <= 7;
    case JobTimeFilter.last30d:
      return job.postedDaysAgo <= 30;
    case JobTimeFilter.anytime:
      return true;
  }
}

Map<String, String> jobCategoryOptions(List<JobPost> jobs) {
  final map = <String, String>{};
  for (final job in jobs) {
    final label = job.department ?? job.categoryId;
    map.putIfAbsent(job.categoryId, () => label);
  }
  return map;
}

List<FilterOption> buildTimeOptions(S s) => [
  FilterOption(value: 'any', label: s.filterAnyTime),
  FilterOption(value: '24h', label: s.filterLast24h),
  FilterOption(value: '7d', label: s.filterLast7d),
  FilterOption(value: '30d', label: s.filterLast30d),
];

List<FilterOption> buildCategoryOptions(S s, Map<String, String> categories) {
  return [
    FilterOption(value: 'all', label: s.filterAllCategories),
    ...categories.entries.map(
      (entry) => FilterOption(value: entry.key, label: entry.value),
    ),
  ];
}

String timeFilterValue(JobTimeFilter filter) {
  switch (filter) {
    case JobTimeFilter.last24h:
      return '24h';
    case JobTimeFilter.last7d:
      return '7d';
    case JobTimeFilter.last30d:
      return '30d';
    case JobTimeFilter.anytime:
      return 'any';
  }
}

JobTimeFilter timeFilterFromValue(String value) {
  switch (value) {
    case '24h':
      return JobTimeFilter.last24h;
    case '7d':
      return JobTimeFilter.last7d;
    case '30d':
      return JobTimeFilter.last30d;
    default:
      return JobTimeFilter.anytime;
  }
}
