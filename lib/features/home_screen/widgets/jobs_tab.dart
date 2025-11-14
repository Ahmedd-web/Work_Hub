import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/widgets/header_sliver_delegate.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class JobsTab extends StatelessWidget {
  const JobsTab({
    super.key,
    required this.searchController,
    required this.jobPosts,
    required this.onJobSelected,
    required this.timeOptions,
    required this.selectedTimeValue,
    required this.onTimeChanged,
    required this.categoryOptions,
    required this.selectedCategoryValue,
    required this.onCategoryChanged,
    this.onFilterPressed,
  });

  final TextEditingController searchController;
  final List<JobPost> jobPosts;
  final ValueChanged<JobPost> onJobSelected;
  final List<FilterOption> timeOptions;
  final String selectedTimeValue;
  final ValueChanged<String> onTimeChanged;
  final List<FilterOption> categoryOptions;
  final String selectedCategoryValue;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback? onFilterPressed;

  static const double _headerBaseHeight = 130;
  static const double _searchOverlap = 28;
  static const double _headerExtent = _headerBaseHeight + _searchOverlap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return CustomScrollView(
      key: const PageStorageKey('jobs'),
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
                  searchHint: s.searchHint,
                  backgroundColor: AppColors.purple,
                  searchController: searchController,
                  height: _headerBaseHeight,
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    _IconPillButton(icon: Icons.tune, onTap: onFilterPressed),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _FilterDropdownPill(
                        icon: Icons.access_time,
                        value: selectedTimeValue,
                        options: timeOptions,
                        onChanged: onTimeChanged,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _FilterDropdownPill(
                        icon: Icons.work_outline,
                        value: selectedCategoryValue,
                        options: categoryOptions,
                        onChanged: onCategoryChanged,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  children: jobPosts
                      .map(
                        (job) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _JobCard(
                            job: job,
                            onTap: () => onJobSelected(job),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IconPillButton extends StatelessWidget {
  const _IconPillButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Ink(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: colorScheme.primary),
      ),
    );
  }
}

class _FilterDropdownPill extends StatelessWidget {
  const _FilterDropdownPill({
    required this.icon,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final IconData icon;
  final String value;
  final List<FilterOption> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                style: textTheme.bodyMedium?.copyWith(
                  color: textTheme.titleMedium?.color,
                  fontWeight: FontWeight.w600,
                ),
                items: options
                    .map(
                      (option) => DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) onChanged(val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterOption {
  const FilterOption({required this.value, required this.label});

  final String value;
  final String label;
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job, required this.onTap});

  final JobPost job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final badgeFill = colorScheme.secondary.withValues(alpha: 0.14);
    final badgeBorder = colorScheme.secondary.withValues(alpha: 0.3);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.pillBackground),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _LogoBadge(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: colorScheme.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            job.companyLabel,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        job.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (job.isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: badgeFill,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: badgeBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: colorScheme.secondary, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          s.jobFeaturedBadge,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  job.postedAt,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.purple,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          job.location,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined),
                  color: colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.purple.withValues(alpha: 0.1),
      ),
      alignment: Alignment.center,
      child: Text(
        'WZ',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.purple,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
