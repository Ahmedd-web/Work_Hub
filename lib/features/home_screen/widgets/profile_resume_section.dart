import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/cv_data.dart';
import 'package:work_hub/features/home_screen/pages/cv_wizard_page.dart';
import 'package:work_hub/features/home_screen/services/cv_repository.dart';
import 'package:work_hub/generated/l10n.dart';

class ResumeSection extends StatefulWidget {
  const ResumeSection({super.key, required this.uid});

  final String? uid;

  @override
  State<ResumeSection> createState() => ResumeSectionState();
}

class ResumeSectionState extends State<ResumeSection> {
  bool? editingOverride;

  bool shouldShowEditor(bool hasData) {
    if (editingOverride != null) return editingOverride!;
    return !hasData;
  }

  void enableEditor() {
    setState(() => editingOverride = true);
  }

  void showSummaryView() {
    setState(() => editingOverride = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    if (widget.uid == null) {
      return const Center(child: Text('لا توجد بيانات'));
    }
    final theme = Theme.of(context);
    final messenger = ScaffoldMessenger.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: StreamBuilder<CvData?>(
        stream: CvRepository.watchCv(widget.uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Text(snapshot.error.toString())),
            );
          }
          final data = snapshot.data;
          final showEditor = shouldShowEditor(data != null);
          if (showEditor) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CvWizardForm(
                initialData: data,
                onCompleted: (_) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(s.editProfileSuccessMessage)),
                  );
                  showSummaryView();
                },
              ),
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                data == null
                    ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(child: Text(s.cvNoData)),
                    )
                    : CvSummaryView(
                      key: const ValueKey('cv-summary'),
                      data: data,
                      onEdit: enableEditor,
                      onDownload: () => showDownloadSheet(context),
                    ),
          );
        },
      ),
    );
  }

  Future<void> showDownloadSheet(BuildContext context) async {
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return CvDownloadSheet(
          onConfirm: () {
            Navigator.of(sheetContext).pop();
            messenger.showSnackBar(SnackBar(content: Text(s.cvDownloadToast)));
          },
        );
      },
    );
  }
}

class CvSummaryView extends StatelessWidget {
  const CvSummaryView({
    super.key,
    required this.data,
    required this.onEdit,
    required this.onDownload,
  });

  final CvData data;
  final VoidCallback onEdit;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final spacer = const SizedBox(height: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CvSectionCard(
          title: s.cvSectionMainInfo,
          icon: Icons.badge_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CvSummaryRow(
                label: s.cvFieldJobTitleAr,
                value: valueOrDash(data.jobTitleAr, s.cvNoData),
              ),
              CvSummaryRow(
                label: s.cvFieldJobTitleEn,
                value: valueOrDash(data.jobTitleEn, s.cvNoData),
              ),
              CvSummaryRow(
                label: s.cvFieldEducationLevel,
                value: valueOrDash(data.educationLevel, s.cvNoData),
              ),
              CvSummaryRow(
                label: s.cvFieldYearsExperience,
                value: valueOrDash(data.yearsExperience, s.cvNoData),
              ),
            ],
          ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionContact,
          icon: Icons.phone_iphone_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.cvSectionContactPhones,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 6),
              Text(data.phones.isEmpty ? s.cvNoData : data.phones.join('\n')),
              const SizedBox(height: 12),
              Text(
                s.cvSectionContactEmail,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 6),
              Text(valueOrDash(data.email, s.cvNoData)),
            ],
          ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionSkills,
          icon: Icons.auto_awesome_outlined,
          child:
              data.skills.isEmpty
                  ? Text(s.cvSkillsEmpty)
                  : Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        data.skills.map((skill) {
                          return Chip(
                            label: Text(
                              skill,
                              style: const TextStyle(
                                color: AppColors.purple,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            backgroundColor: const Color(0xFFEDE7F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(
                                color: AppColors.purple.withValues(alpha: 0.2),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionSummary,
          icon: Icons.article_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CvSummaryRow(
                label: s.cvFieldSummaryAr,
                value: valueOrDash(data.summaryAr, s.cvSummaryEmpty),
                alignTop: true,
              ),
              CvSummaryRow(
                label: s.cvFieldSummaryEn,
                value: valueOrDash(data.summaryEn, s.cvSummaryEmpty),
                alignTop: true,
              ),
            ],
          ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionEducation,
          icon: Icons.school_outlined,
          child:
              data.education.isEmpty
                  ? Text(s.cvNoData)
                  : Column(
                    children:
                        data.education.map((edu) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  valueOrDash(edu.institution, s.cvNoData),
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.cvEducationMajorAr}: ${valueOrDash(edu.majorAr, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvEducationMajorEn}: ${valueOrDash(edu.majorEn, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvEducationStartDate}: ${valueOrDash(edu.startDate, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvEducationEndDate}: ${valueOrDash(edu.endDate, s.cvNoData)}',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionCourses,
          icon: Icons.menu_book_outlined,
          child:
              data.courses.isEmpty
                  ? Text(s.cvNoData)
                  : Column(
                    children:
                        data.courses.map((course) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  valueOrDash(course.title, s.cvNoData),
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.cvCourseOrganization}: ${valueOrDash(course.organization, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvCourseDate}: ${valueOrDash(course.date, s.cvNoData)}',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionExperience,
          icon: Icons.work_outline,
          child:
              data.experiences.isEmpty
                  ? Text(s.cvNoData)
                  : Column(
                    children:
                        data.experiences.map((exp) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${valueOrDash(exp.companyAr, s.cvNoData)} / ${valueOrDash(exp.companyEn, s.cvNoData)}',
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.cvExperienceRoleAr}: ${valueOrDash(exp.roleAr, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvExperienceRoleEn}: ${valueOrDash(exp.roleEn, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvExperienceStartDate}: ${valueOrDash(exp.startDate, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvExperienceEndDate}: ${valueOrDash(exp.endDate, s.cvNoData)}',
                                ),
                                const SizedBox(height: 4),
                                Text(valueOrDash(exp.description, s.cvNoData)),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: onEdit,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          icon: const Icon(Icons.edit_outlined),
          label: Text(s.cvEditButton),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onDownload,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.bannerGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          icon: const Icon(Icons.download_outlined),
          label: Text(s.cvDownloadCta),
        ),
      ],
    );
  }

  static String valueOrDash(String value, String placeholder) {
    if (value.trim().isEmpty) return placeholder;
    return value;
  }
}

class CvSummaryRow extends StatelessWidget {
  const CvSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.alignTop = false,
  });

  final String label;
  final String value;
  final bool alignTop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment:
            alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CvSectionCard extends StatelessWidget {
  const CvSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.purple),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class CvDownloadSheet extends StatefulWidget {
  const CvDownloadSheet({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  State<CvDownloadSheet> createState() => CvDownloadSheetState();
}

class CvDownloadSheetState extends State<CvDownloadSheet> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final plans = [
      DownloadPlanData(
        title: s.cvDownloadFree,
        price: s.cvDownloadFreePrice,
        description: s.cvDownloadFreeDesc,
      ),
      DownloadPlanData(
        title: s.cvDownloadPremium,
        price: s.cvDownloadPremiumPrice,
        description: s.cvDownloadPremiumDesc,
      ),
      DownloadPlanData(
        title: s.cvDownloadGold,
        price: s.cvDownloadGoldPrice,
        description: s.cvDownloadGoldDesc,
      ),
    ];
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final textDirection = Directionality.of(context);
    return SafeArea(
      child: Directionality(
        textDirection: textDirection,
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.cvDownloadTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                s.cvDownloadSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ...plans.asMap().entries.map((entry) {
                final index = entry.key;
                final plan = entry.value;
                final isSelected = index == selectedIndex;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color:
                          isSelected
                              ? AppColors.purple
                              : Colors.grey.withValues(alpha: 0.3),
                    ),
                    color:
                        isSelected
                            ? AppColors.purple.withValues(alpha: 0.08)
                            : cardColor,
                  ),
                  child: ListTile(
                    onTap: () => setState(() => selectedIndex = index),
                    title: Row(
                      children: [
                        Expanded(child: Text(plan.title)),
                        const SizedBox(width: 8),
                        Text(
                          plan.price,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.purple,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(plan.description),
                    ),
                    trailing:
                        isSelected
                            ? const Icon(
                              Icons.check_circle,
                              color: AppColors.purple,
                            )
                            : const Icon(Icons.circle_outlined),
                  ),
                );
              }),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: widget.onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bannerGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(s.cvDownloadButton),
              ),
              const SizedBox(height: 8),
              Text(
                s.cvDownloadComingSoon,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadPlanData {
  const DownloadPlanData({
    required this.title,
    required this.price,
    required this.description,
  });

  final String title;
  final String price;
  final String description;
}
