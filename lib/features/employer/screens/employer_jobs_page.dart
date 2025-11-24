import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_job_detail_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerJobsPage extends StatefulWidget {
  const EmployerJobsPage({super.key});

  @override
  State<EmployerJobsPage> createState() => EmployerJobsPageState();
}

class EmployerJobsPageState extends State<EmployerJobsPage> {
  final int currentNavIndex = 1;
  int statusIndex = 0;
  String searchQuery = '';

  final List<String> statusFilters = ['active', 'archived', 'deleted'];
  final Set<String> pendingExpirationUpdates = {};

  List<String> statusLabels(S s) => [
    s.employerJobsStatusActive,
    s.employerJobsStatusArchived,
    s.employerJobsStatusDeleted,
  ];

  bool hasExpired(Timestamp? createdAt, DateTime now) {
    if (createdAt == null) return false;
    return now.isAfter(createdAt.toDate().add(const Duration(days: 1)));
  }

  void scheduleExpiration(String jobId) {
    if (pendingExpirationUpdates.contains(jobId)) return;
    pendingExpirationUpdates.add(jobId);
    FirebaseFirestore.instance
        .collection('job_posts')
        .doc(jobId)
        .update({'status': 'deleted'})
        .catchError((error) {})
        .whenComplete(() => pendingExpirationUpdates.remove(jobId));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final tabs = statusLabels(s);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showBackButton: false,
            showMenuButton: true,
            showNotificationButton: true,
            showSearchBar: false,
            overlayChild: JobsSearchField(
              initialValue: searchQuery,
              hintText: s.employerJobsSearchHint,
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            overlayHeight: 70,
            height: 160,
          ),
          Expanded(
            child:
                user == null
                    ? Center(
                      child: Text(
                        s.employerJobsLoginPrompt,
                        style: textTheme.bodyLarge,
                      ),
                    )
                    : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('job_posts')
                              .where('owner_uid', isEqualTo: user.uid)
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            !snapshot.hasData) {
                          return ListView.builder(
                            padding: const EdgeInsets.fromLTRB(20, 56, 20, 120),
                            itemCount: 3,
                            itemBuilder:
                                (context, index) => const Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: JobCardShimmer(),
                                ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              s.employerJobsLoadError(
                                '${snapshot.error ?? ''}',
                              ),
                              style: textTheme.bodyMedium,
                            ),
                          );
                        }

                        final docs = snapshot.data?.docs ?? [];
                        final statusKey = statusFilters[statusIndex];
                        final query = searchQuery.trim().toLowerCase();
                        final now = DateTime.now();
                        final List<JobEntry> jobs = [];

                        for (final doc in docs) {
                          final data = doc.data();
                          final status =
                              (data['status'] as String?) ?? 'active';
                          final title = (data['arabic_title'] as String?) ?? '';
                          final createdAt = data['created_at'] as Timestamp?;
                          final expired =
                              status != 'deleted' && hasExpired(createdAt, now);
                          final effectiveStatus = expired ? 'deleted' : status;

                          if (expired && status != 'deleted') {
                            scheduleExpiration(doc.id);
                          }

                          final matchesStatus = effectiveStatus == statusKey;
                          final matchesSearch =
                              query.isEmpty
                                  ? true
                                  : title.toLowerCase().contains(query);

                          if (matchesStatus && matchesSearch) {
                            final patchedData = Map<String, dynamic>.from(data);
                            patchedData['status'] = effectiveStatus;
                            jobs.add(JobEntry(id: doc.id, data: patchedData));
                          }
                        }

                        return ListView(
                          padding: const EdgeInsets.fromLTRB(20, 56, 20, 120),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  tabs.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final text = entry.value;
                                    final active = statusIndex == index;

                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: index == 0 ? 0 : 8,
                                          right:
                                              index == tabs.length - 1 ? 0 : 8,
                                        ),
                                        child: GestureDetector(
                                          onTap:
                                              () => setState(
                                                () => statusIndex = index,
                                              ),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color:
                                                  active
                                                      ? AppColors.purple
                                                      : theme.cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color:
                                                    active
                                                        ? Colors.transparent
                                                        : AppColors.purple,
                                              ),
                                              boxShadow:
                                                  active
                                                      ? [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withValues(
                                                                alpha: 0.04,
                                                              ),
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                            0,
                                                            2,
                                                          ),
                                                        ),
                                                      ]
                                                      : null,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color:
                                                    active
                                                        ? Colors.white
                                                        : textTheme
                                                                .bodyLarge
                                                                ?.color ??
                                                            AppColors.purple,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(height: 24),
                            if (jobs.isEmpty)
                              Center(
                                child: Text(
                                  s.employerJobsEmpty,
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: AppColors.bannerGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else
                              ...jobs.map(
                                (job) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: JobCard(data: job.data, jobId: job.id),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: EmployerBottomNav(
        currentIndex: currentNavIndex,
        onChanged: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const EmployerDashboardPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const EmployerResumesPage(),
              ),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const EmployerAccountPage(),
              ),
            );
          }
        },
      ),
    );
  }
}

class JobsSearchField extends StatelessWidget {
  const JobsSearchField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    required this.hintText,
  });

  final ValueChanged<String> onChanged;
  final String initialValue;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final width = MediaQuery.of(context).size.width * 0.9;
    final hintColor = (textTheme.bodyMedium?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.45);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final borderRadius = BorderRadius.circular(28);

    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        borderRadius: borderRadius,
        child: SizedBox(
          width: width,
          height: 56,
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.bodyMedium?.copyWith(color: hintColor),
              prefixIcon: Icon(Icons.search, color: hintColor),
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.data, required this.jobId});

  final Map<String, dynamic> data;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final status = (data['status'] as String?) ?? 'active';
    final rawTitle = (data['arabic_title'] as String?)?.trim();
    final experienceYears = (data['experience_years'] as String?) ?? '-';
    final educationLevel = (data['education_level'] as String?) ?? '-';
    final country = (data['country'] as String?) ?? '-';

    Color statusColor;
    String statusText;

    switch (status) {
      case 'archived':
        statusColor = Colors.orange;
        statusText = s.employerJobsStatusArchived;
        break;
      case 'deleted':
        statusColor = Colors.red;
        statusText = s.employerJobsStatusDeleted;
        break;
      default:
        statusColor = AppColors.bannerGreen;
        statusText = s.employerJobsStatusActive;
    }

    final jobTitle =
        (rawTitle == null || rawTitle.isEmpty)
            ? s.employerJobsDefaultTitle
            : rawTitle;

    final experienceLabel = s.employerJobsExperienceLabel(experienceYears);
    final educationLabel = s.employerJobsEducationLabel(educationLevel);

    final secondaryText = (textTheme.bodySmall?.color ?? colorScheme.onSurface)
        .withValues(alpha: 0.7);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => EmployerJobDetailPage(jobData: data, jobId: jobId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.25 : 0.04,
              ),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.place, size: 16, color: secondaryText),
                const SizedBox(width: 4),
                Text(
                  country,
                  style: textTheme.bodySmall?.copyWith(color: secondaryText),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.purple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        experienceLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: secondaryText,
                        ),
                      ),
                      Text(
                        educationLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F5EA),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(AppAssets.headerLogo, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class JobCardShimmer extends StatelessWidget {
  const JobCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final baseColor =
        isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade300;
    final highlightColor =
        isDark ? Colors.white.withValues(alpha: 0.2) : Colors.grey.shade100;

    Widget shimmerLine({double height = 14, double? width}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                shimmerLine(width: 100),
                const Spacer(),
                Container(
                  width: 70,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerLine(height: 18, width: double.infinity),
                      const SizedBox(height: 8),
                      shimmerLine(width: 140),
                      const SizedBox(height: 6),
                      shimmerLine(width: 120),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class JobEntry {
  const JobEntry({required this.id, required this.data});

  final String id;
  final Map<String, dynamic> data;
}
