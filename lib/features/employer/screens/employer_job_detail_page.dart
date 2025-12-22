import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_post_job_page.dart';
import 'package:work_hub/features/employer/widgets/employer_job_action_button.dart';
import 'package:work_hub/features/employer/widgets/employer_job_info_card.dart';
import 'package:work_hub/features/employer/widgets/employer_job_metric_chip.dart';
import 'package:work_hub/features/employer/widgets/employer_job_section_tabs.dart';

class EmployerJobDetailPage extends StatefulWidget {
  const EmployerJobDetailPage({
    super.key,
    required this.jobData,
    required this.jobId,
  });

  final Map<String, dynamic> jobData;
  final String jobId;

  @override
  State<EmployerJobDetailPage> createState() => EmployerJobDetailPageState();
}

class EmployerJobDetailPageState extends State<EmployerJobDetailPage> {
  int sectionIndex = 0;
  bool isUpdating = false;

  Map<String, dynamic> get job => widget.jobData;

  Duration get usedDuration {
    final createdAt = job['created_at'] as Timestamp?;
    if (createdAt == null) return Duration.zero;
    final pausedAt = job['paused_at'] as Timestamp?;
    final end = pausedAt?.toDate() ?? DateTime.now();
    return end.difference(createdAt.toDate());
  }

  Duration get remainingDuration {
    final stored = job['paused_remaining_seconds'] as int?;
    if (stored != null) return Duration(seconds: stored);
    final spent = usedDuration;
    final remaining = const Duration(hours: 24) - spent;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  String get salaryText {
    final from = (job['salary_from'] as String?) ?? '';
    final to = (job['salary_to'] as String?) ?? '';
    final currency = (job['currency'] as String?) ?? '';
    if ((from.isEmpty && to.isEmpty) || job['salary_specified'] == false) {
      return '-';
    }
    if (from.isNotEmpty && to.isNotEmpty) {
      return '$from - $to $currency';
    }
    return '${from.isNotEmpty ? from : to} $currency';
  }

  @override
  Widget build(BuildContext context) {
    final titleAr = (job['arabic_title'] as String?) ?? 'إعلان وظيفة';
    final titleEn = (job['english_title'] as String?) ?? '';
    final experience = (job['experience_years'] as String?) ?? '-';
    final country = (job['country'] as String?) ?? '-';
    final status = (job['status'] as String?) ?? 'active';
    final isDeleted = status == 'deleted';
    final isPaused = status == 'archived';
    final actionLabel = isPaused ? 'إعادة النشر' : 'إيقاف مؤقت';
    final actionColor =
        isPaused ? AppColors.bannerGreen : const Color(0xFFCB1F31);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          if (isPaused && !isDeleted)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EmployerPostJobPage(
                      initialData: job,
                      jobId: widget.jobId,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F5EA),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        titleAr.characters.take(2).join(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.bannerGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    titleAr,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.purple,
                    ),
                  ),
                  if (titleEn.isNotEmpty)
                    Text(titleEn, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        EmployerJobMetricChip(
                          icon: Icons.attach_money,
                          label: 'الراتب',
                          value: salaryText,
                        ),
                        EmployerJobMetricChip(
                          icon: Icons.timelapse_outlined,
                          label: 'الخبرة',
                          value: '$experience سنوات',
                        ),
                        EmployerJobMetricChip(
                          icon: Icons.location_on_outlined,
                          label: 'الدولة',
                          value: country,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EmployerJobActionButton(
                        text: 'تعزيز الإعلان',
                        icon: Icons.star_border,
                        onTap: () {},
                      ),
                      EmployerJobActionButton(
                        text: 'عرض الزيارات',
                        icon: Icons.visibility_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  EmployerJobSectionTabs(
                    index: sectionIndex,
                    onChanged: (index) => setState(() => sectionIndex = index),
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: buildSectionContent(),
                  ),
                ],
              ),
            ),
          ),
          if (!isDeleted)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isUpdating ? null : () => toggleStatus(isPaused),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: actionColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    actionLabel,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSectionContent() {
    switch (sectionIndex) {
      case 0:
        return EmployerJobInfoCard(
          title: 'معلومات الوظيفة',
          items: [
            EmployerJobInfoRow(
              label: 'المسمى الوظيفي',
              value: job['arabic_title'] ?? '-',
            ),
            EmployerJobInfoRow(
              label: 'سنوات الخبرة',
              value: job['experience_years'] ?? '-',
            ),
            EmployerJobInfoRow(
              label: 'المستوى التعليمي',
              value: job['education_level'] ?? '-',
            ),
            EmployerJobInfoRow(label: 'القسم', value: job['department'] ?? '-'),
            EmployerJobInfoRow(label: 'الجنسية', value: job['nationality'] ?? '-'),
            EmployerJobInfoRow(label: 'الدولة', value: job['country'] ?? '-'),
            EmployerJobInfoRow(label: 'المدينة', value: job['city'] ?? '-'),
          ],
        );
      case 1:
        return EmployerJobInfoCard(
          title: 'وصف الوظيفة',
          description:
              (job['description'] as String?)?.trim().isEmpty ?? true
                  ? 'لا يوجد وصف بعد'
                  : job['description'],
        );
      default:
        return EmployerJobInfoCard(
          title: 'تفاصيل الإعلان',
          description: 'لا يوجد تفاصيل أخرى متاحة.',
        );
    }
  }

  Future<void> toggleStatus(bool currentlyPaused) async {
    setState(() => isUpdating = true);
    try {
      if (currentlyPaused) {
        final remaining = remainingDuration;
        final spent = const Duration(hours: 24) - remaining;
        final adjustedSpent = spent.isNegative ? Duration.zero : spent;
        final newCreatedAt = Timestamp.fromDate(
          DateTime.now().subtract(adjustedSpent),
        );

        await FirebaseFirestore.instance
            .collection('job_posts')
            .doc(widget.jobId)
            .update({
          'status': 'active',
          'created_at': newCreatedAt,
          'paused_at': FieldValue.delete(),
          'paused_remaining_seconds': FieldValue.delete(),
          'expiry_warning_sent': false,
        });

        job['status'] = 'active';
        job['created_at'] = newCreatedAt;
        job.remove('paused_at');
        job.remove('paused_remaining_seconds');

        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'تم إعادة نشر الإعلان.',
            desc: 'سيستكمل الإعلان المدة المتبقية قبل الانتهاء.',
            btnOkOnPress: () {},
            btnOkColor: AppColors.bannerGreen,
          ).show();
          setState(() {});
        }
      } else {
        final remaining = remainingDuration;
        final pausedAt = Timestamp.now();

        await FirebaseFirestore.instance
            .collection('job_posts')
            .doc(widget.jobId)
            .update({
          'status': 'archived',
          'paused_at': pausedAt,
          'paused_remaining_seconds': remaining.inSeconds,
        });

        job['status'] = 'archived';
        job['paused_at'] = pausedAt;
        job['paused_remaining_seconds'] = remaining.inSeconds;

        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'تم إيقاف الإعلان مؤقتاً.',
            desc: 'يمكنك تعديل الإعلان ثم إعادة نشره ليكمل المدة المتبقية.',
            btnOkOnPress: () {},
            btnOkColor: AppColors.bannerGreen,
          ).show();
          setState(() {});
        }
      }
    } catch (_) {
      if (mounted) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'تعذر تحديث حالة الإعلان',
          desc: 'حاول مرة أخرى.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }
    } finally {
      if (mounted) setState(() => isUpdating = false);
    }
  }
}

