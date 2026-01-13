import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/profile_data.dart';
import 'package:work_hub/features/home_screen/pages/applicant_notifications_page.dart';
import 'package:work_hub/features/home_screen/pages/edit_profile_page.dart';
import 'package:work_hub/features/home_screen/widgets/profile_body.dart';
import 'package:work_hub/features/home_screen/widgets/profile_empty_state.dart';
import 'package:work_hub/features/home_screen/widgets/profile_identity_card.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  bool showPersonal = true;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    final textDirection = Directionality.of(context);

    return Directionality(
      textDirection: textDirection,
      child:
          user == null
              ? ProfileScaffold(
                showPersonal: showPersonal,
                onSegmentChanged:
                    (value) => setState(() => showPersonal = value),
                state: ProfileContentState.empty,
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
                    return ProfileScaffold(
                      showPersonal: showPersonal,
                      onSegmentChanged:
                          (value) => setState(() => showPersonal = value),
                      state: ProfileContentState.loading,
                    );
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return ProfileScaffold(
                      showPersonal: showPersonal,
                      onSegmentChanged:
                          (value) => setState(() => showPersonal = value),
                      state: ProfileContentState.empty,
                      message: s.profileNoData,
                    );
                  }
                  final profile = ProfileData.fromMap(
                    snapshot.data!.data() ?? {},
                  );
                  return ProfileScaffold(
                    profile: profile,
                    showPersonal: showPersonal,
                    onSegmentChanged:
                        (value) => setState(() => showPersonal = value),
                    state: ProfileContentState.loaded,
                  );
                },
              ),
    );
  }
}

enum ProfileContentState { loading, empty, loaded }

class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({
    super.key,
    required this.showPersonal,
    required this.onSegmentChanged,
    required this.state,
    this.profile,
    this.message,
  });

  final ProfileData? profile;
  final bool showPersonal;
  final ValueChanged<bool> onSegmentChanged;
  final ProfileContentState state;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    const double overlayHeight = 70;
    final overlayCard = ProfileIdentityCard(
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
      case ProfileContentState.loading:
        body = const Center(child: CircularProgressIndicator());
        break;
      case ProfileContentState.empty:
        body = ProfileEmptyState(message: message ?? s.profileNoData);
        break;
      case ProfileContentState.loaded:
        if (profile == null) {
          body = ProfileEmptyState(message: s.profileNoData);
        } else {
          body = ProfileBody(
            data: profile!,
            showPersonal: showPersonal,
            onSegmentChanged: onSegmentChanged,
            onEdit: () => openEditPage(context, profile!),
          );
        }
        break;
    }

    return Column(
      children: [
        CustomHeader(
          title: '',
          titleWidget: const SizedBox.shrink(),
          backgroundColor: AppColors.purple,
          backgroundImage: AppAssets.headerLogo,
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
          overlayChild: overlayCard,
          overlayHeight: 70,
          height: 130,
        ),
        const SizedBox(height: 50),
        Expanded(
          child: Container(
            color: theme.scaffoldBackgroundColor,
            child: Padding(padding: const EdgeInsets.only(top: 0), child: body),
          ),
        ),
      ],
    );
  }

  Future<void> openEditPage(BuildContext context, ProfileData data) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => EditProfilePage(initialData: data)),
    );
  }
}
