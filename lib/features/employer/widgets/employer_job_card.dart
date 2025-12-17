import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_job_detail_page.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerJobCard extends StatelessWidget {
  const EmployerJobCard({super.key, required this.data, required this.jobId});

  final Map<String, dynamic> data;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final status = (data['status'] as String?) ?? 'active';
    final rawTitle = (data['arabic_title'] as String?)?.trim();
    final experienceYears = (data['experience_years'] as String?) ?? '-';
    final educationLevel = (data['education_level'] as String?) ?? '-';
    final country = (data['country'] as String?) ?? '-';

    Color statusColor;
    String statusText;

    switch (status) {
      case 'archived':
        statusColor = Colors.orange;
        statusText = s.employerJobsStatusArchived;
        break;
      case 'deleted':
        statusColor = Colors.red;
        statusText = s.employerJobsStatusDeleted;
        break;
      default:
        statusColor = AppColors.bannerGreen;
        statusText = s.employerJobsStatusActive;
    }

    final jobTitle =
        (rawTitle == null || rawTitle.isEmpty)
            ? s.employerJobsDefaultTitle
            : rawTitle;

    final experienceLabel = s.employerJobsExperienceLabel(experienceYears);
    final educationLabel = s.employerJobsEducationLabel(educationLevel);

    final secondaryText = (textTheme.bodySmall?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.7);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => EmployerJobDetailPage(jobData: data, jobId: jobId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.25 : 0.04,
              ),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.place, size: 16, color: secondaryText),
                const SizedBox(width: 4),
                Text(
                  country,
                  style: textTheme.bodySmall?.copyWith(color: secondaryText),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.purple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        experienceLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: secondaryText,
                        ),
                      ),
                      Text(
                        educationLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F5EA),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(AppAssets.headerLogo, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
