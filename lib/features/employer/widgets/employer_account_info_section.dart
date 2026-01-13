import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class CompanyInfoSection extends StatelessWidget {
  const CompanyInfoSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final phones = List<String>.from(data['phones'] as List);
    final companyFields = [
      FieldTileData(
        label: s.employerAccountFieldCompanyName,
        value: data['company_name'] as String,
        icon: Icons.storefront_outlined,
      ),
      FieldTileData(
        label: s.employerAccountFieldIndustry,
        value: data['industry'] as String,
        icon: Icons.category_outlined,
      ),
    ];
    final contactFields = [
      FieldTileData(
        label: s.employerAccountFieldWebsite,
        value: data['website'] as String,
        icon: Icons.public,
      ),
      FieldTileData(
        label: s.employerAccountFieldPhone1,
        value: phones.isNotEmpty ? phones[0] : '',
        icon: Icons.phone_outlined,
      ),
      FieldTileData(
        label: s.employerAccountFieldPhone2,
        value: phones.length > 1 ? phones[1] : '',
        icon: Icons.phone_outlined,
      ),
      FieldTileData(
        label: s.employerAccountFieldEmail,
        value: data['email'] as String,
        icon: Icons.mail_outline,
      ),
    ];

    return Column(
      children: [
        SectionCard(
          title: s.employerAccountSectionInfoTitle,
          icon: Icons.badge_outlined,
          fields: companyFields,
        ),
        const SizedBox(height: 8),
        SectionCard(
          title: s.employerAccountSectionContactTitle,
          icon: Icons.contact_phone_outlined,
          fields: contactFields,
        ),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    this.fields,
    this.description,
  }) : assert(
         fields != null || description != null,
         'Provide fields or description',
       );

  final String title;
  final IconData icon;
  final List<FieldTileData>? fields;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: isDark ? 0.35 : 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          if (fields != null)
            ...buildFields(theme)
          else if (description != null)
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }

  List<Widget> buildFields(ThemeData theme) {
    final widgets = <Widget>[];
    final fieldList = fields ?? [];
    for (var i = 0; i < fieldList.length; i++) {
      widgets.add(FieldTile(data: fieldList[i]));
      if (i != fieldList.length - 1) {
        widgets.add(const Divider(height: 28));
      }
    }
    return widgets;
  }
}

class FieldTileData {
  const FieldTileData({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

class FieldTile extends StatelessWidget {
  const FieldTile({super.key, required this.data});

  final FieldTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(data.icon, color: colorScheme.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.value.isEmpty ? '-' : data.value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
