import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_membership_page.dart';

class EmployerJobDetailPage extends StatefulWidget {
  const EmployerJobDetailPage({
    super.key,
    required this.jobData,
    required this.jobId,
  });

  final Map<String, dynamic> jobData;
  final String jobId;

  @override
  State<EmployerJobDetailPage> createState() => EmployerJobDetailPageState();
}

class EmployerJobDetailPageState extends State<EmployerJobDetailPage> {
  int sectionIndex = 0;
  bool isStopping = false;

  Map<String, dynamic> get job => widget.jobData;

  String get salaryText {
    final from = (job['salary_from'] as String?) ?? '';
    final to = (job['salary_to'] as String?) ?? '';
    final currency = (job['currency'] as String?) ?? '';
    if ((from.isEmpty && to.isEmpty) || job['salary_specified'] == false) {
      return '-';
    }
    if (from.isNotEmpty && to.isNotEmpty) {
      return '$from - $to $currency';
    }
    return '${from.isNotEmpty ? from : to} $currency';
  }

  @override
  Widget build(BuildContext context) {
    final titleAr = (job['arabic_title'] as String?) ?? 'وظيفة';
    final titleEn = (job['english_title'] as String?) ?? '';
    final experience = (job['experience_years'] as String?) ?? '-';
    final education = (job['education_level'] as String?) ?? '-';
    final country = (job['country'] as String?) ?? '-';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F5EA),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        titleAr.characters.take(2).join(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.bannerGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    titleAr,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.purple,
                    ),
                  ),
                  if (titleEn.isNotEmpty)
                    Text(titleEn, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MetricChip(
                          icon: Icons.attach_money,
                          label: 'الراتب',
                          value: salaryText,
                        ),
                        MetricChip(
                          icon: Icons.timelapse_outlined,
                          label: 'الخبرة',
                          value: '$experience سنوات',
                        ),
                        MetricChip(
                          icon: Icons.location_on_outlined,
                          label: 'الموقع',
                          value: country,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedActionButton(
                        text: 'تمييز الإعلان',
                        icon: Icons.star_border,
                        onTap: () {},
                      ),
                      RoundedActionButton(
                        text: 'إظهار المتقدمين',
                        icon: Icons.visibility_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionTabs(
                    index: sectionIndex,
                    onChanged: (index) => setState(() => sectionIndex = index),
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: buildSectionContent(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isStopping ? null : showStopDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCB1F31),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'إيقاف الإعلان',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionContent() {
    switch (sectionIndex) {
      case 0:
        return InfoCard(
          title: 'معلومات الوظيفة',
          items: [
            InfoRow(
              label: 'المسمى الوظيفي',
              value: job['arabic_title'] ?? '-',
            ),
            InfoRow(
              label: 'سنوات الخبرة',
              value: job['experience_years'] ?? '-',
            ),
            InfoRow(
              label: 'مستوى التعليم',
              value: job['education_level'] ?? '-',
            ),
            InfoRow(label: 'القسم', value: job['department'] ?? '-'),
            InfoRow(label: 'الجنسية', value: job['nationality'] ?? '-'),
            InfoRow(label: 'مكان العمل', value: job['country'] ?? '-'),
            InfoRow(label: 'المدينة', value: job['city'] ?? '-'),
          ],
        );
      case 1:
        return InfoCard(
          title: 'وصف الوظيفة',
          description:
              (job['description'] as String?)?.trim().isEmpty ?? true
                  ? 'لا يوجد وصف مرتب'
                  : job['description'],
        );
      default:
        return InfoCard(
          title: 'صورة الإعلان',
          description: 'لم يتم تحميل صورة للإعلان حتى الآن.',
        );
    }
  }

  Future<void> showStopDialog() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'عذرًا، اشتراكك الحالي قد لا يسمح لك باستخدام هذه الخدمة',
      btnOkText: 'إشترك الآن',
      btnOkOnPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EmployerMembershipPage()),
        );
      },
      btnOkColor: AppColors.bannerGreen,
    ).show();
  }
}

class MetricChip extends StatelessWidget {
  const MetricChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.purple),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class RoundedActionButton extends StatelessWidget {
  const RoundedActionButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.purple),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.purple),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  color: AppColors.purple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTabs extends StatelessWidget {
  const SectionTabs({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final tabs = ['معلومات الوظيفة', 'وصف الوظيفة', 'صورة الإعلان'];
    return Row(
      children: List.generate(tabs.length, (i) {
        final active = i == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              margin: EdgeInsets.only(right: i == tabs.length - 1 ? 0 : 8),
              height: 44,
              decoration: BoxDecoration(
                color: active ? AppColors.purple : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: active ? Colors.transparent : AppColors.purple,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                tabs[i],
                style: TextStyle(
                  color: active ? Colors.white : AppColors.purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({required this.title, this.items, this.description});

  final String title;
  final List<InfoRow>? items;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (items != null)
            ...items!.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.label,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Text(
                      item.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (description != null)
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }
}

class InfoRow {
  const InfoRow({required this.label, required this.value});

  final String label;
  final String value;
}
