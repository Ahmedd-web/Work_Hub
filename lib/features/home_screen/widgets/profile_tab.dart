import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/cv_data.dart';
import 'package:work_hub/features/home_screen/models/profile_data.dart';
import 'package:work_hub/features/home_screen/pages/edit_profile_page.dart';
import 'package:work_hub/features/home_screen/pages/cv_wizard_page.dart';
import 'package:work_hub/features/home_screen/services/cv_repository.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _showPersonal = true;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    final textDirection = Directionality.of(context);

    return Directionality(
      textDirection: textDirection,
      child:
          user == null
              ? _ProfileScaffold(
                showPersonal: _showPersonal,
                onSegmentChanged:
                    (value) => setState(() => _showPersonal = value),
                state: _ProfileContentState.empty,
                message: s.profileNoData,
              )
              : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance
                        .collection('Profile')
                        .doc(user.uid)
                        .snapshots(),
                builder: (context, snapshot) {
                  final connectionState = snapshot.connectionState;
                  if (connectionState == ConnectionState.waiting) {
                    return _ProfileScaffold(
                      showPersonal: _showPersonal,
                      onSegmentChanged:
                          (value) => setState(() => _showPersonal = value),
                      state: _ProfileContentState.loading,
                    );
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return _ProfileScaffold(
                      showPersonal: _showPersonal,
                      onSegmentChanged:
                          (value) => setState(() => _showPersonal = value),
                      state: _ProfileContentState.empty,
                      message: s.profileNoData,
                    );
                  }
                  final profile = ProfileData.fromMap(
                    snapshot.data!.data() ?? {},
                  );
                  return _ProfileScaffold(
                    profile: profile,
                    showPersonal: _showPersonal,
                    onSegmentChanged:
                        (value) => setState(() => _showPersonal = value),
                    state: _ProfileContentState.loaded,
                  );
                },
              ),
    );
  }
}

enum _ProfileContentState { loading, empty, loaded }

class _ProfileScaffold extends StatelessWidget {
  const _ProfileScaffold({
    required this.showPersonal,
    required this.onSegmentChanged,
    required this.state,
    this.profile,
    this.message,
  });

  final ProfileData? profile;
  final bool showPersonal;
  final ValueChanged<bool> onSegmentChanged;
  final _ProfileContentState state;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    const double overlayHeight = 70;
    final overlayCard = _ProfileIdentityCard(
      name: profile?.displayName ?? s.profileNoData,
      initials: profile?.initials ?? '--',
      photoUrl: profile?.photoUrl ?? '',
      onUploadRequested: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(s.profileResumePlaceholder)));
      },
      compact: true,
      minHeight: overlayHeight,
      avatarRadius: 22,
    );

    Widget body;
    switch (state) {
      case _ProfileContentState.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case _ProfileContentState.empty:
        body = _EmptyState(message: message ?? s.profileNoData);
        break;
      case _ProfileContentState.loaded:
        if (profile == null) {
          body = _EmptyState(message: s.profileNoData);
        } else {
          body = _ProfileBody(
            data: profile!,
            showPersonal: showPersonal,
            onSegmentChanged: onSegmentChanged,
            onEdit: () => _openEditPage(context, profile!),
          );
        }
        break;
    }

    return Column(
      children: [
        CustomHeader(
          title: s.appTitle,
          backgroundColor: AppColors.purple,
          showMenuButton: true,
          showNotificationButton: true,
          showSearchBar: false,
          overlayChild: overlayCard,
          overlayHeight: 70,
          height: 130,
        ),
        SizedBox(height: 50),
        Expanded(
          child: Container(
            color: theme.scaffoldBackgroundColor,
            child: Padding(padding: const EdgeInsets.only(top: 0), child: body),
          ),
        ),
      ],
    );
  }

  Future<void> _openEditPage(BuildContext context, ProfileData data) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => EditProfilePage(initialData: data)),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({
    required this.data,
    required this.showPersonal,
    required this.onSegmentChanged,
    required this.onEdit,
  });

  final ProfileData data;
  final bool showPersonal;
  final ValueChanged<bool> onSegmentChanged;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _ProfileTabs(
                showPersonal: showPersonal,
                personalLabel: s.profilePersonalTab,
                resumeLabel: s.profileResumeTab,
                onChanged: onSegmentChanged,
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child:
                    showPersonal
                        ? _ProfileInfoList(
                          key: const ValueKey('personal-info'),
                          fields: [
                            _ProfileField(
                              label: s.profileNameLabel,
                              value: data.displayName,
                            ),
                            _ProfileField(
                              label: s.profilePhone,
                              value: data.phoneDisplay,
                              isLink: data.phoneDisplay != '-',
                            ),
                            _ProfileField(
                              label: s.profileEmail,
                              value: data.emailDisplay,
                              isLink: data.emailDisplay != '-',
                            ),
                            _ProfileField(
                              label: s.profileResumeTitle,
                              value:
                                  data.hasResume
                                      ? data.resumeDisplay
                                      : s.profileResumePlaceholder,
                              isLink: data.hasResume,
                            ),
                          ],
                        )
                        : _ResumeSection(
                          key: const ValueKey('resume-wizard'),
                          uid: uid,
                        ),
              ),
            ],
          ),
        ),
        if (showPersonal)
          Positioned(
            left: 24,
            bottom: 32,
            child: _EditFab(
              onTap: onEdit,
              backgroundColor: theme.cardColor,
              iconColor: theme.colorScheme.primary,
            ),
          ),
      ],
    );
  }
}

class _ProfileIdentityCard extends StatelessWidget {
  const _ProfileIdentityCard({
    required this.name,
    required this.initials,
    required this.photoUrl,
    required this.onUploadRequested,
    this.compact = false,
    this.minHeight = 120,
    this.avatarRadius = 42,
  });

  final String name;
  final String initials;
  final String photoUrl;
  final VoidCallback onUploadRequested;
  final bool compact;
  final double minHeight;
  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final double verticalPadding = compact ? 12 : 18;
    final double effectiveMinHeight = compact ? minHeight : 120;
    final double effectiveRadius =
        compact ? avatarRadius : math.max(avatarRadius, 42);
    final Color cameraBg =
        isDark ? theme.scaffoldBackgroundColor : Colors.white;
    final Color cameraIconColor = theme.colorScheme.primary;

    return Container(
      constraints: BoxConstraints(minHeight: effectiveMinHeight),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: effectiveRadius,
                backgroundColor: AppColors.pillBackground,
                backgroundImage:
                    photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                child:
                    photoUrl.isEmpty
                        ? Text(
                          initials,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.purple,
                          ),
                        )
                        : null,
              ),
              Positioned(
                bottom: -6,
                left: 0,
                child: GestureDetector(
                  onTap: onUploadRequested,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cameraBg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 14,
                      color: cameraIconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.textTheme.titleMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs({
    required this.showPersonal,
    required this.personalLabel,
    required this.resumeLabel,
    required this.onChanged,
  });

  final bool showPersonal;
  final String personalLabel;
  final String resumeLabel;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _TabButton(
                label: personalLabel,
                selected: showPersonal,
                onTap: () => onChanged(true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TabButton(
                label: resumeLabel,
                selected: !showPersonal,
                onTap: () => onChanged(false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        selected
            ? Colors.white
            : theme.textTheme.bodyMedium?.color ?? AppColors.textPrimary;
    final borderColor =
        !selected
            ? theme.dividerColor.withValues(alpha: 0.5)
            : Colors.transparent;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.bannerGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: borderColor, width: selected ? 0 : 1.2),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoList extends StatelessWidget {
  const _ProfileInfoList({super.key, required this.fields});

  final List<_ProfileField> fields;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < fields.length; i++) ...[
            _ProfileInfoRow(field: fields[i]),
            if (i != fields.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: theme.dividerColor),
              ),
          ],
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({required this.field});

  final _ProfileField field;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );
    final valueColor =
        field.isLink
            ? AppColors.purple
            : theme.textTheme.bodyLarge?.color ?? AppColors.textPrimary;
    final valueStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: valueColor,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(field.label, textAlign: TextAlign.end, style: labelStyle),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            field.value,
            textAlign: TextAlign.start,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}

class _ResumeSection extends StatefulWidget {
  const _ResumeSection({super.key, required this.uid});

  final String? uid;

  @override
  State<_ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<_ResumeSection> {
  bool? _editingOverride;

  bool _shouldShowEditor(bool hasData) {
    if (_editingOverride != null) return _editingOverride!;
    return !hasData;
  }

  void _enableEditor() {
    setState(() => _editingOverride = true);
  }

  void _showSummaryView() {
    setState(() => _editingOverride = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    if (widget.uid == null) {
      return _EmptyState(message: s.profileNoData);
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
              padding: const EdgeInsets.all(24),
              child: Text(s.profileNoData, textAlign: TextAlign.center),
            );
          }
          final data = snapshot.data;
          final hasData = data != null;
          final showEditor = _shouldShowEditor(hasData);
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                showEditor
                    ? Column(
                      key: const ValueKey('cv-editor'),
                      children: [
                        CvWizardForm(
                          initialData: data,
                          compact: true,
                          enableScrolling: false,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          onCompleted: (_) {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(s.editProfileSuccessMessage),
                              ),
                            );
                            _showSummaryView();
                          },
                        ),
                        if (hasData)
                          TextButton(
                            onPressed: _showSummaryView,
                            child: Text(s.commonCancel),
                          ),
                      ],
                    )
                    : _CvSummaryView(
                      key: const ValueKey('cv-summary'),
                      data: data!,
                      onEdit: _enableEditor,
                      onDownload: () => _showDownloadSheet(context),
                    ),
          );
        },
      ),
    );
  }

  Future<void> _showDownloadSheet(BuildContext context) async {
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _CvDownloadSheet(
          onConfirm: () {
            Navigator.of(sheetContext).pop();
            messenger.showSnackBar(SnackBar(content: Text(s.cvDownloadToast)));
          },
        );
      },
    );
  }
}

class _CvSummaryView extends StatelessWidget {
  const _CvSummaryView({
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
        _CvSectionCard(
          title: s.cvSectionMainInfo,
          icon: Icons.badge_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CvSummaryRow(
                label: s.cvFieldJobTitleAr,
                value: _valueOrDash(data.jobTitleAr, s.cvNoData),
              ),
              _CvSummaryRow(
                label: s.cvFieldJobTitleEn,
                value: _valueOrDash(data.jobTitleEn, s.cvNoData),
              ),
              _CvSummaryRow(
                label: s.cvFieldEducationLevel,
                value: _valueOrDash(data.educationLevel, s.cvNoData),
              ),
              _CvSummaryRow(
                label: s.cvFieldYearsExperience,
                value: _valueOrDash(data.yearsExperience, s.cvNoData),
              ),
            ],
          ),
        ),
        spacer,
        _CvSectionCard(
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
              Text(_valueOrDash(data.email, s.cvNoData)),
            ],
          ),
        ),
        spacer,
        _CvSectionCard(
          title: s.cvSectionSkills,
          icon: Icons.auto_awesome_outlined,
          child:
              data.skills.isEmpty
                  ? Text(s.cvSkillsEmpty)
                  : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        data.skills.map((skill) {
                          return Chip(
                            label: Text(skill),
                            backgroundColor: AppColors.pillBackground,
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        _CvSectionCard(
          title: s.cvSectionSummary,
          icon: Icons.article_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CvSummaryRow(
                label: s.cvFieldSummaryAr,
                value: _valueOrDash(data.summaryAr, s.cvSummaryEmpty),
                alignTop: true,
              ),
              _CvSummaryRow(
                label: s.cvFieldSummaryEn,
                value: _valueOrDash(data.summaryEn, s.cvSummaryEmpty),
                alignTop: true,
              ),
            ],
          ),
        ),
        spacer,
        _CvSectionCard(
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
                                  _valueOrDash(edu.institution, s.cvNoData),
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.cvEducationMajorAr}: ${_valueOrDash(edu.majorAr, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvEducationMajorEn}: ${_valueOrDash(edu.majorEn, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvEducationStartDate}: ${_valueOrDash(edu.startDate, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvEducationEndDate}: ${_valueOrDash(edu.endDate, s.cvNoData)}',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        _CvSectionCard(
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
                                  _valueOrDash(course.title, s.cvNoData),
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.cvCourseOrganization}: ${_valueOrDash(course.organization, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvCourseDate}: ${_valueOrDash(course.date, s.cvNoData)}',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        _CvSectionCard(
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
                                  '${_valueOrDash(exp.companyAr, s.cvNoData)} / ${_valueOrDash(exp.companyEn, s.cvNoData)}',
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.cvExperienceRoleAr}: ${_valueOrDash(exp.roleAr, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvExperienceRoleEn}: ${_valueOrDash(exp.roleEn, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvExperienceStartDate}: ${_valueOrDash(exp.startDate, s.cvNoData)}',
                                ),
                                Text(
                                  '${s.cvExperienceEndDate}: ${_valueOrDash(exp.endDate, s.cvNoData)}',
                                ),
                                const SizedBox(height: 4),
                                Text(_valueOrDash(exp.description, s.cvNoData)),
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

  static String _valueOrDash(String value, String placeholder) {
    if (value.trim().isEmpty) return placeholder;
    return value;
  }
}

class _CvSummaryRow extends StatelessWidget {
  const _CvSummaryRow({
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

class _CvSectionCard extends StatelessWidget {
  const _CvSectionCard({
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

class _CvDownloadSheet extends StatefulWidget {
  const _CvDownloadSheet({required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  State<_CvDownloadSheet> createState() => _CvDownloadSheetState();
}

class _CvDownloadSheetState extends State<_CvDownloadSheet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final plans = [
      _DownloadPlanData(
        title: s.cvDownloadFree,
        price: s.cvDownloadFreePrice,
        description: s.cvDownloadFreeDesc,
      ),
      _DownloadPlanData(
        title: s.cvDownloadPremium,
        price: s.cvDownloadPremiumPrice,
        description: s.cvDownloadPremiumDesc,
      ),
      _DownloadPlanData(
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
                final isSelected = index == _selectedIndex;
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
                    onTap: () => setState(() => _selectedIndex = index),
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

class _DownloadPlanData {
  const _DownloadPlanData({
    required this.title,
    required this.price,
    required this.description,
  });

  final String title;
  final String price;
  final String description;
}

class _EditFab extends StatelessWidget {
  const _EditFab({
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shape: const CircleBorder(),
      color: backgroundColor,
      child: IconButton(
        icon: Icon(Icons.edit, color: iconColor),
        onPressed: onTap,
      ),
    );
  }
}

class _ProfileField {
  const _ProfileField({
    required this.label,
    required this.value,
    this.isLink = false,
  });

  final String label;
  final String value;
  final bool isLink;
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
