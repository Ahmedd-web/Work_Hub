import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'سياسة الخصوصية و شروط الاستخدام',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'خصوصية بياناتك',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'نلتزم بحماية بياناتك واستخدامها فقط للأغراض المصرح بها. لا نقوم ببيع البيانات أو مشاركتها دون إذن صريح منك.',
                      style: textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Text(
                '''
التزامنا:
- حماية بيانات المستخدمين وتحديث إجراءات الأمان باستمرار.
- توفير تجربة موثوقة وآمنة عند استخدام المنصة.
- إتاحة خيارات التحكم في البيانات لأي مستخدم عند الطلب.

كيفية الاستخدام:
- يرجى مراجعة هذه السياسة بشكل دوري حيث نقوم بتحديثها عند الحاجة.
- استمرارك في استخدام المنصة يعني موافقتك على أحدث نسخة من السياسة.
''',
                style: textTheme.bodyMedium?.copyWith(height: 1.6),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('تمت قراءة سياسة الخصوصية.'),
                    backgroundColor: colorScheme.secondary,
                  ),
                );
              },
              child: const Text('أوافق على سياسة الخصوصية'),
            ),
          ],
        ),
      ),
    );
  }
}
