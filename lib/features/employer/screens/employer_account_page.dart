import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/screens/employer_edit_info_page.dart';
import 'package:work_hub/features/employer/screens/employer_edit_about_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
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

class EmployerIdentityCard extends StatelessWidget {
  const EmployerIdentityCard({required this.name, required this.subtitle});

  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: isDark ? 0.4 : 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
            child: Icon(Icons.apartment, color: colorScheme.primary, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.bannerGreen,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Icon(Icons.camera_alt_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class EmployerTabs extends StatelessWidget {
  const EmployerTabs({required this.showInfo, required this.onChanged});

  final bool showInfo;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: isDark ? 0.35 : 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TabButton(
              label: s.employerAccountTabInfo,
              active: showInfo,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: TabButton(
              label: s.employerAccountTabAbout,
              active: !showInfo,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: active ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class CompanyInfoSection extends StatelessWidget {
  const CompanyInfoSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final phones = List<String>.from(data['phones'] as List);
    final companyFields = [
      FieldTileData(
        label: s.employerAccountFieldCompanyName,
        value: data['company_name'] as String,
        icon: Icons.storefront_outlined,
      ),
      FieldTileData(
        label: s.employerAccountFieldIndustry,
        value: data['industry'] as String,
        icon: Icons.category_outlined,
      ),
    ];
    final contactFields = [
      FieldTileData(
        label: s.employerAccountFieldWebsite,
        value: data['website'] as String,
        icon: Icons.public,
      ),
      FieldTileData(
        label: s.employerAccountFieldPhone1,
        value: phones.isNotEmpty ? phones[0] : '',
        icon: Icons.phone_outlined,
      ),
      FieldTileData(
        label: s.employerAccountFieldPhone2,
        value: phones.length > 1 ? phones[1] : '',
        icon: Icons.phone_outlined,
      ),
      FieldTileData(
        label: s.employerAccountFieldEmail,
        value: data['email'] as String,
        icon: Icons.mail_outline,
      ),
    ];

    return Column(
      children: [
        SectionCard(
          title: s.employerAccountSectionInfoTitle,
          icon: Icons.badge_outlined,
          fields: companyFields,
        ),
        const SizedBox(height: 8),
        SectionCard(
          title: s.employerAccountSectionContactTitle,
          icon: Icons.contact_phone_outlined,
          fields: contactFields,
        ),
      ],
    );
  }
}

class CompanyAboutSection extends StatelessWidget {
  const CompanyAboutSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final aboutAr = data['about'] as String? ?? '';
    final aboutEn = data['about_en'] as String? ?? '';
    final s = S.of(context);
    return Column(
      children: [
        AboutSummaryTile(label: s.employerAccountAboutArabic, value: aboutAr),
        const SizedBox(height: 14),
        AboutSummaryTile(label: s.employerAccountAboutEnglish, value: aboutEn),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    required this.title,
    required this.icon,
    this.fields,
    this.description,
  }) : assert(
         fields != null || description != null,
         'Provide fields or description',
       );

  final String title;
  final IconData icon;
  final List<FieldTileData>? fields;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: isDark ? 0.35 : 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          if (fields != null)
            ...buildFields(theme)
          else if (description != null)
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }

  List<Widget> buildFields(ThemeData theme) {
    final widgets = <Widget>[];
    final fieldList = fields ?? [];
    for (var i = 0; i < fieldList.length; i++) {
      widgets.add(FieldTile(data: fieldList[i]));
      if (i != fieldList.length - 1) {
        widgets.add(const Divider(height: 28));
      }
    }
    return widgets;
  }
}

class FieldTileData {
  const FieldTileData({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

class FieldTile extends StatelessWidget {
  const FieldTile({required this.data});

  final FieldTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(data.icon, color: colorScheme.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.value.isEmpty ? '-' : data.value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AccountShimmer extends StatelessWidget {
  const AccountShimmer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final baseColor =
        isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade300;
    final highlightColor =
        isDark ? Colors.white.withValues(alpha: 0.18) : Colors.grey.shade100;

    Widget shimmerBlock({double height = 20, double? width}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          const SizedBox(height: 24),
          shimmerBlock(height: 18, width: 160),
          const SizedBox(height: 16),
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  shimmerBlock(height: 38, width: 38),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBlock(height: 14, width: 120),
                        const SizedBox(height: 8),
                        shimmerBlock(height: 16, width: double.infinity),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          shimmerBlock(height: 18, width: 140),
          const SizedBox(height: 16),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutSummaryTile extends StatelessWidget {
  const AboutSummaryTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            value.isEmpty ? '-' : value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return FloatingActionButton(
      backgroundColor: theme.cardColor,
      foregroundColor: colorScheme.primary,
      onPressed: onTap,
      child: Icon(Icons.edit, color: colorScheme.primary),
    );
  }
}
