import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerEditAboutPage extends StatefulWidget {
  const EmployerEditAboutPage({super.key, required this.initialData});

  final Map<String, dynamic> initialData;

  @override
  State<EmployerEditAboutPage> createState() => _EmployerEditAboutPageState();
}

class _EmployerEditAboutPageState extends State<EmployerEditAboutPage> {
  late final TextEditingController _aboutArController;
  late final TextEditingController _aboutEnController;
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _aboutArController = TextEditingController(
      text: widget.initialData['about'] as String? ?? '',
    );
    _aboutEnController = TextEditingController(
      text: widget.initialData['about_en'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _aboutArController.dispose();
    _aboutEnController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final s = S.of(context);
    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance
          .collection('employers')
          .doc(user.uid)
          .update({
            'about': _aboutArController.text.trim(),
            'about_en': _aboutEnController.text.trim(),
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
      if (mounted) setState(() => _isSaving = false);
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
            overlayChild: _AboutHeader(title: s.employerEditAboutHeader),
            overlayHeight: 80,
            height: 190,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DescriptionField(
                      label: s.employerEditAboutLabelArabic,
                      controller: _aboutArController,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 24),
                    _DescriptionField(
                      label: s.employerEditAboutLabelEnglish,
                      controller: _aboutEnController,
                      textDirection: TextDirection.ltr,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child:
                            _isSaving
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

class _AboutHeader extends StatelessWidget {
  const _AboutHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.45 : 0.1,
            ),
            blurRadius: 14,
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({
    required this.label,
    required this.controller,
    required this.textDirection,
  });

  final String label;
  final TextEditingController controller;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = colorScheme.outline.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.5 : 0.25,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 6,
          minLines: 4,
          textDirection: textDirection,
          textAlign:
              textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          validator:
              (value) =>
                  (value ?? '').trim().isEmpty
                      ? S.of(context).employerEditAboutValidationRequired
                      : null,
        ),
      ],
    );
  }
}
