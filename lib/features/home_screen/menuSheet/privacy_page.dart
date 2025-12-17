import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_action_card.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_bullet_card.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_chip_point.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_header.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_info_block.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_section_title.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PrivacyHeader(colorScheme: colorScheme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const PrivacySectionTitle(title: 'سياسة الخصوصية'),
                    const SizedBox(height: 14),
                    PrivacyInfoBlock(
                      title: 'حماية البيانات',
                      subtitle:
                          'نلتزم بتأمين معلوماتك الشخصية عبر أنظمة مشفرة وضوابط وصول محددة، ولا نشاركها إلا للضرورة.',
                      icon: Icons.lock_outline,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    PrivacyInfoBlock(
                      title: 'الامتثال القانوني',
                      subtitle:
                          'نلتزم بالقوانين المحلية والدولية لحماية البيانات ونوضح لك حقوقك وكيفية ممارستها في أي وقت.',
                      icon: Icons.verified_user_outlined,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(height: 12),
                    PrivacyInfoBlock(
                      title: 'التحكم في الخصوصية',
                      subtitle:
                          'يمكنك تحديث بياناتك أو حذفها متى شئت، كما يمكنك إيقاف الإشعارات أو إلغاء الاشتراك في أي لحظة.',
                      icon: Icons.shield_outlined,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(height: 24),
                    const PrivacySectionTitle(title: 'مبادئنا'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: const [
                        PrivacyChipPoint(text: 'أمان عالي'),
                        PrivacyChipPoint(text: 'شفافية كاملة'),
                        PrivacyChipPoint(text: 'لا نبيع بياناتك'),
                        PrivacyChipPoint(text: 'تمكين تحكمك ببياناتك'),
                      ],
                    ),
                    const SizedBox(height: 26),
                    const PrivacySectionTitle(title: 'ما نجمعه'),
                    const SizedBox(height: 10),
                    PrivacyBulletCard(
                      items: const [
                        'بيانات حساب أساسية (الاسم، البريد، رقم الهاتف).',
                        'معلومات الشركة/الجهة المعلنة عند التسجيل.',
                        'بيانات استخدام تطبيق عامة لتحسين الأداء (بدون أي بيع لبياناتك).',
                      ],
                      color: isDark ? Colors.green.shade500 : colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    const PrivacySectionTitle(title: 'كيف نستخدمها'),
                    const SizedBox(height: 10),
                    PrivacyBulletCard(
                      items: const [
                        'تشغيل خدمات التطبيق وعرض المحتوى المناسب.',
                        'إرسال تنبيهات مهمة أو تحديثات متعلقة بحسابك.',
                        'تحليل الاستخدام لتحسين التجربة دون مشاركة معلوماتك مع أطراف تسويقية.',
                      ],
                      color: Colors.blue.shade500,
                    ),
                    const SizedBox(height: 26),
                    PrivacyActionCard(
                      title: 'كيف تتواصل معنا',
                      description:
                          'إذا احتجت أي مساعدة أو استفسار حول خصوصيتك، تواصل معنا لنساعدك فوراً.',
                      buttonText: 'العودة',
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
