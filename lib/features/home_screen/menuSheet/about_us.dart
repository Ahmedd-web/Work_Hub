import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'من نحن؟',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'WoorkHup منصة تربط بين أصحاب الأعمال والباحثين عن فرص العمل بطرق حديثة وسهلة الاستخدام.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            const _QuestionCard(
              icon: Icons.work_outline,
              question: 'ما هي رسالتنا؟',
              answer:
                  'نسعى لتمكين الباحثين عن العمل من الوصول إلى الفرص المناسبة، ومساعدة الشركات على إيجاد الكفاءات بسرعة وفعالية.',
            ),
            const SizedBox(height: 16),
            const _QuestionCard(
              icon: Icons.thumb_up_alt_outlined,
              question: 'ما الذي يميز WoorkHup؟',
              answer:
                  'السرعة في التوظيف، سهولة الاستخدام، ودعم كامل باللغتين العربية والإنجليزية لتجربة سلسة للجميع.',
            ),
            const SizedBox(height: 16),
            const _QuestionCard(
              icon: Icons.star_outline,
              question: 'ما هو هدفنا القادم؟',
              answer:
                  'نعمل على توسيع شبكة شركائنا وتقديم أدوات ذكية تساعدك على اتخاذ قرارات التوظيف بثقة.',
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.icon,
    required this.question,
    required this.answer,
  });

  final IconData icon;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
                  child: Icon(icon, color: colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              answer,
              style: textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
