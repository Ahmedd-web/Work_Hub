import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  int _selectedIndex = 1;

  final List<_AdPackage> _packages = const [
    _AdPackage(
      title: 'باقة 50 دينار',
      price: '50 دينار',
      perks: [
        'إعلان واحد لمدة 7 أيام',
        'شارة تمييز بسيطة',
        'دعم عبر البريد',
      ],
    ),
    _AdPackage(
      title: 'باقة 100 دينار',
      price: '100 دينار',
      perks: [
        '3 إعلانات لمدة 14 يوماً',
        'شارة تمييز + تنبيه بالبحث',
        'نشر على القنوات الاجتماعية',
      ],
    ),
    _AdPackage(
      title: 'باقة 150 دينار',
      price: '150 دينار',
      perks: [
        '5 إعلانات لمدة 21 يوماً',
        'تصميم إعلان مخصص',
        'أولوية في نتائج البحث',
      ],
    ),
    _AdPackage(
      title: 'باقة 200 دينار',
      price: '200 دينار',
      perks: [
        '8 إعلانات لمدة شهر',
        'مدير حساب لمتابعة الأداء',
        'تقارير أسبوعية مفصلة',
      ],
    ),
    _AdPackage(
      title: 'باقة 250 دينار',
      price: '250 دينار',
      perks: [
        '12 إعلان لمدة شهر',
        'تعزيز تنبيهات ورسائل للمستخدمين',
        'دعم VIP عبر الهاتف',
      ],
    ),
  ];

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
            _Header(colorScheme: colorScheme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionTitle('خدماتنا الإعلانية'),
                    const SizedBox(height: 12),
                    _InfoCard(
                      title: 'إعلان وظيفة مميز',
                      subtitle:
                          'يظهر في أعلى نتائج البحث مع شارة تمييز جذابة لجذب أفضل المرشحين.',
                      icon: Icons.workspace_premium_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    _InfoCard(
                      title: 'حزمة تعزيز الانتشار',
                      subtitle:
                          'مشاركة الإعلان في القنوات التسويقية والتنبيهات للوصول لأكبر عدد من الباحثين.',
                      icon: Icons.campaign_outlined,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(height: 12),
                    _InfoCard(
                      title: 'دعم إنشاء إعلان احترافي',
                      subtitle:
                          'فريقنا يساعدك في صياغة وصف الوظيفة وتنسيقها بصرياً لتحقيق أعلى تفاعل.',
                      icon: Icons.design_services_outlined,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(height: 24),
                    _SectionTitle('الباقات الإعلانية'),
                    const SizedBox(height: 12),
                    ...List.generate(_packages.length, (index) {
                      final pack = _packages[index];
                      final isSelected = _selectedIndex == index;
                      final baseAccent = isDark ? Colors.green.shade500 : colorScheme.primary;
                      final accent = isSelected
                          ? baseAccent
                          : (isDark ? Colors.green.shade400 : colorScheme.primary.withValues(alpha: 0.6));
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == _packages.length - 1 ? 0 : 12),
                        child: _PackageCard(
                          title: pack.title,
                          price: pack.price,
                          perks: pack.perks,
                          accent: accent,
                          highlight: isSelected,
                          onTap: () => setState(() => _selectedIndex = index),
                        ),
                      );
                    }),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).maybePop(),
                        child: const Text(
                          'ابدأ الإعلان الآن',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
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

class _Header extends StatelessWidget {
  const _Header({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppAssets.headerLogo,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الخدمات الإعلانية',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'حلول متكاملة لترويج إعلانات الوظائف وجذب أفضل المرشحين بسرعة.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.title,
    required this.price,
    required this.perks,
    required this.accent,
    this.highlight = false,
    this.onTap,
  });

  final String title;
  final String price;
  final List<String> perks;
  final Color accent;
  final bool highlight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border:
              highlight
                  ? Border.all(color: accent, width: 1.5)
                  : Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: highlight ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    price,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...perks.map(
              (perk) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      highlight ? Icons.check_circle : Icons.circle_outlined,
                      color: accent,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        perk,
                        style: theme.textTheme.bodyMedium,
                      ),
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      textAlign: TextAlign.start,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class _AdPackage {
  final String title;
  final String price;
  final List<String> perks;
  const _AdPackage({
    required this.title,
    required this.price,
    required this.perks,
  });
}
