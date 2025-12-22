import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_action_card.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_bullet_card.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_chip_point.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_header.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_info_block.dart';
import 'package:work_hub/features/home_screen/menuSheet/widgets/privacy_section_title.dart';
import 'package:work_hub/generated/l10n.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    final s = S.of(context);

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
                    PrivacySectionTitle(title: s.privacyIntroTitle),
                    const SizedBox(height: 14),
                    PrivacyInfoBlock(
                      title: s.privacyDataTitle,
                      subtitle: s.privacyDataDesc,
                      icon: Icons.lock_outline,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    PrivacyInfoBlock(
                      title: s.privacySecurityTitle,
                      subtitle: s.privacySecurityDesc,
                      icon: Icons.verified_user_outlined,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(height: 12),
                    PrivacyInfoBlock(
                      title: s.privacyRetentionTitle,
                      subtitle: s.privacyRetentionDesc,
                      icon: Icons.shield_outlined,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(height: 24),
                    PrivacySectionTitle(title: s.privacyPrinciplesTitle),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        PrivacyChipPoint(text: s.privacyPrinciple1),
                        PrivacyChipPoint(text: s.privacyPrinciple2),
                        PrivacyChipPoint(text: s.privacyPrinciple3),
                        PrivacyChipPoint(text: s.privacyPrinciple4),
                      ],
                    ),
                    const SizedBox(height: 26),
                    PrivacySectionTitle(title: s.privacyUseTitle),
                    const SizedBox(height: 10),
                    PrivacyBulletCard(
                      items: [
                        s.privacyUseItem1,
                        s.privacyUseItem2,
                        s.privacyUseItem3,
                      ],
                      color: isDark ? Colors.green.shade500 : colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    PrivacySectionTitle(title: s.privacyNotTitle),
                    const SizedBox(height: 10),
                    PrivacyBulletCard(
                      items: [
                        s.privacyNotItem1,
                        s.privacyNotItem2,
                        s.privacyNotItem3,
                      ],
                      color: Colors.blue.shade500,
                    ),
                    const SizedBox(height: 26),
                    PrivacyActionCard(
                      title: s.privacyActionTitle,
                      description: s.privacyActionDesc,
                      buttonText: s.privacyActionButton,
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
