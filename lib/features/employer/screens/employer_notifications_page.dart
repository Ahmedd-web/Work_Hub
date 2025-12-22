// ignore_for_file: unused_element

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/cv_data.dart';
import 'package:work_hub/features/home_screen/services/cv_repository.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/networking/notification_service.dart';

// ignore_for_file: use_build_context_synchronously

// Temporary fallbacks until l10n is regenerated with notif keys.
extension NotifStrings on S {
  String get notifLoginRequired => 'الرجاء تسجيل الدخول للوصول إلى الإشعارات.';
  String get notifTitle => 'الإشعارات';
  String notifError(String error) => 'خطأ: $error';
  String get notifEmpty => 'لا توجد إشعارات حالياً';
  String get notifNewApplication => 'طلب تقدم جديد';
  String get notifUntitledJob => 'بدون عنوان وظيفة';
  String get notifApplicantNotFound => 'لم يتم العثور على الطلب';
  String get notifCvMissing => 'لا توجد سيرة ذاتية محفوظة لهذا المستخدم.';
  String get notifAccept => 'قبول';
  String get notifReject => 'رفض';
  String get notifSuccessAccept => 'تم قبول الطلب بنجاح';
  String get notifSuccessReject => 'تم رفض الطلب بنجاح';
  String get notifCopyCv => 'نسخ الرابط';
  String get notifOpenCv => 'فتح الملف';
  String get notifPhone => 'الهاتف';
  String get notifEmail => 'البريد الإلكتروني';
}

class EmployerNotificationsPage extends StatelessWidget {
  const EmployerNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(body: Center(child: Text(s.notifLoginRequired)));
    }

    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            title: '',
            showBackButton: true,
            showNotificationButton: false,
            showMenuButton: false,
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            onBackPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance
                      .collection('employer_notifications')
                      .where('employer_id', isEqualTo: user.uid)
                      .snapshots(),
              builder: (context, snapshot) {
                final theme = Theme.of(context);
                final colorScheme = theme.colorScheme;
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      s.notifError('${snapshot.error}'),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final rawDocs = snapshot.data!.docs.toList();
                final cutoff = DateTime.now().subtract(
                  const Duration(hours: 24),
                );
                final freshDocs =
                    <QueryDocumentSnapshot<Map<String, dynamic>>>[];
                final staleDocs =
                    <QueryDocumentSnapshot<Map<String, dynamic>>>[];

                for (final doc in rawDocs) {
                  final ts = doc.data()['created_at'] as Timestamp?;
                  final dt = ts?.toDate();
                  if (dt != null && dt.isBefore(cutoff)) {
                    staleDocs.add(doc);
                  } else {
                    freshDocs.add(doc);
                  }
                }

                if (staleDocs.isNotEmpty) {
                  purgeStaleNotifications(staleDocs);
                }

                freshDocs.sort((a, b) {
                  final ta =
                      (a.data()['created_at'] as Timestamp?)
                          ?.toDate()
                          .millisecondsSinceEpoch ??
                      0;
                  final tb =
                      (b.data()['created_at'] as Timestamp?)
                          ?.toDate()
                          .millisecondsSinceEpoch ??
                      0;
                  return tb.compareTo(ta);
                });

                if (freshDocs.isEmpty) {
                  return Center(child: Text(s.notifEmpty));
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: freshDocs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final data = freshDocs[index].data();
                    final jobTitle = (data['job_title'] as String?) ?? '';
                    final applicationId =
                        (data['application_id'] as String?) ?? '';
                    final seen = (data['seen'] as bool?) ?? false;

                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: seen ? 0.65 : 1.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => ApplicantProfilePage(
                                    applicationId: applicationId,
                                    notificationId: freshDocs[index].id,
                                    jobTitle: jobTitle,
                                  ),
                            ),
                          );
                        },
                        splashColor: colorScheme.primary.withValues(
                          alpha: 0.12,
                        ),
                        highlightColor: colorScheme.primary.withValues(
                          alpha: 0.08,
                        ),
                        child: NotificationCard(
                          jobTitle:
                              jobTitle.isEmpty ? s.notifUntitledJob : jobTitle,
                          seen: seen,
                          colorScheme: colorScheme,
                          theme: theme,
                        ),
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

class ApplicantProfilePage extends StatefulWidget {
  const ApplicantProfilePage({
    super.key,
    required this.applicationId,
    required this.notificationId,
    required this.jobTitle,
  });

  final String applicationId;
  final String notificationId;
  final String jobTitle;

  @override
  State<ApplicantProfilePage> createState() => ApplicantProfilePageState();
}

class ApplicantProfilePageState extends State<ApplicantProfilePage> {
  late Future<ApplicantBundle> future;

  @override
  void initState() {
    super.initState();
    future = loadApplication();
  }

  Future<ApplicantBundle> loadApplication() async {
    final snap =
        await FirebaseFirestore.instance
            .collection('job_applications')
            .doc(widget.applicationId)
            .get();

    if (snap.exists && widget.notificationId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('employer_notifications')
          .doc(widget.notificationId)
          .update({'seen': true});
    }

    final data = snap.data();
    final applicantUid = data?['applicant_uid'] as String? ?? '';
    CvData? cv;
    if (applicantUid.isNotEmpty) {
      cv = await CvRepository.fetchCv(applicantUid);
    }

    return ApplicantBundle(appData: data, cv: cv);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            title: '',
            showBackButton: true,
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            onBackPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: FutureBuilder<ApplicantBundle>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ApplicantLoadingShimmer();
                }
                final bundle = snapshot.data;
                if (bundle == null || bundle.appData == null) {
                  return Center(child: Text(s.notifApplicantNotFound));
                }

                final data = bundle.appData!;
                final nameAr = (data['name_ar'] as String?) ?? '';
                final nameEn = (data['name_en'] as String?) ?? '';
                final phone =
                    '${data['phone_code'] ?? ''} ${data['phone'] ?? ''}'.trim();
                final email = (data['email'] as String?) ?? '';
                final cvUrl = (data['cv_url'] as String?) ?? '';
                final applicantUid = (data['applicant_uid'] as String?) ?? '';
                final cv = bundle.cv;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ApplicantHeroCard(
                        nameAr: nameAr,
                        nameEn: nameEn,
                        jobTitle: widget.jobTitle,
                        phone: phone,
                        email: email,
                        cvUrl: cvUrl,
                        copyLabel: s.notifCopyCv,
                        openLabel: s.notifOpenCv,
                        phoneLabel: s.notifPhone,
                        emailLabel: s.notifEmail,
                        onCopyCv:
                            cvUrl.isEmpty
                                ? null
                                : () => copyCvLink(context, cvUrl),
                        onOpenCv:
                            cvUrl.isEmpty ? null : () => openCvLink(cvUrl),
                      ),
                      const SizedBox(height: 16),
                      if (cv != null)
                        CvResumeView(data: cv, s: s)
                      else
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: colorScheme.outline.withValues(
                                alpha:
                                    theme.brightness == Brightness.dark
                                        ? 0.25
                                        : 0.18,
                              ),
                            ),
                          ),
                          child: Text(
                            s.notifCvMissing,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed:
                                  () => updateStatus(
                                    status: 'accepted',
                                    applicantUid: applicantUid,
                                    jobTitle: widget.jobTitle,
                                  ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bannerGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(s.notifAccept),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed:
                                  () => updateStatus(
                                    status: 'rejected',
                                    applicantUid: applicantUid,
                                    jobTitle: widget.jobTitle,
                                  ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: const BorderSide(color: Colors.redAccent),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                s.notifReject,
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateStatus({
    required String status,
    required String applicantUid,
    required String jobTitle,
  }) async {
    final s = S.of(context);
    final ref = FirebaseFirestore.instance
        .collection('job_applications')
        .doc(widget.applicationId);
    await ref.update({'status': status});
    if (widget.notificationId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('employer_notifications')
          .doc(widget.notificationId)
          .delete();
    }
    if (applicantUid.isNotEmpty) {
      await FirebaseFirestore.instance.collection('notifications').add({
        'user_uid': applicantUid,
        'type': 'application_status',
        'status': status,
        'job_title': jobTitle,
        'created_at': FieldValue.serverTimestamp(),
        'read': false,
      });
     
      final title =
          status == 'accepted' ? s.notifSuccessAccept : s.notifSuccessReject;
      final body = status == 'accepted' ? s.notifAccept : s.notifReject;
      await NotificationService.instance.enqueueStatusNotification(
        targetUid: applicantUid,
        title: title,
        body: body,
        data: {
          'type': 'application_status',
          'status': status,
          'job_title': jobTitle,
          'application_id': widget.applicationId,
        },
      );
    }
    if (!mounted) return;
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: s.notifTitle,
      desc: status == 'accepted' ? s.notifSuccessAccept : s.notifSuccessReject,
      btnOkText: s.dialogOk,
      btnOkOnPress: () {},
    ).show();
    if (mounted) Navigator.of(context).maybePop();
  }

  Future<void> copyCvLink(BuildContext context, String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).notifCopyCv)));
  }

  Future<void> openCvLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class ApplicantBundle {
  ApplicantBundle({required this.appData, required this.cv});

  final Map<String, dynamic>? appData;
  final CvData? cv;
}

class ApplicantHeroCard extends StatelessWidget {
  const ApplicantHeroCard({
    required this.nameAr,
    required this.nameEn,
    required this.jobTitle,
    required this.phone,
    required this.email,
    required this.cvUrl,
    required this.copyLabel,
    required this.openLabel,
    required this.phoneLabel,
    required this.emailLabel,
    this.onCopyCv,
    this.onOpenCv,
  });

  final String nameAr;
  final String nameEn;
  final String jobTitle;
  final String phone;
  final String email;
  final String cvUrl;
  final String copyLabel;
  final String openLabel;
  final String phoneLabel;
  final String emailLabel;
  final VoidCallback? onCopyCv;
  final VoidCallback? onOpenCv;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarInitials = initials(nameAr.isNotEmpty ? nameAr : nameEn);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.08,
            ),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.15,
                ),
                child: Text(
                  avatarInitials,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.purple,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameAr.isEmpty ? S.of(context).profileNoData : nameAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (nameEn.isNotEmpty)
                      Text(
                        nameEn,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    if (jobTitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          jobTitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.bannerGreen,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.phone_outlined,
            label: phoneLabel,
            value: phone.isEmpty ? '-' : phone,
          ),
          InfoRow(
            icon: Icons.mail_outline,
            label: emailLabel,
            value: email.isEmpty ? '-' : email,
          ),
          if (cvUrl.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (onOpenCv != null)
                  OutlinedButton.icon(
                    onPressed: onOpenCv,
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: Text(openLabel),
                  ),
                if (onCopyCv != null)
                  OutlinedButton.icon(
                    onPressed: onCopyCv,
                    icon: const Icon(Icons.copy),
                    label: Text(copyLabel),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.take(1).toString();
    return parts.take(2).map((e) => e.characters.first).join();
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class CvResumeView extends StatelessWidget {
  const CvResumeView({required this.data, required this.s});

  final CvData data;
  final S s;

  @override
  Widget build(BuildContext context) {
    final spacer = const SizedBox(height: 14);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CvSectionCard(
          title: s.cvSectionMainInfo,
          icon: Icons.badge_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CvRow(label: s.cvFieldJobTitleAr, value: data.jobTitleAr),
              CvRow(label: s.cvFieldJobTitleEn, value: data.jobTitleEn),
              CvRow(
                label: s.cvFieldEducationLevel,
                value: data.educationLevel,
              ),
              CvRow(
                label: s.cvFieldYearsExperience,
                value: data.yearsExperience,
              ),
            ],
          ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionContact,
          icon: Icons.phone_iphone_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.cvSectionContactPhones, style: theme.textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(data.phones.isEmpty ? '-' : data.phones.join('\n')),
              const SizedBox(height: 10),
              Text(s.cvSectionContactEmail, style: theme.textTheme.labelLarge),
              const SizedBox(height: 6),
              Text(data.email.isEmpty ? '-' : data.email),
            ],
          ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionSkills,
          icon: Icons.auto_awesome_outlined,
          child:
              data.skills.isEmpty
                  ? Text(s.cvSkillsEmpty)
                  : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        data.skills.map((skill) {
                          final isDark = theme.brightness == Brightness.dark;
                          final bg =
                              isDark
                                  ? theme.colorScheme.surfaceContainerHighest
                                      .withValues(alpha: 0.6)
                                  : AppColors.pillBackground;
                          final fg =
                              isDark
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onSurface;
                          return Chip(
                            label: Text(
                              skill,
                              style: TextStyle(
                                color: fg,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: bg,
                          );
                        }).toList(),
                  ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionSummary,
          icon: Icons.article_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CvRow(
                label: s.cvFieldSummaryAr,
                value: data.summaryAr,
                alignTop: true,
              ),
              CvRow(
                label: s.cvFieldSummaryEn,
                value: data.summaryEn,
                alignTop: true,
              ),
            ],
          ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionEducation,
          icon: Icons.school_outlined,
          child:
              data.education.isEmpty
                  ? Text(s.cvNoData)
                  : Column(
                    children:
                        data.education
                            .map(
                              (edu) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      edu.institution.isEmpty
                                          ? '-'
                                          : edu.institution,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${s.cvEducationMajorAr}: ${edu.majorAr.isEmpty ? '-' : edu.majorAr}',
                                    ),
                                    Text(
                                      '${s.cvEducationMajorEn}: ${edu.majorEn.isEmpty ? '-' : edu.majorEn}',
                                    ),
                                    Text(
                                      '${s.cvEducationStartDate}: ${edu.startDate.isEmpty ? '-' : edu.startDate}',
                                    ),
                                    Text(
                                      '${s.cvEducationEndDate}: ${edu.endDate.isEmpty ? '-' : edu.endDate}',
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionCourses,
          icon: Icons.menu_book_outlined,
          child:
              data.courses.isEmpty
                  ? Text(s.cvNoData)
                  : Column(
                    children:
                        data.courses
                            .map(
                              (course) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title.isEmpty ? '-' : course.title,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${s.cvCourseOrganization}: ${course.organization.isEmpty ? '-' : course.organization}',
                                    ),
                                    Text(
                                      '${s.cvCourseDate}: ${course.date.isEmpty ? '-' : course.date}',
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
        ),
        spacer,
        CvSectionCard(
          title: s.cvSectionExperience,
          icon: Icons.work_outline,
          child:
              data.experiences.isEmpty
                  ? Text(s.cvNoData)
                  : Column(
                    children:
                        data.experiences
                            .map(
                              (exp) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${exp.companyAr.isEmpty ? '-' : exp.companyAr} / ${exp.companyEn.isEmpty ? '-' : exp.companyEn}',
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${s.cvExperienceRoleAr}: ${exp.roleAr.isEmpty ? '-' : exp.roleAr}',
                                    ),
                                    Text(
                                      '${s.cvExperienceRoleEn}: ${exp.roleEn.isEmpty ? '-' : exp.roleEn}',
                                    ),
                                    Text(
                                      '${s.cvExperienceStartDate}: ${exp.startDate.isEmpty ? '-' : exp.startDate}',
                                    ),
                                    Text(
                                      '${s.cvExperienceEndDate}: ${exp.endDate.isEmpty ? '-' : exp.endDate}',
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      exp.description.isEmpty
                                          ? '-'
                                          : exp.description,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
        ),
      ],
    );
  }
}

class CvSectionCard extends StatelessWidget {
  const CvSectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.purple),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class CvRow extends StatelessWidget {
  const CvRow({
    required this.label,
    required this.value,
    this.alignTop = false,
  });

  final String label;
  final String value;
  final bool alignTop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment:
            alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.jobTitle,
    required this.seen,
    required this.colorScheme,
    required this.theme,
  });

  final String jobTitle;
  final bool seen;
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outline.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.2 : 0.12,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.mark_email_unread_outlined,
            color:
                seen
                    ? colorScheme.onSurface.withValues(alpha: 0.5)
                    : colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).notifNewApplication,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(jobTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.chevron_left),
        ],
      ),
    );
  }
}

class ApplicantLoadingShimmer extends StatelessWidget {
  const ApplicantLoadingShimmer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base =
        theme.brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.grey.shade300;
    final highlight =
        theme.brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.18)
            : Colors.grey.shade100;

    Widget block({double h = 16, double w = double.infinity, double r = 12}) {
      return Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(r),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  block(h: 60, w: 60, r: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        block(w: 160),
                        const SizedBox(height: 8),
                        block(w: 120),
                        const SizedBox(height: 6),
                        block(w: 90),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              4,
              (i) => Padding(
                padding: EdgeInsets.only(bottom: i == 3 ? 0 : 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      block(w: 140),
                      const SizedBox(height: 10),
                      block(),
                      const SizedBox(height: 8),
                      block(w: 220),
                    ],
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

Future<void> purgeStaleNotifications(
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
) async {
  try {
    final batch = FirebaseFirestore.instance.batch();
    for (final doc in docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  } catch (e) {
    debugPrint('purge stale notifications error: $e');
  }
}
