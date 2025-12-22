import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class ApplicantNotificationsPage extends StatelessWidget {
  const ApplicantNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final loginText =
        isArabic ? 'سجّل الدخول لرؤية الإشعارات' : 'Sign in to view notifications';
    final loadErrorText =
        isArabic ? 'خطأ في تحميل الإشعارات' : 'Error loading notifications';
    final emptyText = isArabic ? 'لا توجد إشعارات' : 'No notifications';

    if (user == null) {
      return Scaffold(
        body: Center(child: Text(loginText)),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(
            title: '',
            showBackButton: true,
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showNotificationButton: false,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('notifications')
                  .where('user_uid', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final err = snapshot.error?.toString() ?? loadErrorText;
                  return Center(child: Text(err));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];

                // Sort locally to avoid composite index requirement.
                docs.sort((a, b) {
                  final ta = a.data()['created_at'];
                  final tb = b.data()['created_at'];
                  final da = ta is Timestamp ? ta.toDate() : DateTime.now();
                  final db = tb is Timestamp ? tb.toDate() : DateTime.now();
                  return db.compareTo(da); // newest first
                });

                for (final doc in docs) {
                  if ((doc.data()['read'] as bool?) != true) {
                    doc.reference.update({'read': true});
                  }
                }

                if (docs.isEmpty) {
                  return Center(child: Text(emptyText));
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final data = docs[index].data();
                    final status = (data['status'] as String?) ?? '';
                    final jobTitle = (data['job_title'] as String?) ?? '';
                    final isAccepted = status == 'accepted';
                    final isRejected = status == 'rejected';
                    final title = data['title'] as String? ??
                        (isAccepted
                            ? (isArabic ? 'تم قبول طلبك' : 'Application accepted')
                            : isRejected
                                ? (isArabic ? 'تم رفض طلبك' : 'Application declined')
                                : (isArabic ? 'إشعار' : 'Notification'));
                    final body = data['body'] as String? ??
                        (isAccepted
                            ? (isArabic
                                ? 'تم قبولك في وظيفة $jobTitle. تواصل مع الشركة.'
                                : 'You were accepted for $jobTitle. Please contact the company.')
                            : isRejected
                                ? (isArabic
                                    ? 'تم رفض طلبك في وظيفة $jobTitle.'
                                    : 'Your application for $jobTitle was declined.')
                                : jobTitle);

                    final badgeColor = isAccepted
                        ? Colors.green
                        : isRejected
                            ? Colors.redAccent
                            : AppColors.purple;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                        border: Border.all(
                          color: badgeColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(top: 6, right: 6),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  body,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
