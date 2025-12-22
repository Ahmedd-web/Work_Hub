import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_account_page.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/features/employer/screens/employer_resumes_page.dart';
import 'package:work_hub/features/employer/widgets/employer_bottom_nav.dart';
import 'package:work_hub/features/employer/widgets/employer_jobs_search_field.dart';
import 'package:work_hub/features/employer/widgets/employer_jobs_tabs.dart';
import 'package:work_hub/features/employer/widgets/employer_job_card.dart';
import 'package:work_hub/features/employer/widgets/employer_job_card_shimmer.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/networking/notification_service.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/features/employer/screens/employer_notifications_page.dart';

class EmployerJobsPage extends StatefulWidget {
  const EmployerJobsPage({super.key});

  @override
  State<EmployerJobsPage> createState() => EmployerJobsPageState();
}

class JobEntry {
  const JobEntry({required this.id, required this.data});
  final String id;
  final Map<String, dynamic> data;
}

class EmployerJobsPageState extends State<EmployerJobsPage> {
  final int currentNavIndex = 1;
  int statusIndex = 0;
  String searchQuery = '';

  final List<String> statusFilters = ['active', 'archived', 'deleted'];
  final Set<String> pendingExpirationUpdates = {};
  final Set<String> pendingWarningUpdates = {};

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

  void scheduleExpiryWarning({
    required String jobId,
    required String ownerUid,
    required String jobTitle,
  }) {
    if (pendingWarningUpdates.contains(jobId)) return;
    pendingWarningUpdates.add(jobId);

    NotificationService.instance
        .sendJobExpiryReminder(
          ownerUid: ownerUid,
          jobId: jobId,
          jobTitle: jobTitle,
        )
        .catchError((_) {})
        .whenComplete(() {
          FirebaseFirestore.instance
              .collection('job_posts')
              .doc(jobId)
              .update({'expiry_warning_sent': true})
              .catchError((_) {});
          pendingWarningUpdates.remove(jobId);
        });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          StreamBuilder<int>(
            stream: uid == null
                ? const Stream.empty()
                : FirebaseFirestore.instance
                    .collection('employer_notifications')
                    .where('employer_id', isEqualTo: uid)
                    .where('seen', isEqualTo: false)
                    .snapshots()
                    .map((snap) => snap.size),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return CustomHeader(
                title: '',
                titleWidget: const SizedBox.shrink(),
                backgroundColor: AppColors.purple,
                backgroundImage: AppAssets.headerLogo,
                showBackButton: false,
                showMenuButton: true,
                showNotificationButton: true,
                notificationCount: count > 0 ? count : null,
                onNotificationPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const EmployerNotificationsPage(),
                    ),
                  );
                },
                showSearchBar: false,
                overlayChild: EmployerJobsSearchField(
                  initialValue: searchQuery,
                  hintText: s.employerJobsSearchHint,
                  onChanged: (value) => setState(() => searchQuery = value),
                ),
                overlayHeight: 70,
                height: 160,
              );
            },
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
                                  child: EmployerJobCardShimmer(),
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
                          final ownerUid =
                              (data['owner_uid'] as String?) ?? user.uid;

                          // إذا كان الإعلان غير نشط (مؤرشف/محذوف) نتجاهل منطق الانتهاء.
                          if (status != 'active') {
                            final matchesStatus = status == statusKey;
                            final matchesSearch =
                                query.isEmpty
                                    ? true
                                    : title.toLowerCase().contains(query);
                            if (matchesStatus && matchesSearch) {
                              jobs.add(JobEntry(id: doc.id, data: data));
                            }
                            continue;
                          }
                          final expired =
                              status != 'deleted' && hasExpired(createdAt, now);
                          final effectiveStatus = expired ? 'deleted' : status;
                          final expiryWarningSent =
                              (data['expiry_warning_sent'] as bool?) ?? false;

                          if (!expired &&
                              !expiryWarningSent &&
                              createdAt != null) {
                            final expiryTime = createdAt.toDate().add(
                              const Duration(days: 1),
                            );
                            final warnAt = expiryTime.subtract(
                              const Duration(hours: 1),
                            );
                            final needsWarning =
                                now.isAfter(warnAt) && now.isBefore(expiryTime);
                            if (needsWarning) {
                              scheduleExpiryWarning(
                                jobId: doc.id,
                                ownerUid: ownerUid,
                                jobTitle: title.isEmpty ? 'إعلانك' : title,
                              );
                            }
                          }

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
                            EmployerJobsTabs(
                              currentIndex: statusIndex,
                              onChanged:
                                  (index) =>
                                      setState(() => statusIndex = index),
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
                                  child: EmployerJobCard(
                                    data: job.data,
                                    jobId: job.id,
                                  ),
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
