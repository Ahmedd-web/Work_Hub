import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_bullet_line.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_card.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_card_shimmer.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_contact_row.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_filter.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_hero_card.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_info_badge.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_search_field.dart';
import 'package:work_hub/features/employer/widgets/employer_resume_section_card.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerResumesPage extends StatefulWidget {
  const EmployerResumesPage({super.key});

  @override
  State<EmployerResumesPage> createState() => EmployerResumesPageState();
}

class EmployerResumesPageState extends State<EmployerResumesPage> {
  String selectedTime = '';
  String selectedCategory = '';

  final resumes = [
    {
      'name': 'ليلى أحمد',
      'role': 'مصممة واجهات وتجربة مستخدم',
      'location': 'طرابلس',
      'experience': '4 سنوات خبرة',
      'skills': ['Figma', 'User Research', 'Illustrator'],
      'updated': 'منذ 6 ساعات',
      'summary':
          'مصممة UX/UI تهتم بإنشاء تجارب مستخدم سهلة وسلسة وتعمل على تحسين رحلة المستخدم من أول تفاعل حتى إكمال المهمة بنجاح.',
      'experience_highlights': [
        'قادت إعادة تصميم لتطبيق بيع بالتجزئة زادت التحويل 25% خلال 4 أشهر.',
        'عملت مع فرق التطوير لضمان مطابقة التصميم للمعايير وتحسين الأداء.',
      ],
      'email': 'leila.ahmad@email.com',
      'phone': '+218 91 555 1234',
    },
    {
      'name': 'علي الكيلاني',
      'role': 'مطور تطبيقات جوال',
      'location': 'بنغازي',
      'experience': '6 سنوات خبرة',
      'skills': ['Flutter', 'REST APIs', 'Firebase'],
      'updated': 'منذ يوم',
      'summary':
          'مطور Flutter يركز على بناء تطبيقات عالية الأداء وقابلة للتوسع مع تكامل واجهات برمجية وخدمات سحابية.',
      'experience_highlights': [
        'طوّر تطبيقاً تعليميّاً وصل إلى 100 ألف تحميل بتقييم 4.8 نجوم.',
        'حسّن أوقات الاستجابة عبر تحسين استدعاءات الشبكة وتقليل حجم الحزم.',
      ],
      'email': 'alikilani@email.com',
      'phone': '+218 92 444 7788',
    },
    {
      'name': 'سارة عمران',
      'role': 'أخصائية تسويق رقمي',
      'location': 'مصراتة',
      'experience': '5 سنوات خبرة',
      'skills': ['Meta Ads', 'SEO', 'Content'],
      'updated': 'منذ 3 أيام',
      'summary':
          'تدير حملات إعلانية رقمية وتحسن محركات البحث مع تركيز على كتابة محتوى يجذب العملاء المحتملين ويزيد المبيعات.',
      'experience_highlights': [
        'رفعت معدّل النقر على الإعلانات المدفوعة بنسبة 32% خلال حملة مبيعات.',
        'ضاعفت الزيارات العضوية عبر خطة محتوى محسّنة وتحسين SEO.',
      ],
      'email': 'sara.imran@email.com',
      'phone': '+218 94 222 3344',
    },
  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final s = S.of(context);
    final timeOptions = [
      s.employerResumesTime24h,
      s.employerResumesTime7d,
      s.employerResumesTime30d,
      s.employerResumesTimeAny,
    ];
    final categoryOptions = [
      s.employerResumesCatAll,
      s.employerResumesCatTech,
      s.employerResumesCatAdmin,
      s.employerResumesCatMarketing,
      s.employerResumesCatEngineering,
    ];
    if (!timeOptions.contains(selectedTime)) {
      selectedTime = timeOptions.first;
    }
    if (!categoryOptions.contains(selectedCategory)) {
      selectedCategory = categoryOptions.first;
    }
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showMenuButton: true,
            showNotificationButton: true,
            showSearchBar: false,
            overlayChild: const EmployerResumeSearchField(),
            overlayHeight: 70,
            height: 160,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              children: [
                Text(
                  s.employerResumesTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF289259),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  s.employerResumesSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: EmployerResumeFilter(
                        label: s.employerResumesTimeLabel,
                        value: selectedTime,
                        options: timeOptions,
                        onChanged: (value) {
                          if (value != null) setState(() => selectedTime = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: EmployerResumeFilter(
                        label: s.employerResumesCategoryLabel,
                        value: selectedCategory,
                        options: categoryOptions,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => selectedCategory = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (isLoading)
                  ...List.generate(
                    3,
                    (_) => const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: EmployerResumeCardShimmer(),
                    ),
                  )
                else
                  ...resumes.map(
                    (resume) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: EmployerResumeCard(data: resume),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: EmployerBottomNav(
        currentIndex: 2,
        onChanged: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerDashboardPage()),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerJobsPage()),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const EmployerAccountPage()),
            );
          }
        },
      ),
    );
  }
}

class EmployerResumeDetailPage extends StatelessWidget {
  const EmployerResumeDetailPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isArabic ? ar : en;
    final skills = List<String>.from(data['skills'] as List? ?? const []);
    final highlights =
        List<String>.from(data['experience_highlights'] as List? ?? const []);
    final summary = (data['summary'] as String?)?.trim();
    final location = data['location'] as String? ?? '-';
    final experience = data['experience'] as String? ?? '-';
    final updated = data['updated'] as String? ?? '-';
    final email = data['email'] as String? ?? 'cv@example.com';
    final phone = data['phone'] as String? ?? '+218 91 0000000';
    final name = data['name'] as String? ?? '';
    final role = data['role'] as String? ?? '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showBackButton: true,
            showMenuButton: false,
            showNotificationButton: false,
            showSearchBar: false,
            heroChild: EmployerResumeHeroCard(
              name: name,
              role: role,
              location: location,
              updated: updated,
            ),
            heroHeight: 170,
            height: 130,
          ),
          const SizedBox(height: 95),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 140,
                          child: EmployerResumeInfoBadge(
                            icon: Icons.place_outlined,
                            label: t('المدينة', 'City'),
                            value: location,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 140,
                          child: EmployerResumeInfoBadge(
                            icon: Icons.timeline_rounded,
                            label: t('الخبرة', 'Experience'),
                            value: experience,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 140,
                          child: EmployerResumeInfoBadge(
                            icon: Icons.access_time,
                            label: t('آخر تحديث', 'Updated'),
                            value: updated,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  EmployerResumeSectionCard(
                    title: t('نبذة مختصرة', 'Summary'),
                    child: Text(
                      (summary == null || summary.isEmpty)
                          ? t('لا توجد نبذة متاحة حالياً.', 'No summary provided yet.')
                          : summary,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  EmployerResumeSectionCard(
                    title: t('المهارات الرئيسية', 'Key Skills'),
                    child: skills.isEmpty
                        ? Text(
                            t('لا توجد مهارات مضافة.', 'No skills added.'),
                            style: theme.textTheme.bodyMedium,
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            children: skills
                                .map(
                                  (skill) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF2E8FF),
                                      borderRadius: BorderRadius.circular(20),
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
                  ),
                  const SizedBox(height: 24),
                  EmployerResumeSectionCard(
                    title: t('أبرز الخبرات', 'Experience Highlights'),
                    child: highlights.isEmpty
                        ? Text(
                            t('لا توجد تفاصيل خبرة مضافة.', 'No experience details added.'),
                            style: theme.textTheme.bodyMedium,
                          )
                        : Column(
                            children: highlights
                                .map((text) => EmployerResumeBulletLine(text: text))
                                .toList(),
                          ),
                  ),
                  const SizedBox(height: 24),
                  EmployerResumeSectionCard(
                    title: t('بيانات التواصل', 'Contact Info'),
                    child: Column(
                      children: [
                        EmployerResumeContactRow(
                          icon: Icons.mail_outline,
                          value: email,
                        ),
                        const Divider(height: 24),
                        EmployerResumeContactRow(
                          icon: Icons.phone_outlined,
                          value: phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
