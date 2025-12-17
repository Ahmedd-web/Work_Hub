import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_chat_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';

/// CV card used in resumes list.
class EmployerResumeCard extends StatelessWidget {
  const EmployerResumeCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skills = List<String>.from(data['skills'] as List? ?? const []);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isArabic ? ar : en;
    final bool isDark = theme.brightness == Brightness.dark;
    final Color cardFill = isDark ? const Color(0xFF111111) : theme.cardColor;
    final Color borderColor =
        isDark
            ? Colors.white.withValues(alpha: 0.06)
            : theme.colorScheme.outline.withValues(alpha: 0.15);
    return Material(
      color: cardFill,
      borderRadius: BorderRadius.circular(28),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardFill,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.bannerGreen.withValues(alpha: 0.2),
                  child: Text(
                    (data['name'] as String?)?.isNotEmpty == true
                        ? data['name'].toString().characters.first
                        : '?',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.purple,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'] as String? ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['role'] as String? ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['updated'] as String? ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.place, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          data['location'] as String? ?? '',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              data['experience'] as String? ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF289259),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  skills
                      .map(
                        (skill) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F1FF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.purple.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            skill,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.purple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EmployerResumeDetailPage(data: data),
                        ),
                      );
                    },
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    label: Text(t('عرض السيرة', 'View CV')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.purple,
                      side: BorderSide(
                        color: AppColors.purple.withValues(alpha: 0.4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final applicantId =
                          (data['email'] as String?) ??
                          (data['name'] as String?) ??
                          'applicant';
                      final jobId =
                          (data['job_id'] as String?) ?? 'resume_chat';
                      final jobTitle = (data['role'] as String?) ?? 'وظيفة';
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (_) => EmployerChatPage(
                                applicantId: applicantId,
                                applicantName:
                                    data['name'] as String? ?? 'متقدم',
                                jobId: jobId,
                                jobTitle: jobTitle,
                              ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.message_outlined),
                    label: Text(t('تواصل معه', 'Contact')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bannerGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
