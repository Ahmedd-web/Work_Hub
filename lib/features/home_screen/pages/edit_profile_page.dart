import 'dart:io' as io;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/profile_data.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.initialData});

  final ProfileData initialData;

  @override
  State<EditProfilePage> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController cvController;
  bool isSaving = false;
  bool isUploadingCv = false;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    nameController = TextEditingController(text: data.displayName);
    phoneController = TextEditingController(
      text: data.phoneDisplay == '-' ? '' : data.phoneDisplay,
    );
    emailController = TextEditingController(
      text: data.emailDisplay == '-' ? '' : data.emailDisplay,
    );
    cvController = TextEditingController(text: data.resumeDisplay);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cvController.dispose();
    super.dispose();
  }

  Future<void> pickAndUploadCv() async {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: s.dialogWarningTitle,
        desc: s.profileNoData,
        btnOkText: s.commonOk,
        btnOkOnPress: () {},
      ).show();
      return;
    }

    try {
      setState(() => isUploadingCv = true);
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;

      final picked = result.files.single;
      final ext = picked.extension?.toLowerCase();
      final contentType = switch (ext) {
        'pdf' => 'application/pdf',
        'doc' => 'application/msword',
        'docx' =>
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        _ => 'application/octet-stream',
      };
      final safeBase = (picked.name.trim().isEmpty ? 'resume' : picked.name)
          .replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
      final filename =
          (safeBase.endsWith('.pdf') ||
                  safeBase.endsWith('.doc') ||
                  safeBase.endsWith('.docx'))
              ? safeBase
              : '$safeBase.${ext ?? 'pdf'}';
      final storagePath =
          'cvs/${user.uid}/${DateTime.now().millisecondsSinceEpoch}_$filename';

      // استخدم البكت الافتراضي المعرّف في google-services (firebasestorage.app)
      final ref = FirebaseStorage.instanceFor(
        bucket: 'workhub-a9727.firebasestorage.app',
      ).ref(storagePath);
      TaskSnapshot snapshot;
      if (picked.bytes != null && picked.bytes!.isNotEmpty) {
        snapshot = await ref.putData(
          picked.bytes!,
          SettableMetadata(contentType: contentType),
        );
      } else if (picked.path != null) {
        final file = io.File(picked.path!);
        snapshot = await ref.putFile(
          file,
          SettableMetadata(contentType: contentType),
        );
      } else {
        throw Exception('no-file-data');
      }

      final url = await ref.getDownloadURL();
      if (!mounted) return;
      setState(() => cvController.text = url);
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: s.dialogSuccessTitle,
        desc: s.editProfileUpload,
        btnOkText: s.commonOk,
        btnOkOnPress: () {},
      ).show();
    } on FirebaseException catch (e) {
      if (!mounted) return;
      final isNotFound = e.code == 'object-not-found';
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: s.dialogErrorTitle,
        desc:
            isNotFound
                ? 'تعذر رفع الملف بسبب إعدادات التخزين. الرجاء إدخال رابط السيرة الذاتية يدوياً في الحقل أو إعادة المحاولة لاحقاً.'
                : '${s.editProfileUpload} (${e.code})',
        btnOkText: s.commonOk,
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      if (!mounted) return;
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: s.dialogErrorTitle,
        desc: e.toString(),
        btnOkText: s.commonOk,
        btnOkOnPress: () {},
      ).show();
    } finally {
      if (mounted) setState(() => isUploadingCv = false);
    }
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).profileNoData)));
      return;
    }
    setState(() => isSaving = true);
    final s = S.of(context);
    try {
      await FirebaseFirestore.instance
          .collection('Profile')
          .doc(user.uid)
          .update({
            'full_name': nameController.text.trim(),
            'first_name': nameController.text.trim(),
            'last_name': '',
            'phone': phoneController.text.trim(),
            'email': emailController.text.trim(),
            'cv_url': cvController.text.trim(),
          });
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(s.editProfileSuccessTitle),
              content: Text(s.editProfileSuccessMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(s.commonOk),
                ),
              ],
            ),
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  InputDecoration fieldDecoration(
    BuildContext context,
    String label, {
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Theme.of(context).cardColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColors.purple, width: 1.4),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            title: '',
            titleWidget: const SizedBox.shrink(),
            backgroundColor: AppColors.purple,
            backgroundImage: AppAssets.headerLogo,
            textColor: Colors.white,
            showBackButton: true,
            showMenuButton: false,
            showSearchBar: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator:
                          (value) =>
                              value == null || value.trim().isEmpty
                                  ? s.fieldRequired
                                  : null,
                      decoration: fieldDecoration(
                        context,
                        s.editProfileFullName,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator:
                          (value) =>
                              value == null || value.trim().isEmpty
                                  ? s.fieldRequired
                                  : null,
                      decoration: fieldDecoration(context, s.editProfilePhone),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return s.fieldRequired;
                        }
                        if (!value.contains('@')) return s.loginEmailRequired;
                        return null;
                      },
                      decoration: fieldDecoration(context, s.editProfileEmail),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      s.editProfileCv,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: isUploadingCv ? null : pickAndUploadCv,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child:
                          isUploadingCv
                              ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload_file,
                                    color: AppColors.purple,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    s.editProfileUpload,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.purple,
                                    ),
                                  ),
                                ],
                              ),
                    ),
                    if (cvController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        cvController.text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child:
                            isSaving
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : Text(
                                  s.editProfileSave,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
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
