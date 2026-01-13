import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                    TextFormField(
                      controller: cvController,
                      keyboardType: TextInputType.url,
                      decoration: fieldDecoration(
                        context,
                        s.editProfileCv,
                      ).copyWith(hintText: s.applyCvButton),
                    ),
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
