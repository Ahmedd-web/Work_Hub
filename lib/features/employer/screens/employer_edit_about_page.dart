import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/features/employer/widgets/employer_about_header.dart';
import 'package:work_hub/features/employer/widgets/employer_description_field.dart';

class EmployerEditAboutPage extends StatefulWidget {
  const EmployerEditAboutPage({super.key, required this.initialData});

  final Map<String, dynamic> initialData;

  @override
  State<EmployerEditAboutPage> createState() => EmployerEditAboutPageState();
}

class EmployerEditAboutPageState extends State<EmployerEditAboutPage> {
  late final TextEditingController aboutArController;
  late final TextEditingController aboutEnController;
  final formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    aboutArController = TextEditingController(
      text: widget.initialData['about'] as String? ?? '',
    );
    aboutEnController = TextEditingController(
      text: widget.initialData['about_en'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    aboutArController.dispose();
    aboutEnController.dispose();
    super.dispose();
  }

  Future<void>save() async {
    if (!formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final s = S.of(context);
    setState(() => isSaving = true);
    try {
      await FirebaseFirestore.instance
          .collection('employers')
          .doc(user.uid)
          .update({
            'about': aboutArController.text.trim(),
            'about_en': aboutEnController.text.trim(),
            'updated_at': FieldValue.serverTimestamp(),
          });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.employerEditAboutSuccess)),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text(s.employerEditAboutFailure('$e'))),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final s = S.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            showBackButton: true,
            overlayChild: EmployerAboutHeader(
              title: s.employerEditAboutHeader,
            ),
            overlayHeight: 80,
            height: 190,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EmployerDescriptionField(
                      label: s.employerEditAboutLabelArabic,
                      controller: aboutArController,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 24),
                    EmployerDescriptionField(
                      label: s.employerEditAboutLabelEnglish,
                      controller: aboutEnController,
                      textDirection: TextDirection.ltr,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child:
                            isSaving
                                ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : Text(
                                  s.employerEditAboutSaveButton,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
