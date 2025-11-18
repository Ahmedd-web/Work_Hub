import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _cvController;
  bool _isSaving = false;
  bool _isUploadingCv = false;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    _nameController = TextEditingController(text: data.displayName);
    _phoneController = TextEditingController(text: data.phoneDisplay == '-' ? '' : data.phoneDisplay);
    _emailController = TextEditingController(text: data.emailDisplay == '-' ? '' : data.emailDisplay);
    _cvController = TextEditingController(text: data.resumeDisplay);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cvController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadCv() async {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.profileNoData)),
      );
      return;
    }
    try {
      setState(() => _isUploadingCv = true);
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result == null || result.files.isEmpty) {
        return;
      }
      final picked = result.files.single;
      Reference ref = FirebaseStorage.instance
          .ref('cvs/${user.uid}/${picked.name}');
      final ext = picked.extension?.toLowerCase();
      final contentType = switch (ext) {
        'pdf' => 'application/pdf',
        'doc' => 'application/msword',
        'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        _ => 'application/octet-stream',
      };
      if (kIsWeb) {
        final bytes = picked.bytes;
        if (bytes == null) return;
        await ref.putData(
          bytes,
          SettableMetadata(contentType: contentType),
        );
      } else {
        final path = picked.path;
        if (path == null) return;
        await ref.putFile(
          io.File(path),
          SettableMetadata(contentType: contentType),
        );
      }
      final url = await ref.getDownloadURL();
      setState(() => _cvController.text = url);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.editProfileUpload)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploadingCv = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).profileNoData)),
      );
      return;
    }
    setState(() => _isSaving = true);
    final s = S.of(context);
    try {
      await FirebaseFirestore.instance.collection('Profile').doc(user.uid).update({
        'full_name': _nameController.text.trim(),
        'first_name': _nameController.text.trim(),
        'last_name': '',
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'cv_url': _cvController.text.trim(),
      });
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  InputDecoration _fieldDecoration(BuildContext context, String label, {Widget? suffix}) {
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) => value == null || value.trim().isEmpty ? s.fieldRequired : null,
                      decoration: _fieldDecoration(context, s.editProfileFullName),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.trim().isEmpty ? s.fieldRequired : null,
                      decoration: _fieldDecoration(context, s.editProfilePhone),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return s.fieldRequired;
                        if (!value.contains('@')) return s.loginEmailRequired;
                        return null;
                      },
                      decoration: _fieldDecoration(context, s.editProfileEmail),
                    ),
                    const SizedBox(height: 20),
                    Text(s.editProfileCv, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _isUploadingCv ? null : _pickAndUploadCv,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: _isUploadingCv
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.upload_file, color: AppColors.purple),
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
                    if (_cvController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        _cvController.text,
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
                        onPressed: _isSaving ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                s.editProfileSave,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
