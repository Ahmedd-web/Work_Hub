import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/screens/employer_edit_info_page.dart';
import 'package:work_hub/features/employer/screens/employer_edit_about_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/features/employer/widgets/employer_account_about_section.dart';
import 'package:work_hub/features/employer/widgets/employer_account_identity_card.dart';
import 'package:work_hub/features/employer/widgets/employer_account_info_section.dart';
import 'package:work_hub/features/employer/widgets/employer_account_shimmer.dart';
import 'package:work_hub/features/employer/widgets/employer_account_tabs.dart';
import 'package:work_hub/features/employer/widgets/employer_edit_button.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerAccountPage extends StatefulWidget {
  const EmployerAccountPage({super.key});

  @override
  State<EmployerAccountPage> createState() => EmployerAccountPageState();
}

class EmployerAccountPageState extends State<EmployerAccountPage> {
  bool showInfo = true;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? profileStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      profileStream =
          FirebaseFirestore.instance
              .collection('employers')
              .doc(user.uid)
              .snapshots();
    }
  }

  Map<String, dynamic> composeProfile(Map<String, dynamic>? source) {
    final phones = <String>[
      source?['phone_primary']?.toString() ?? '',
      source?['phone_secondary']?.toString() ?? '',
    ];
    return {
      'company_name': (source?['company_name'] as String?)?.trim() ?? '',
      'company_name_en': source?['company_name_en'] as String? ?? '',
      'city': source?['city'] as String? ?? '',
      'address': source?['address'] as String? ?? '',
      'website': source?['website'] as String? ?? '',
      'industry': source?['industry'] as String? ?? '',
      'industry_en': source?['industry_en'] as String? ?? '',
      'advertiser_role': source?['advertiser_role'] as String? ?? '',
      'phones': phones,
      'phone_country': source?['phone_country'] as String? ?? 'LY (+218)',
      'email': source?['email'] as String? ?? '',
      'about': source?['about'] as String? ?? '',
      'about_en': source?['about_en'] as String? ?? '',
    };
  }

  Future<void> openEditPage(Map<String, dynamic> rawData) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployerEditInfoPage(initialData: rawData),
      ),
    );
  }

  Future<void> openAboutEditPage(Map<String, dynamic> rawData) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployerEditAboutPage(initialData: rawData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final background = theme.scaffoldBackgroundColor;
    if (profileStream == null) {
      return Scaffold(
        backgroundColor: background,
        body: Center(
          child: Text(
            s.employerAccountLoginRequired,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: profileStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                s.employerAccountLoadError('${snapshot.error ?? ''}'),
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            );
          }
          final rawData = snapshot.data?.data() ?? {};
          final profile = composeProfile(rawData);
          final isLoading =
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData;
          final companyName =
              (profile['company_name'] as String?)?.trim() ?? '';
          final displayCompanyName =
              companyName.isEmpty
                  ? s.employerAccountDefaultCompanyName
                  : companyName;
          final rawIndustry = (profile['industry'] as String?)?.trim() ?? '';
          final displayIndustry =
              rawIndustry.isEmpty
                  ? s.employerAccountIndustryPlaceholder
                  : rawIndustry;

          return Column(
            children: [
              CustomHeader(
                title: s.employerAccountTitle,
                titleWidget: const SizedBox.shrink(),
                backgroundColor: AppColors.purple,
                backgroundImage: AppAssets.headerLogo,
                showMenuButton: true,
                showNotificationButton: true,
                showSearchBar: false,
                overlayChild: EmployerIdentityCard(
                  name: displayCompanyName,
                  subtitle: displayIndustry,
                ),
                overlayHeight: 90,
                height: 190,
              ),
              const SizedBox(height: 70),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                          child: EmployerTabs(
                            showInfo: showInfo,
                            onChanged:
                                (value) => setState(() => showInfo = value),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 140),
                            physics: const ClampingScrollPhysics(),
                            child:
                                isLoading
                                    ? const AccountShimmer()
                                    : AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      child:
                                          showInfo
                                              ? CompanyInfoSection(
                                                key: const ValueKey('info'),
                                                data: profile,
                                              )
                                              : CompanyAboutSection(
                                                key: const ValueKey('about'),
                                                data: profile,
                                              ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                    if (showInfo)
                      Positioned(
                        left: 24,
                        bottom: 32,
                        child: EditButton(onTap: () => openEditPage(rawData)),
                      )
                    else
                      Positioned(
                        left: 24,
                        bottom: 32,
                        child: EditButton(
                          onTap: () => openAboutEditPage(rawData),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: EmployerBottomNav(
        currentIndex: 3,
        onChanged: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerDashboardPage()),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerJobsPage()),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerResumesPage()),
            );
          }
        },
      ),
    );
  }
}
