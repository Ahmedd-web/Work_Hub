import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
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
          'مصممة UX/UI تهتم بتجربة المستخدم وتبني حلولاً بسيطة وسلسة للمنتجات الرقمية، عملت مع شركات تقنية ناشئة لتصميم تطبيقات موجهة للأسواق المحلية.',
      'experience_highlights': [
        'قادت تصميم منصة دفع إلكترونية رفعت معدل التحويل بنسبة 25٪ خلال 4 أشهر.',
        'عملت مع فرق تطوير متعددة التخصصات لضمان اتساق تجربة المستخدم على مختلف المنصات.',
      ],
      'email': 'leila.ahmad@email.com',
      'phone': '+218 91 555 1234',
    },
    {
      'name': 'علي الكيلاني',
      'role': 'مهندس برمجيات واجهات أمامية',
      'location': 'بنغازي',
      'experience': '6 سنوات خبرة',
      'skills': ['Flutter', 'REST APIs', 'Firebase'],
      'updated': 'منذ يوم',
      'summary':
          'مطور تطبيقات جوال بخبرة في Flutter ودمج واجهات برمجية معقدة، يهتم ببناء كود نظيف قابل للصيانة والتركيز على الأداء.',
      'experience_highlights': [
        'بنى تطبيق توصيل محلي تخطى 100 ألف تحميل مع معدل تقييم 4.8 على المتاجر.',
        'قاد عملية تحسين للأداء والذاكرة في تطبيق مصرفي مما خفّض زمن التحميل بنسبة 40٪.',
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
          'خبيرة في الحملات الإعلانية وإستراتيجيات المحتوى، عملت مع علامات تجارية محلية لزيادة الوعي والمبيعات عبر القنوات الرقمية.',
      'experience_highlights': [
        'إدارة حملة إعلانية متعددة المنصات زادت حجم المبيعات بنسبة 32٪ خلال ربع واحد.',
        'بناء إستراتيجية محتوى طويلة الأجل رفعت الزيارات العضوية للموقع بمعدل 60٪.',
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
    String t(String ar, String en) => isArabic ? ar : en;
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
            overlayChild: const ResumeSearchField(),
            overlayHeight: 70,
            height: 160,
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              children: [
                Text(
                  S.of(context).employerResumesTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF289259),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  S.of(context).employerResumesSubtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownFilter(
                        label: S.of(context).employerResumesTimeLabel,
                        value: selectedTime,
                        options: timeOptions,
                        onChanged: (value) {
                          if (value != null)
                            setState(() => selectedTime = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownFilter(
                        label: S.of(context).employerResumesCategoryLabel,
                        value: selectedCategory,
                        options: categoryOptions,
                        onChanged: (value) {
                          if (value != null)
                            setState(() => selectedCategory = value);
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
                      child: ResumeCardShimmer(),
                    ),
                  )
                else
                  ...resumes.map(
                    (resume) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ResumeCard(data: resume),
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

class ResumeSearchField extends StatelessWidget {
  const ResumeSearchField();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final width = MediaQuery.of(context).size.width * 0.9;
    final hintColor = (textTheme.bodyMedium?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.45);
    final borderRadius = BorderRadius.circular(28);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final s = S.of(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: borderRadius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: s.employerResumesSearchHint,
              hintStyle: textTheme.bodyMedium?.copyWith(color: hintColor),
              prefixIcon: Icon(Icons.search, color: hintColor),
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownFilter extends StatelessWidget {
  const DropdownFilter({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color:
                Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withValues(alpha: 0.7) ??
                Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: AppColors.purple.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha:
                      Theme.of(context).brightness == Brightness.dark
                          ? 0.18
                          : 0.05,
                ),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            borderRadius: BorderRadius.circular(16),
            items:
                options
                    .map(
                      (option) =>
                          DropdownMenuItem(value: option, child: Text(option)),
                    )
                    .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class ResumeCard extends StatelessWidget {
  const ResumeCard({required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skills = List<String>.from(data['skills'] as List);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    String t(String ar, String en) => isArabic ? ar : en;
    final bool isDark = theme.brightness == Brightness.dark;
    final Color cardFill = isDark ? const Color(0xFF131313) : theme.cardColor;
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
                    data['name'].toString().substring(0, 1),
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
                        data['name'] as String,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['role'] as String,
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
                      data['updated'] as String,
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
                          data['location'] as String,
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
              data['experience'] as String,
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
                    onPressed: () {},
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

class ResumeCardShimmer extends StatelessWidget {
  const ResumeCardShimmer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color baseColor =
        isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade300;
    final Color highlightColor =
        isDark ? Colors.white.withValues(alpha: 0.2) : Colors.grey.shade100;

    Widget shimmerLine({double height = 14, double? width}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerLine(height: 16, width: double.infinity),
                      const SizedBox(height: 8),
                      shimmerLine(height: 14, width: double.infinity),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            shimmerLine(height: 14, width: 120),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                3,
                (index) => Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: shimmerLine(height: 44)),
                const SizedBox(width: 12),
                Expanded(child: shimmerLine(height: 44)),
              ],
            ),
          ],
        ),
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
    final highlights = List<String>.from(
      data['experience_highlights'] as List? ?? const [],
    );
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
            heroChild: ResumeHeroCard(
              name: name,
              role: role,
              location: location,
              updated: updated,
            ),
            heroHeight: 170,
            height: 130,
          ),
          SizedBox(height: 95),
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
                          child: InfoBadge(
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
                          child: InfoBadge(
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
                          child: InfoBadge(
                            icon: Icons.access_time,
                            label: t('آخر تحديث', 'Updated'),
                            value: updated,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  SectionCard(
                    title: t('نبذة مختصرة', 'Summary'),
                    child: Text(
                      (summary == null || summary.isEmpty)
                          ? t(
                            'لا توجد نبذة متاحة حالياً.',
                            'No summary provided yet.',
                          )
                          : summary,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SectionCard(
                    title: t('المهارات الرئيسية', 'Key Skills'),
                    child:
                        skills.isEmpty
                            ? Text(
                              t('لا توجد مهارات مضافة.', 'No skills added.'),
                              style: theme.textTheme.bodyMedium,
                            )
                            : Wrap(
                              spacing: 8,
                              runSpacing: 10,
                              children:
                                  skills
                                      .map(
                                        (skill) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF2E8FF),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            skill,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
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
                  SectionCard(
                    title: t('أبرز الخبرات', 'Experience Highlights'),
                    child:
                        highlights.isEmpty
                            ? Text(
                              t(
                                'لا توجد تفاصيل خبرة مضافة.',
                                'No experience details added.',
                              ),
                              style: theme.textTheme.bodyMedium,
                            )
                            : Column(
                              children:
                                  highlights
                                      .map((text) => BulletLine(text: text))
                                      .toList(),
                            ),
                  ),
                  const SizedBox(height: 24),
                  SectionCard(
                    title: t('معلومات التواصل', 'Contact Info'),
                    child: Column(
                      children: [
                        ContactRow(icon: Icons.mail_outline, value: email),
                        const Divider(height: 24),
                        ContactRow(icon: Icons.phone_outlined, value: phone),
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

class ResumeHeroCard extends StatelessWidget {
  const ResumeHeroCard({
    required this.name,
    required this.role,
    required this.location,
    required this.updated,
  });

  final String name;
  final String role;
  final String location;
  final String updated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.bannerGreen.withValues(alpha: 0.2),
            child: Text(
              name.isEmpty ? '?' : name.characters.first,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.purple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.place, size: 16, color: AppColors.purple),
                    const SizedBox(width: 4),
                    Text(location, style: theme.textTheme.bodySmall),
                    const Spacer(),
                    Text(
                      updated,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.bannerGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoBadge extends StatelessWidget {
  const InfoBadge({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEmpty = value.trim().isEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.purple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.purple, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isEmpty ? '-' : value,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ],
    );
  }
}

class BulletLine extends StatelessWidget {
  const BulletLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
              color: AppColors.bannerGreen,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  const ContactRow({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.purple),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
