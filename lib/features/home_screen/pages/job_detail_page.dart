import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/generated/l10n.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({
    super.key,
    required this.job,
    this.isFavorite = false,
    this.onToggleFavorite,
  });

  final JobPost job;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  Locale? _lastLocale;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    if (_lastLocale == null || _lastLocale != locale) {
      setState(() {
        _lastLocale = locale;
      });
    }
  }

  @override
  void didUpdateWidget(covariant JobDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      setState(() {
        _isFavorite = widget.isFavorite;
      });
    }
  }

  void _handleFavoritePressed() {
    widget.onToggleFavorite?.call();
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = theme.dividerColor.withValues(alpha: 0.5);
    final tabBackground = colorScheme.primary.withValues(alpha: 0.08);
    final cardColor = theme.cardColor;
    final job = widget.job;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          foregroundColor: colorScheme.onSurface,
          title: Text(
            job.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(_isFavorite ? Icons.bookmark : Icons.bookmark_border),
              onPressed: _handleFavoritePressed,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: colorScheme.primary.withValues(
                        alpha: 0.12,
                      ),
                      child: Text(
                        job.companyLabel.characters
                            .take(2)
                            .toUpperCase()
                            .join(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      job.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.companyLabel,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _InfoRow(
                      location: job.location,
                      experience: job.experience ?? '1',
                      salary: job.salary ?? '-',
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: tabBackground,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              labelColor: colorScheme.primary,
                              unselectedLabelColor: colorScheme.primary
                                  .withValues(alpha: 0.6),
                              tabs: [
                                Tab(text: s.jobInfoTab),
                                Tab(text: s.companyInfoTab),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 360,
                            child: TabBarView(
                              children: [
                                _JobInfoSection(job: job),
                                _CompanyInfoSection(job: job),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    s.applyNow,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.location,
    required this.experience,
    required this.salary,
  });

  final String location;
  final String experience;
  final String salary;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardColor = theme.cardColor;
    final dividerColor = theme.dividerColor.withValues(alpha: 0.6);
    final shadowColor =
        theme.brightness == Brightness.dark
            ? Colors.transparent
            : Colors.black.withValues(alpha: 0.05);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: dividerColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _InfoItem(
                icon: Icons.location_on_outlined,
                label: s.jobDetailLocationLabel,
                value: location,
                color: colorScheme.primary,
              ),
            ),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: dividerColor,
            ),
            Expanded(
              child: _InfoItem(
                icon: Icons.timer_outlined,
                label: s.jobDetailExperienceLabel,
                value: experience,
                color: colorScheme.primary,
              ),
            ),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: dividerColor,
            ),
            Expanded(
              child: _InfoItem(
                icon: Icons.attach_money,
                label: s.jobDetailSalaryLabel,
                value: salary,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _JobInfoSection extends StatelessWidget {
  const _JobInfoSection({required this.job});

  final JobPost job;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final descriptionValue = job.description?.trim();
    final details = [
      _DetailItem(label: s.jobDetailJobTitle, value: job.title),
      _DetailItem(
        label: s.jobDetailExperienceYears,
        value: job.experience ?? '-',
      ),
      _DetailItem(
        label: s.jobDetailEducationLevel,
        value: job.educationLevel ?? '-',
      ),
      _DetailItem(label: s.jobDetailDepartment, value: job.department ?? '-'),
      _DetailItem(label: s.jobDetailNationality, value: job.nationality ?? '-'),
      _DetailItem(label: s.jobDetailWorkLocation, value: job.location),
      _DetailItem(label: s.jobDetailCity, value: job.city ?? '-'),
      _DetailItem(label: s.jobDetailSalaryLabel, value: job.salary ?? '-'),
      _DetailItem(label: s.jobDetailDeadline, value: job.deadline ?? '-'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.jobInfoSectionTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _DetailsCard(items: details),
          const SizedBox(height: 18),
          Text(
            s.jobDescriptionTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            (descriptionValue == null || descriptionValue.isEmpty)
                ? '-'
                : descriptionValue,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _CompanyInfoSection extends StatelessWidget {
  const _CompanyInfoSection({required this.job});

  final JobPost job;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final aboutValue = job.companySummary?.trim();
    final details = [
      _DetailItem(label: s.jobDetailCompanyNameLabel, value: job.companyLabel),
      _DetailItem(label: s.jobDetailWorkLocation, value: job.location),
      _DetailItem(label: s.jobDetailCity, value: job.city ?? '-'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.companyInfoSectionTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _DetailsCard(items: details),
          const SizedBox(height: 18),
          Text(
            s.jobDetailCompanySummary,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            (aboutValue == null || aboutValue.isEmpty) ? '-' : aboutValue,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final secondaryColor = textTheme.bodyMedium?.color?.withValues(alpha: 0.7);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.items});

  final List<_DetailItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withValues(alpha: 0.6);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _DetailRow(label: items[i].label, value: items[i].value),
            if (i != items.length - 1) Divider(height: 1, color: borderColor),
          ],
        ],
      ),
    );
  }
}

class _DetailItem {
  const _DetailItem({required this.label, required this.value});

  final String label;
  final String value;
}
