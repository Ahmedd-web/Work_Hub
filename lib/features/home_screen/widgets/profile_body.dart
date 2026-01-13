import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/profile_data.dart';
import 'package:work_hub/features/home_screen/widgets/profile_edit_fab.dart';
import 'package:work_hub/features/home_screen/widgets/profile_info_list.dart';
import 'package:work_hub/features/home_screen/widgets/profile_resume_section.dart';
import 'package:work_hub/features/home_screen/widgets/profile_tabs.dart';
import 'package:work_hub/generated/l10n.dart';

/// جسم صفحة الملف الشخصي (التبويب الشخصي + تبويب السيرة).
class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
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
              ProfileTabs(
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
                        ? ProfileInfoList(
                          key: const ValueKey('personal-info'),
                          fields: [
                            ProfileField(
                              label: s.profileNameLabel,
                              value: data.displayName,
                            ),
                            ProfileField(
                              label: s.profilePhone,
                              value: data.phoneDisplay,
                              isLink: data.phoneDisplay != '-',
                            ),
                            ProfileField(
                              label: s.profileEmail,
                              value: data.emailDisplay,
                              isLink: data.emailDisplay != '-',
                            ),
                            if (data.hasResume)
                              ProfileField(
                                label: s.profileResumeTitle,
                                value: data.resumeDisplay,
                                isLink: true,
                              ),
                          ],
                        )
                        : ResumeSection(
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
            child: ProfileEditFab(
              onTap: onEdit,
              backgroundColor: theme.cardColor,
              iconColor: theme.colorScheme.primary,
            ),
          ),
      ],
    );
  }
}
