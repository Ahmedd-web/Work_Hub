import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({
    super.key,
    required this.categories,
    this.customCounts,
  });

  final List<String> categories;
  final Map<String, int>? customCounts;

  static const extraCategories = [
    'التدريب والتطوير',
    'الإدارة',
    'الترجمة',
    'الشؤون القانونية',
    'الموارد البشرية',
    'المحاسبة',
    'أخرى',
  ];

  static const Map<String, int> defaultCounts = {
    'الهندسة': 419,
    'المنظمات الدولية': 215,
    'المبيعات': 540,
    'التصميم': 80,
    'برمجة': 82,
    'السكرتاريا والإدارة': 204,
    'التدريب والتطوير': 65,
    'الإدارة': 120,
    'الترجمة': 44,
    'الشؤون القانونية': 34,
    'الموارد البشرية': 93,
    'المحاسبة': 178,
    'أخرى': 50,
  };

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    final mergedCounts =
        <String, int>{}
          ..addAll(defaultCounts)
          ..addAll(customCounts ?? {});

    final ordered = <String>[];
    for (final item in [...categories, ...extraCategories]) {
      if (!ordered.contains(item)) {
        ordered.add(item);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(s.sectionJobCategories)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: ordered.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.88,
          ),
          itemBuilder: (context, index) {
            final title = ordered[index];
            final count = mergedCounts[title] ?? 0;
            return CategoryTile(title: title, jobs: count);
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({required this.title, required this.jobs});

  final String title;
  final int jobs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6E5),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              color: Color(0xFFC7E6BC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.work_outline,
              size: 32,
              color: Color(0xFF5C239D),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF5C239D),
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text(
            '$jobs وظيفة',
            style: const TextStyle(
              color: Color(0xFF6B6B6B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
