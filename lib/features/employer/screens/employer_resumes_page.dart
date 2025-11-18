import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_jobs_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerResumesPage extends StatefulWidget {
  const EmployerResumesPage({super.key});

  @override
  State<EmployerResumesPage> createState() => _EmployerResumesPageState();
}

class _EmployerResumesPageState extends State<EmployerResumesPage> {
  final _timeOptions = [
    'آخر 24 ساعة',
    'آخر أسبوع',
    'آخر شهر',
    'أي وقت',
  ];
  final _categoryOptions = [
    'جميع التخصصات',
    'التقنية',
    'التسويق',
    'الإدارة',
    'الهندسة',
  ];

  String _selectedTime = 'آخر 24 ساعة';
  String _selectedCategory = 'جميع التخصصات';

  final _resumes = [
    {
      'name': 'ليلى أحمد',
      'role': 'مصممة واجهات وتجربة مستخدم',
      'location': 'طرابلس',
      'experience': '4 سنوات خبرة',
      'skills': ['Figma', 'User Research', 'Illustrator'],
      'updated': 'منذ 6 ساعات',
    },
    {
      'name': 'علي الكيلاني',
      'role': 'مهندس برمجيات واجهات أمامية',
      'location': 'بنغازي',
      'experience': '6 سنوات خبرة',
      'skills': ['Flutter', 'REST APIs', 'Firebase'],
      'updated': 'منذ يوم',
    },
    {
      'name': 'سارة عمران',
      'role': 'أخصائية تسويق رقمي',
      'location': 'مصراتة',
      'experience': '5 سنوات خبرة',
      'skills': ['Meta Ads', 'SEO', 'Content'],
      'updated': 'منذ 3 أيام',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
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
            overlayChild: const _ResumeSearchField(),
            overlayHeight: 70,
            height: 160,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 100),
              children: [
                Text(
                  'استكشف السير الذاتية',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E2156),
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'اختر المرشح المثالي لفرصتك من خلال تصفية السير الذاتية حسب الوقت والتخصص.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _DropdownFilter(
                        label: 'التوقيت',
                        value: _selectedTime,
                        options: _timeOptions,
                        onChanged: (value) {
                          if (value != null) setState(() => _selectedTime = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DropdownFilter(
                        label: 'التخصص',
                        value: _selectedCategory,
                        options: _categoryOptions,
                        onChanged: (value) {
                          if (value != null) setState(() => _selectedCategory = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ..._resumes.map(
                  (resume) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _ResumeCard(data: resume),
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

class _ResumeSearchField extends StatelessWidget {
  const _ResumeSearchField();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;
    return Center(
      child: Material(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: width,
          height: 54,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'ابحث عن سيرة ذاتية...',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.bannerGreen,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  const _DropdownFilter({
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
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: AppColors.purple.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
            items: options
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _ResumeCard extends StatelessWidget {
  const _ResumeCard({required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skills = List<String>.from(data['skills'] as List);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
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
                          color: const Color(0xFF2B1F4B),
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
              children: skills
                  .map(
                    (skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F1FF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.purple.withValues(alpha: 0.25)),
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
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    label: const Text('عرض السيرة'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.purple,
                      side: BorderSide(color: AppColors.purple.withValues(alpha: 0.4)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message_outlined),
                    label: const Text('تواصل معه'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bannerGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
