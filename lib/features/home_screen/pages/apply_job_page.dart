import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/features/home_screen/widgets/apply_job_helpers.dart';
import 'package:work_hub/generated/l10n.dart';

class ApplyJobPage extends StatefulWidget {
  const ApplyJobPage({super.key, required this.job});

  final JobPost job;

  @override
  State<ApplyJobPage> createState() => ApplyJobPageState();
}

class ApplyJobPageState extends State<ApplyJobPage> {
  final formKey = GlobalKey<FormState>();
  final nameArController = TextEditingController();
  final nameEnController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  String phoneCode = '+218';

  @override
  void dispose() {
    nameArController.dispose();
    nameEnController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final fieldDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.6)),
    );
    final surfaceFill = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    final nameArLabel = s.applyNameArLabel;
    final nameArHint = s.applyNameArHint;
    final nameEnLabel = s.applyNameEnLabel;
    final nameEnHint = s.applyNameEnHint;
    final phoneLabel = s.applyPhoneLabel;
    final phoneHint = s.applyPhoneHint;
    final phoneRequired = s.fieldRequired;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Directionality(
        textDirection: fieldDirection,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    child: Icon(
                      Icons.work_outline,
                      size: 38,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                LabeledField(
                  showLabel: false,
                  label: nameArLabel,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: AlignedTextField(
                    controller: nameArController,
                    isArabic: isArabic,
                    decoration: InputDecoration(
                      labelText: nameArLabel,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: nameArHint,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.4,
                        ),
                      ),
                      filled: true,
                      fillColor: surfaceFill,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.trim().isEmpty
                                ? phoneRequired
                                : null,
                  ),
                ),
                const SizedBox(height: 18),
                LabeledField(
                  showLabel: false,
                  label: nameEnLabel,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: AlignedTextField(
                    controller: nameEnController,
                    isArabic: isArabic,
                    decoration: InputDecoration(
                      labelText: nameEnLabel,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: nameEnHint,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.4,
                        ),
                      ),
                      filled: true,
                      fillColor: surfaceFill,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                LabeledField(
                  showLabel: false,
                  label: phoneLabel,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: Row(
                    children: [
                      if (isArabic) ...[
                        Expanded(
                          flex: 6,
                          child: PhoneCodeField(
                            border: border,
                            colorScheme: colorScheme,
                            textDirection: fieldDirection,
                            value: phoneCode,
                            onChanged: (val) {
                              if (val != null) setState(() => phoneCode = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 10,
                          child: PhoneNumberField(
                            controller: phoneController,
                            border: border,
                            colorScheme: colorScheme,
                            isArabic: isArabic,
                            labelText: phoneLabel,
                            hintText: phoneHint,
                            requiredText: phoneRequired,
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          flex: 10,
                          child: PhoneNumberField(
                            controller: phoneController,
                            border: border,
                            colorScheme: colorScheme,
                            isArabic: isArabic,
                            labelText: phoneLabel,
                            hintText: phoneHint,
                            requiredText: phoneRequired,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 6,
                          child: PhoneCodeField(
                            border: border,
                            colorScheme: colorScheme,
                            textDirection: fieldDirection,
                            value: phoneCode,
                            onChanged: (val) {
                              if (val != null) setState(() => phoneCode = val);
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                LabeledField(
                  showLabel: false,
                  label: s.loginEmail,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: AlignedTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    isArabic: isArabic,
                    decoration: InputDecoration(
                      labelText: s.loginEmail,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: s.loginEmailHint,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.4,
                        ),
                      ),
                      filled: true,
                      fillColor: surfaceFill,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return s.loginEmailRequired;
                      }
                      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!emailRegex.hasMatch(val.trim())) {
                        return s.loginEmailInvalid;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: submit,
                    child: Text(
                      s.applyNow,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    submitApplication();
  }

  Future<void> submitApplication() async {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: s.dialogWarningTitle,
        desc: s.dialogLoginRequiredDesc,
        btnOkText: s.dialogOk,
        btnOkOnPress: () {},
      ).show();
      return;
    }

    final existing =
        await FirebaseFirestore.instance
            .collection('job_applications')
            .where('job_id', isEqualTo: widget.job.id)
            .where('applicant_uid', isEqualTo: user.uid)
            .limit(1)
            .get();
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    if (existing.docs.isNotEmpty) {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: s.dialogWarningTitle,
        desc:
            isArabic
                ? 'لقد تقدمت لهذه الوظيفة مسبقاً.'
                : 'You already applied for this job.',
        btnOkText: s.dialogOk,
        btnOkOnPress: () {},
      ).show();
      return;
    }

    final profileDoc = await FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.uid)
        .get();
    final profile = profileDoc.data() ?? {};
    final cvUrl = (profile['cv_url'] as String?)?.trim() ?? '';
    if (cvUrl.isEmpty) {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: s.dialogWarningTitle,
        desc: s.profileNoData,
        btnOkText: s.dialogOk,
        btnOkOnPress: () {},
      ).show();
      return;
    }

    final data = {
      'job_id': widget.job.id,
      'employer_id': widget.job.ownerId,
      'applicant_uid': user.uid,
      'name_ar': nameArController.text.trim(),
      'name_en': nameEnController.text.trim(),
      'phone_code': phoneCode,
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'cv_url': cvUrl,
      'status': 'pending',
      'sent_at': FieldValue.serverTimestamp(),
    };

    try {
      final apps = FirebaseFirestore.instance.collection('job_applications');
      final notif = FirebaseFirestore.instance.collection(
        'employer_notifications',
      );
      final appRef = await apps.add(data);
      if (widget.job.ownerId.isNotEmpty) {
        await notif.add({
          'employer_id': widget.job.ownerId,
          'type': 'application',
          'application_id': appRef.id,
          'job_id': widget.job.id,
          'job_title': widget.job.title,
          'seen': false,
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: s.dialogSuccessTitle,
        desc:
            isArabic
                ? 'تم إرسال طلبك بنجاح.'
                : 'Your application was sent successfully.',
        btnOkText: s.dialogOk,
        btnOkOnPress: () {},
      ).show();
      if (mounted) Navigator.of(context).maybePop();
    } catch (e) {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: s.dialogErrorTitle,
        desc: e.toString(),
        btnOkText: s.dialogClose,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
