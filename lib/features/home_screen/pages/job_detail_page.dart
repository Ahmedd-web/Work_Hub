import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/pages/apply_job_page.dart';
import 'package:work_hub/features/home_screen/widgets/job_detail_info_row.dart';
import 'package:work_hub/features/home_screen/widgets/job_detail_sections.dart';
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
  State<JobDetailPage> createState() => JobDetailPageState();
}

class JobDetailPageState extends State<JobDetailPage> {
  Locale? lastLocale;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    if (lastLocale == null || lastLocale != locale) {
      setState(() {
        lastLocale = locale;
      });
    }
  }

  @override
  void didUpdateWidget(covariant JobDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      setState(() {
        isFavorite = widget.isFavorite;
      });
    }
  }

  void handleFavoritePressed() {
    widget.onToggleFavorite?.call();
    setState(() {
      isFavorite = !isFavorite;
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
          title: const SizedBox.shrink(),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
              onPressed: handleFavoritePressed,
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
                    InfoRow(
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
                                JobInfoSection(job: job),
                                CompanyInfoSection(job: job),
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ApplyJobPage(job: job)),
                    );
                  },
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
