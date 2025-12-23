import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/widgets/job_detail_details_card.dart';
import 'package:work_hub/generated/l10n.dart';

/// Tab content showing job info fields and description.
class JobInfoSection extends StatelessWidget {
  const JobInfoSection({super.key, required this.job});

  final JobPost job;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final descriptionValue = job.description?.trim();
    final details = [
      DetailItem(label: s.jobDetailJobTitle, value: job.title),
      DetailItem(
        label: s.jobDetailExperienceYears,
        value: job.experience ?? '-',
      ),
      DetailItem(
        label: s.jobDetailEducationLevel,
        value: job.educationLevel ?? '-',
      ),
      DetailItem(label: s.jobDetailDepartment, value: job.department ?? '-'),
      // nationality removed per new requirements
      // City is the predefined option (طرابلس/بنغازي/مصراتة), location is company address.
      // موقع الشركة (عنوان حر)
      DetailItem(label: 'موقع الشركة', value: job.location),
      DetailItem(label: s.jobDetailCity, value: job.city ?? '-'),
      DetailItem(label: s.jobDetailSalaryLabel, value: job.salary ?? '-'),
      DetailItem(label: s.jobDetailDeadline, value: job.deadline ?? '-'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.jobInfoSectionTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          DetailsCard(items: details),
          const SizedBox(height: 18),
          Text(
            s.jobDescriptionTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            (descriptionValue == null || descriptionValue.isEmpty)
                ? '-'
                : descriptionValue,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

/// Tab content showing company info and summary.
class CompanyInfoSection extends StatelessWidget {
  const CompanyInfoSection({super.key, required this.job});

  final JobPost job;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final aboutValue = job.companySummary?.trim();
    final details = [
      DetailItem(label: s.jobDetailCompanyNameLabel, value: job.companyLabel),
      DetailItem(label: s.jobDetailWorkLocation, value: job.location),
      DetailItem(label: s.jobDetailCity, value: job.city ?? '-'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.companyInfoSectionTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          DetailsCard(items: details),
          const SizedBox(height: 18),
          Text(
            s.jobDetailCompanySummary,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            (aboutValue == null || aboutValue.isEmpty) ? '-' : aboutValue,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
