import 'dart:io' as io;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/widgets/employer_post_job_fields.dart';
import 'package:work_hub/features/employer/widgets/employer_post_job_step_indicator.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/generated/l10n.dart';

class EmployerPostJobPage extends StatefulWidget {
  const EmployerPostJobPage({super.key, this.initialData, this.jobId});

  final Map<String, dynamic>? initialData;
  final String? jobId;

  @override
  State<EmployerPostJobPage> createState() => EmployerPostJobPageState();
}

class EmployerPostJobPageState extends State<EmployerPostJobPage> {
  final arabicTitle = TextEditingController();
  final englishTitle = TextEditingController();
  final experience = TextEditingController();
  final description = TextEditingController();
  final salaryFrom = TextEditingController();
  final salaryTo = TextEditingController();
  final deadline = TextEditingController();
  final skills = <String>[];
  final skillController = TextEditingController();
  final cityController = TextEditingController();

  int currentStep = 0;
  String? educationLevel;
  String? department;
  String? nationality;
  String? country;
  bool salarySpecified = true;
  String? currency;
  String? descriptionLanguage;
  String? selectedSkill;
  bool applyViaEmail = false;
  bool applyViaPhone = false;
  bool applyViaCv = true;
  bool highlight = false;
  bool showCompany = true;
  String? coverImageUrl;
  bool isUploadingImage = false;
  bool isSubmitting = false;
  bool get isEdit => widget.jobId != null && widget.initialData != null;

  @override
  void initState() {
    super.initState();
    prefillIfNeeded();
  }

  @override
  void dispose() {
    arabicTitle.dispose();
    englishTitle.dispose();
    experience.dispose();
    description.dispose();
    salaryFrom.dispose();
    salaryTo.dispose();
    deadline.dispose();
    skillController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final headerTitle =
        isEdit ? s.employerPostJobEditTitle : stepTitles[currentStep];

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
            showMenuButton: false,
            showNotificationButton: false,
            showSearchBar: false,
            height: 140,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              children: [
                Text(
                  headerTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.purple,
                  ),
                ),
                const SizedBox(height: 16),
                EmployerPostJobStepIndicator(
                  steps: stepTitles.length,
                  currentStep: currentStep,
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha:
                              theme.brightness == Brightness.dark ? 0.18 : 0.05,
                        ),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: buildStepContent(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Row(
            children: [
              if (currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        isSubmitting
                            ? null
                            : () => setState(() => currentStep--),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.purple),
                      foregroundColor: AppColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(s.commonBack),
                  ),
                ),
              if (currentStep > 0) const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      isSubmitting
                          ? null
                          : () async {
                            if (currentStep < stepTitles.length - 1) {
                              if (validateStep(currentStep)) {
                                setState(() => currentStep++);
                              }
                            } else {
                              await submitJob();
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        currentStep == stepTitles.length - 1
                            ? AppColors.bannerGreen
                            : AppColors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child:
                      isSubmitting
                          ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            currentStep == stepTitles.length - 1
                                ? s.employerPostJobSubmit
                                : s.commonNext,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStepContent() {
    final s = S.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    descriptionLanguage ??= isArabic ? 'العربية' : 'English';
    final educationOptions =
        isArabic
            ? ['دبلوم', 'بكالوريوس', 'ماجستير']
            : ['Diploma', 'Bachelor', 'Master'];
    final departmentOptions =
        isArabic
            ? ['الموارد البشرية', 'التسويق', 'التصميم']
            : ['HR', 'Marketing', 'Design'];
    final cityOptions =
        isArabic
            ? ['طرابلس', 'مصراتة', 'بنغازي']
            : ['Tripoli', 'Misrata', 'Benghazi'];
    final skillOptions =
        isArabic
            ? ['القيادة', 'التواصل', 'التفاوض']
            : ['Leadership', 'Communication', 'Negotiation'];
    final currencyOptions = isArabic ? ['دينار', 'دولار'] : ['Dinar', 'Dollar'];
    switch (currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmployerFormFieldCard(
              label: s.postJobTitleArLabel,
              child: EmployerPlainTextField(
                controller: arabicTitle,
                hint: s.postJobTitleArHint,
              ),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: s.postJobTitleEnLabel,
              child: EmployerPlainTextField(
                controller: englishTitle,
                hint: s.postJobTitleEnHint,
                textDirection: TextDirection.ltr,
              ),
            ),
            const SizedBox(height: 16),
            EmployerDropdownCard(
              label: s.postJobEducationLabel,
              value: educationLevel,
              items: educationOptions,
              hint: s.postJobEducationLabel,
              onChanged: (value) => setState(() => educationLevel = value),
            ),
            const SizedBox(height: 16),
            EmployerDropdownCard(
              label: s.postJobDepartmentLabel,
              value: department,
              items: departmentOptions,
              hint: s.postJobDepartmentLabel,
              onChanged: (value) => setState(() => department = value),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: s.postJobExperienceLabel,
              child: EmployerPlainTextField(
                controller: experience,
                hint: s.postJobExperienceHint,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmployerDropdownCard(
              label: s.postJobCityLabel,
              value: country,
              items: cityOptions,
              hint: s.postJobCityLabel,
              onChanged: (value) => setState(() => country = value),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: s.postJobCompanyLocationLabel,
              child: EmployerPlainTextField(
                controller: cityController,
                hint: s.postJobCompanyLocationHint,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.postJobSalaryTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    value: true,
                    groupValue: salarySpecified,
                    onChanged:
                        (value) =>
                            setState(() => salarySpecified = value ?? true),
                    title: Text(s.postJobSalaryYes),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: salarySpecified,
                    onChanged:
                        (value) =>
                            setState(() => salarySpecified = value ?? false),
                    title: Text(s.postJobSalaryNo),
                  ),
                ),
              ],
            ),
            if (salarySpecified) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: EmployerFormFieldCard(
                      label: s.postJobSalaryFrom,
                      child: EmployerPlainTextField(
                        controller: salaryFrom,
                        keyboardType: TextInputType.number,
                        hint: s.postJobSalaryHintFrom,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: EmployerFormFieldCard(
                      label: s.postJobSalaryTo,
                      child: EmployerPlainTextField(
                        controller: salaryTo,
                        keyboardType: TextInputType.number,
                        hint: s.postJobSalaryHintTo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              EmployerDropdownCard(
                label: s.postJobCurrency,
                value: currency,
                items: currencyOptions,
                hint: s.postJobCurrency,
                onChanged: (value) => setState(() => currency = value),
              ),
            ],
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: s.postJobDescriptionLabel,
              child: EmployerPlainTextField(
                controller: description,
                hint: s.postJobDescriptionHint,
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.postJobSkillsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            EmployerDropdownCard(
              label: s.postJobSkillSelect,
              value: selectedSkill,
              items: skillOptions,
              hint: s.postJobSkillSelect,
              onChanged: (value) {
                if (value != null && !skills.contains(value)) {
                  setState(() => skills.add(value));
                }
                setState(() => selectedSkill = null);
              },
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: s.postJobSkillCustomLabel,
              child: EmployerPlainTextField(
                controller: skillController,
                hint: s.postJobSkillCustomHint,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (skillController.text.trim().isNotEmpty) {
                    setState(() => skills.add(skillController.text.trim()));
                    skillController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bannerGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(s.postJobAdd),
              ),
            ),
            if (skills.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children:
                    skills
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
                            onDeleted:
                                () => setState(() => skills.remove(skill)),
                          ),
                        )
                        .toList(),
              ),
            ],
          ],
        );
      case 3:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmployerFormFieldCard(
              label: s.postJobDeadlineLabel,
              child: EmployerPlainTextField(
                controller: deadline,
                hint: s.postJobDeadlineHint,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    deadline.text = '${date.year}-${date.month}-${date.day}';
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.postJobImageLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: isUploadingImage ? null : pickCoverImage,
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    isUploadingImage
                        ? const Center(
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                        : coverImageUrl != null
                        ? Image.network(
                          coverImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, _, __) => const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: AppColors.purple,
                                  size: 42,
                                ),
                              ),
                        )
                        : const Center(
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: AppColors.purple,
                            size: 48,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.postJobApplyMethods,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                CheckboxListTile(
                  value: applyViaEmail,
                  onChanged:
                      (value) => setState(() => applyViaEmail = value ?? false),
                  title: Text(s.postJobApplyEmail),
                ),
                CheckboxListTile(
                  value: applyViaPhone,
                  onChanged:
                      (value) => setState(() => applyViaPhone = value ?? false),
                  title: Text(s.postJobApplyPhone),
                ),
                CheckboxListTile(
                  value: applyViaCv,
                  onChanged:
                      (value) => setState(() => applyViaCv = value ?? true),
                  title: Text(s.postJobApplyCv),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              s.postJobHighlight,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    value: true,
                    groupValue: highlight,
                    onChanged:
                        (value) => setState(() => highlight = value ?? false),
                    title: Text(s.postJobSalaryYes),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: highlight,
                    onChanged:
                        (value) => setState(() => highlight = value ?? false),
                    title: Text(s.postJobSalaryNo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              s.postJobShowCompany,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    value: true,
                    groupValue: showCompany,
                    onChanged:
                        (value) => setState(() => showCompany = value ?? true),
                    title: Text(s.postJobSalaryYes),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: showCompany,
                    onChanged:
                        (value) => setState(() => showCompany = value ?? true),
                    title: Text(s.postJobSalaryNo),
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  List<String> get stepTitles => [
    S.of(context).employerPostJobStepInfo,
    S.of(context).employerPostJobStepLocation,
    S.of(context).employerPostJobStepDescription,
    S.of(context).employerPostJobStepApply,
  ];

  bool validateStep(int step) {
    final s = S.of(context);
    String? error;
    switch (step) {
      case 0:
        if (arabicTitle.text.trim().isEmpty) {
          error = s.postJobErrorTitleRequired;
        } else if (educationLevel == null) {
          error = s.postJobErrorEducation;
        } else if (department == null) {
          error = s.postJobErrorDepartment;
        } else if (experience.text.trim().isEmpty) {
          error = s.postJobErrorExperience;
        }
        break;
      case 1:
        if (country == null) {
          error = s.postJobErrorCity;
        } else if (cityController.text.trim().isEmpty) {
          error = s.postJobErrorCompanyLocation;
        } else if (salarySpecified) {
          if (salaryFrom.text.trim().isEmpty || salaryTo.text.trim().isEmpty) {
            error = s.postJobErrorSalaryRange;
          } else if (currency == null) {
            error = s.postJobErrorCurrency;
          }
        }
        break;
      case 2:
        if (description.text.trim().isEmpty) {
          error = s.postJobErrorDescription;
        }
        break;
      case 3:
        if (deadline.text.trim().isEmpty) {
          error = s.postJobErrorDeadline;
        }
        break;
    }
    if (error != null) {
      showErrorDialog(error);
      return false;
    }
    return true;
  }

  void showErrorDialog(String message) {
    if (!mounted) return;
    final s = S.of(context);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: s.dialogWarningTitle,
      desc: message,
      btnOkText: s.dialogOk,
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> submitJob() async {
    final s = S.of(context);
    if (!validateStep(currentStep)) return;
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
    setState(() => isSubmitting = true);
    try {
      final status = widget.initialData?['status'] as String? ?? 'active';
      final data = {
        'owner_uid': user.uid,
        'arabic_title': arabicTitle.text.trim(),
        'english_title': englishTitle.text.trim(),
        'education_level': educationLevel,
        'department': department,
        'experience_years': experience.text.trim(),
        'country': country,
        'city': cityController.text.trim(),
        'salary_specified': salarySpecified,
        'salary_from': salarySpecified ? salaryFrom.text.trim() : null,
        'salary_to': salarySpecified ? salaryTo.text.trim() : null,
        'currency': salarySpecified ? currency : null,
        'description_language':
            descriptionLanguage ??
            (Localizations.localeOf(context).languageCode == 'ar'
                ? 'العربية'
                : 'English'),
        'description': description.text.trim(),
        'skills': skills,
        'application_channels': {
          'email': applyViaEmail,
          'phone': applyViaPhone,
          'cv': applyViaCv,
        },
        'deadline': deadline.text.trim(),
        'highlight': highlight,
        'show_company': showCompany,
        'cover_image_url': coverImageUrl,
        'status': status,
        'updated_at': FieldValue.serverTimestamp(),
      };

      final collection = FirebaseFirestore.instance.collection('job_posts');
      if (isEdit) {
        await collection.doc(widget.jobId).update(data);
      } else {
        await collection.add({
          ...data,
          'created_at': FieldValue.serverTimestamp(),
        });
      }
      if (!mounted) return;
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: s.dialogSuccessTitle,
        desc: isEdit ? s.jobPostUpdateSuccess : s.jobPostPublishSuccess,
        btnOkText: s.dialogOk,
        btnOkOnPress: () {},
      ).show();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: s.dialogErrorTitle,
        desc: s.jobPostSaveError('$e'),
        btnOkText: s.dialogClose,
        btnOkOnPress: () {},
      ).show();
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  void prefillIfNeeded() {
    final data = widget.initialData;
    if (data == null) return;
    arabicTitle.text = (data['arabic_title'] as String?) ?? '';
    englishTitle.text = (data['english_title'] as String?) ?? '';
    educationLevel = data['education_level'] as String?;
    department = data['department'] as String?;
    experience.text = (data['experience_years'] as String?) ?? '';
    nationality = data['nationality'] as String?;
    country = data['country'] as String?;
    cityController.text = (data['city'] as String?) ?? '';
    salarySpecified = (data['salary_specified'] as bool?) ?? true;
    salaryFrom.text = (data['salary_from'] as String?) ?? '';
    salaryTo.text = (data['salary_to'] as String?) ?? '';
    currency = data['currency'] as String?;
    descriptionLanguage = data['description_language'] as String?;
    description.text = (data['description'] as String?) ?? '';
    skills
      ..clear()
      ..addAll(List<String>.from(data['skills'] as List? ?? const []));
    final channels =
        data['application_channels'] as Map<String, dynamic>? ?? {};
    applyViaEmail = channels['email'] as bool? ?? false;
    applyViaPhone = channels['phone'] as bool? ?? false;
    applyViaCv = channels['cv'] as bool? ?? true;
    deadline.text = (data['deadline'] as String?) ?? '';
    highlight = (data['highlight'] as bool?) ?? false;
    showCompany = (data['show_company'] as bool?) ?? true;
    setState(() {});
  }

  Future<void> pickCoverImage() async {
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
    try {
      setState(() => isUploadingImage = true);
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final picked = result.files.single;
      final cleaned = (picked.name.isEmpty ? 'cover' : picked.name).replaceAll(
        RegExp(r'[^A-Za-z0-9._-]'),
        '_',
      );
      final filename =
          cleaned.contains('.')
              ? cleaned
              : '${DateTime.now().millisecondsSinceEpoch}_$cleaned.png';
      final path = 'job_images/${user.uid}/$filename';
      final ref = FirebaseStorage.instance.ref(path);
      final ext = picked.extension?.toLowerCase();
      final contentType = switch (ext) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        'gif' => 'image/gif',
        'webp' => 'image/webp',
        _ => 'application/octet-stream',
      };
      final metadata = SettableMetadata(contentType: contentType);
      if (picked.bytes != null) {
        await ref.putData(picked.bytes!, metadata);
      } else if (picked.path != null) {
        await ref.putFile(io.File(picked.path!), metadata);
      } else {
        throw Exception(s.dialogErrorTitle);
      }
      final url = await ref.getDownloadURL();
      if (!mounted) return;
      setState(() => coverImageUrl = url);
    } catch (e) {
      if (!mounted) return;
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: s.dialogErrorTitle,
        desc: e.toString(),
        btnOkText: s.dialogClose,
        btnOkOnPress: () {},
      ).show();
    } finally {
      if (mounted) setState(() => isUploadingImage = false);
    }
  }
}
