import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/pages/applicant_notifications_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({
    super.key,
    required this.favoriteJobs,
    required this.onJobSelected,
  });

  final List<JobPost> favoriteJobs;
  final ValueChanged<JobPost> onJobSelected;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        CustomHeader(
          title: '',
          titleWidget: const SizedBox.shrink(),
          height: 120,
          backgroundColor: AppColors.purple,
          backgroundImage: AppAssets.headerLogo,
          showBackButton: false,
          showMenuButton: true,
          showNotificationButton: true,
          onNotificationPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ApplicantNotificationsPage(),
              ),
            );
          },
          showSearchBar: false,
        ),
        Expanded(
          child:
              favoriteJobs.isEmpty
                  ? Center(
                    child: Text(
                      s.savedEmptyMessage,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                    itemBuilder: (context, index) {
                      final job = favoriteJobs[index];
                      return SavedJobCard(
                        job: job,
                        onTap: () => onJobSelected(job),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: favoriteJobs.length,
                  ),
        ),
      ],
    );
  }
}

class SavedJobCard extends StatelessWidget {
  const SavedJobCard({required this.job, required this.onTap});

  final JobPost job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(22),
      elevation: theme.brightness == Brightness.dark ? 0 : 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.companyLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                job.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      job.location,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      job.salary ?? '-',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
