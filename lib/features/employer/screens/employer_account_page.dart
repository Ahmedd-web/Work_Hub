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
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerAccountPage extends StatefulWidget {
  const EmployerAccountPage({super.key});

  @override
  State<EmployerAccountPage> createState() => _EmployerAccountPageState();
}

class _EmployerAccountPageState extends State<EmployerAccountPage> {
  bool _showInfo = true;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? _profileStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _profileStream =
          FirebaseFirestore.instance
              .collection('employers')
              .doc(user.uid)
              .snapshots();
    }
  }

  Map<String, dynamic> _composeProfile(Map<String, dynamic>? source) {
    final phones = <String>[
      source?['phone_primary']?.toString() ?? '',
      source?['phone_secondary']?.toString() ?? '',
    ];
    return {
      'company_name':
          (source?['company_name'] as String?)?.trim().isNotEmpty == true
              ? source!['company_name'] as String
              : 'حساب الشركة',
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

  Future<void> _openEditPage(Map<String, dynamic> rawData) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployerEditInfoPage(initialData: rawData),
      ),
    );
  }

  Future<void> _openAboutEditPage(Map<String, dynamic> rawData) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployerEditAboutPage(initialData: rawData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_profileStream == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        body: Center(
          child: Text('يرجى تسجيل الدخول كصاحب عمل لعرض هذه الصفحة.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _profileStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ أثناء تحميل البيانات: ${snapshot.error}'),
            );
          }
          final rawData = snapshot.data?.data() ?? {};
          final profile = _composeProfile(rawData);
          final isLoading =
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData;
          return Column(
            children: [
              CustomHeader(
                title: 'الحساب',
                titleWidget: const SizedBox.shrink(),
                backgroundColor: AppColors.purple,
                backgroundImage: AppAssets.headerLogo,
                showMenuButton: true,
                showNotificationButton: true,
                showSearchBar: false,
                overlayChild: _EmployerIdentityCard(
                  name: profile['company_name'] as String,
                  subtitle: profile['industry'] as String,
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
                          child: _EmployerTabs(
                            showInfo: _showInfo,
                            onChanged:
                                (value) => setState(() => _showInfo = value),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 140),
                            physics: const ClampingScrollPhysics(),
                            child:
                                isLoading
                                    ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                    : AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      child:
                                          _showInfo
                                              ? _CompanyInfoSection(
                                                key: const ValueKey('info'),
                                                data: profile,
                                              )
                                              : _CompanyAboutSection(
                                                key: const ValueKey('about'),
                                                data: profile,
                                              ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                    if (_showInfo)
                      Positioned(
                        left: 24,
                        bottom: 32,
                        child: _EditButton(onTap: () => _openEditPage(rawData)),
                      )
                    else
                      Positioned(
                        left: 24,
                        bottom: 32,
                        child: _EditButton(
                          onTap: () => _openAboutEditPage(rawData),
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

class _EmployerIdentityCard extends StatelessWidget {
  const _EmployerIdentityCard({required this.name, required this.subtitle});

  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.25)),
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
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.pillBackground,
            child: const Icon(
              Icons.apartment,
              color: AppColors.purple,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle.isEmpty ? 'حدد مجال عمل شركتك' : subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
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

class _EmployerTabs extends StatelessWidget {
  const _EmployerTabs({required this.showInfo, required this.onChanged});

  final bool showInfo;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.2)),
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
          Expanded(
            child: _TabButton(
              label: 'معلومات الحساب',
              active: showInfo,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'نبذة عن الشركة',
              active: !showInfo,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: active ? AppColors.bannerGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.purple,
          ),
        ),
      ),
    );
  }
}

class _CompanyInfoSection extends StatelessWidget {
  const _CompanyInfoSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final phones = List<String>.from(data['phones'] as List);
    final companyFields = [
      _FieldTileData(
        label: 'اسم الشركة',
        value: data['company_name'] as String,
        icon: Icons.storefront_outlined,
      ),
      _FieldTileData(
        label: 'مجال عمل الشركة',
        value: data['industry'] as String,
        icon: Icons.category_outlined,
      ),
    ];
    final contactFields = [
      _FieldTileData(
        label: 'موقع الشركة',
        value: data['website'] as String,
        icon: Icons.public,
      ),
      _FieldTileData(
        label: 'رقم الشركة 1',
        value: phones.isNotEmpty ? phones[0] : '',
        icon: Icons.phone_outlined,
      ),
      _FieldTileData(
        label: 'رقم الشركة 2',
        value: phones.length > 1 ? phones[1] : '',
        icon: Icons.phone_outlined,
      ),
      _FieldTileData(
        label: 'بريد الشركة',
        value: data['email'] as String,
        icon: Icons.mail_outline,
      ),
    ];

    return Column(
      children: [
        _SectionCard(
          title: 'معلومات الشركة',
          icon: Icons.badge_outlined,
          fields: companyFields,
        ),
        const SizedBox(height: 8),
        _SectionCard(
          title: 'وسائل التواصل',
          icon: Icons.contact_phone_outlined,
          fields: contactFields,
        ),
      ],
    );
  }
}

class _CompanyAboutSection extends StatelessWidget {
  const _CompanyAboutSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final aboutAr = data['about'] as String? ?? '';
    final aboutEn = data['about_en'] as String? ?? '';
    return Column(
      children: [
        _AboutSummaryTile(label: 'نبذة عن الشركة بالعربية', value: aboutAr),
        const SizedBox(height: 14),
        _AboutSummaryTile(label: 'نبذة عن الشركة بالإنجليزية', value: aboutEn),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
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
  final List<_FieldTileData>? fields;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.pillBackground,
            child: Icon(icon, color: AppColors.purple),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2B1F4D),
            ),
          ),
          const SizedBox(height: 20),
          if (fields != null)
            ..._buildFields(theme)
          else if (description != null)
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildFields(ThemeData theme) {
    final widgets = <Widget>[];
    final fieldList = fields ?? [];
    for (var i = 0; i < fieldList.length; i++) {
      widgets.add(_FieldTile(data: fieldList[i]));
      if (i != fieldList.length - 1) {
        widgets.add(const Divider(height: 28));
      }
    }
    return widgets;
  }
}

class _FieldTileData {
  const _FieldTileData({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

class _FieldTile extends StatelessWidget {
  const _FieldTile({required this.data});

  final _FieldTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.purple.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(data.icon, color: AppColors.purple, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.value.isEmpty ? '-' : data.value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF241637),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutSummaryTile extends StatelessWidget {
  const _AboutSummaryTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFF2),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            value.isEmpty ? '-' : value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF402A62),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onTap,
      child: const Icon(Icons.edit, color: AppColors.purple),
    );
  }
}
