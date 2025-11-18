import 'package:flutter/material.dart';
import 'package:work_hub/core/theme/app_theme.dart';

class EmployerJobDetailPage extends StatefulWidget {
  const EmployerJobDetailPage({
    super.key,
    required this.jobData,
    required this.jobId,
  });

  final Map<String, dynamic> jobData;
  final String jobId;

  @override
  State<EmployerJobDetailPage> createState() => _EmployerJobDetailPageState();
}

class _EmployerJobDetailPageState extends State<EmployerJobDetailPage> {
  int _sectionIndex = 0;

  Map<String, dynamic> get job => widget.jobData;

  String get _salaryText {
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
                        _MetricChip(
                          icon: Icons.attach_money,
                          label: 'الراتب',
                          value: _salaryText,
                        ),
                        _MetricChip(
                          icon: Icons.timelapse_outlined,
                          label: 'الخبرة',
                          value: '$experience سنوات',
                        ),
                        _MetricChip(
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
                      _RoundedActionButton(
                        text: 'تمييز الإعلان',
                        icon: Icons.star_border,
                        onTap: () {},
                      ),
                      _RoundedActionButton(
                        text: 'إظهار المتقدمين',
                        icon: Icons.visibility_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SectionTabs(
                    index: _sectionIndex,
                    onChanged: (index) => setState(() => _sectionIndex = index),
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _buildSectionContent(),
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
                onPressed: () {},
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

  Widget _buildSectionContent() {
    switch (_sectionIndex) {
      case 0:
        return _InfoCard(
          title: 'معلومات الوظيفة',
          items: [
            _InfoRow(
              label: 'المسمى الوظيفي',
              value: job['arabic_title'] ?? '-',
            ),
            _InfoRow(
              label: 'سنوات الخبرة',
              value: job['experience_years'] ?? '-',
            ),
            _InfoRow(
              label: 'مستوى التعليم',
              value: job['education_level'] ?? '-',
            ),
            _InfoRow(label: 'القسم', value: job['department'] ?? '-'),
            _InfoRow(label: 'الجنسية', value: job['nationality'] ?? '-'),
            _InfoRow(label: 'مكان العمل', value: job['country'] ?? '-'),
            _InfoRow(label: 'المدينة', value: job['city'] ?? '-'),
          ],
        );
      case 1:
        return _InfoCard(
          title: 'وصف الوظيفة',
          description:
              (job['description'] as String?)?.trim().isEmpty ?? true
                  ? 'لا يوجد وصف مرتب'
                  : job['description'],
        );
      default:
        return _InfoCard(
          title: 'صورة الإعلان',
          description: 'لم يتم تحميل صورة للإعلان حتى الآن.',
        );
    }
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
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

class _RoundedActionButton extends StatelessWidget {
  const _RoundedActionButton({
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

class _SectionTabs extends StatelessWidget {
  const _SectionTabs({required this.index, required this.onChanged});

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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, this.items, this.description});

  final String title;
  final List<_InfoRow>? items;
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

class _InfoRow {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;
}
