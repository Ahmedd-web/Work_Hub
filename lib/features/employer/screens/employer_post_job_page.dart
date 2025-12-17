import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/widgets/employer_post_job_fields.dart';
import 'package:work_hub/features/employer/widgets/employer_post_job_step_indicator.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerPostJobPage extends StatefulWidget {
  const EmployerPostJobPage({super.key});

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
  bool isSubmitting = false;

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
                  stepTitles[currentStep],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    child: const Text('السابق'),
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
                                ? 'حفظ ونشر الإعلان'
                                : 'التالي',
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
    switch (currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmployerFormFieldCard(
              label: 'المسمى الوظيفي بالعربية',
              child: EmployerPlainTextField(
                controller: arabicTitle,
                hint: 'ادخل المسمى الوظيفي بالعربية',
              ),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: 'المسمى الوظيفي بالإنجليزية',
              child: EmployerPlainTextField(
                controller: englishTitle,
                hint: 'ادخل المسمى الوظيفي بالإنجليزية',
                textDirection: TextDirection.ltr,
              ),
            ),
            const SizedBox(height: 16),
            EmployerDropdownCard(
              label: 'المستوى التعليمي',
              value: educationLevel,
              items: const ['دبلوم', 'بكالوريوس', 'ماجستير'],
              onChanged: (value) => setState(() => educationLevel = value),
            ),
            const SizedBox(height: 16),
            EmployerDropdownCard(
              label: 'القسم',
              value: department,
              items: const ['الموارد البشرية', 'التسويق', 'التصميم'],
              onChanged: (value) => setState(() => department = value),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: 'عدد سنوات الخبرة',
              child: EmployerPlainTextField(
                controller: experience,
                hint: 'حدد عدد سنوات الخبرة',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmployerDropdownCard(
              label: 'الجنسية',
              value: nationality,
              items: const ['ليبي', 'تونسي', 'سوداني'],
              onChanged: (value) => setState(() => nationality = value),
            ),
            const SizedBox(height: 16),
            EmployerDropdownCard(
              label: 'مكان العمل',
              value: country,
              items: const ['ليبيا', 'مصر', 'السودان'],
              onChanged: (value) => setState(() => country = value),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: 'المدينة',
              child: EmployerPlainTextField(
                controller: cityController,
                hint: 'حدد المدينة',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'الراتب والعملة',
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
                    title: const Text('محدد'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: salarySpecified,
                    onChanged:
                        (value) =>
                            setState(() => salarySpecified = value ?? false),
                    title: const Text('غير محدد'),
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
                      label: 'الراتب من',
                      child: EmployerPlainTextField(
                        controller: salaryFrom,
                        keyboardType: TextInputType.number,
                        hint: 'من',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: EmployerFormFieldCard(
                      label: 'الراتب إلى',
                      child: EmployerPlainTextField(
                        controller: salaryTo,
                        keyboardType: TextInputType.number,
                        hint: 'إلى',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              EmployerDropdownCard(
                label: 'العملة',
                value: currency,
                items: const ['LYD', 'USD', 'EUR'],
                onChanged: (value) => setState(() => currency = value),
              ),
            ],
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmployerDropdownCard(
              label: 'لغة الوصف',
              value: descriptionLanguage,
              items: const ['العربية', 'الإنجليزية'],
              onChanged: (value) => setState(() => descriptionLanguage = value),
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: 'الوصف الوظيفي',
              child: EmployerPlainTextField(
                controller: description,
                hint: 'اكتب نص الهدف الوظيفي',
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'المهارات الشخصية',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            EmployerDropdownCard(
              label: 'اختر مهارة من القائمة',
              value: selectedSkill,
              items: const ['القيادة', 'التواصل', 'التفاوض'],
              onChanged: (value) {
                if (value != null && !skills.contains(value)) {
                  setState(() => skills.add(value));
                }
                setState(() => selectedSkill = null);
              },
            ),
            const SizedBox(height: 16),
            EmployerFormFieldCard(
              label: 'أضف مهارة يدوياً',
              child: EmployerPlainTextField(
                controller: skillController,
                hint: 'اكتب اسم المهارة ثم اضغط إضافة',
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
                child: const Text('إضافة'),
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
              label: 'موعد التقديم',
              child: EmployerPlainTextField(
                controller: deadline,
                hint: 'حدد تاريخ نهاية التقديم',
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
              'صورة الإعلان',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  color: AppColors.purple,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'طريقة التقديم للوظيفة',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                CheckboxListTile(
                  value: applyViaEmail,
                  onChanged:
                      (value) => setState(() => applyViaEmail = value ?? false),
                  title: const Text('التقديم عبر البريد الإلكتروني'),
                ),
                CheckboxListTile(
                  value: applyViaPhone,
                  onChanged:
                      (value) => setState(() => applyViaPhone = value ?? false),
                  title: const Text('التقديم عبر الهاتف'),
                ),
                CheckboxListTile(
                  value: applyViaCv,
                  onChanged:
                      (value) => setState(() => applyViaCv = value ?? true),
                  title: const Text('التقديم مباشرة عن طريق السيرة الذاتية'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'هل تود تمييز الإعلان؟',
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
                    title: const Text('نعم'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: highlight,
                    onChanged:
                        (value) => setState(() => highlight = value ?? false),
                    title: const Text('لا'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'هل ترغب في إظهار معلومات الشركة؟',
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
                    title: const Text('نعم'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: showCompany,
                    onChanged:
                        (value) => setState(() => showCompany = value ?? true),
                    title: const Text('لا'),
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  List<String> get stepTitles => const [
    'إنشاء وظيفة جديدة',
    'معلومات الوظيفة',
    'وصف الوظيفة',
    'معلومات التقديم',
  ];

  bool validateStep(int step) {
    String? error;
    switch (step) {
      case 0:
        if (arabicTitle.text.trim().isEmpty) {
          error = 'يرجى إدخال المسمى الوظيفي بالعربية';
        } else if (educationLevel == null) {
          error = 'اختر المستوى التعليمي';
        } else if (department == null) {
          error = 'اختر القسم';
        } else if (experience.text.trim().isEmpty) {
          error = 'حدد عدد سنوات الخبرة';
        }
        break;
      case 1:
        if (nationality == null) {
          error = 'حدد الجنسية المطلوبة';
        } else if (country == null) {
          error = 'حدد مكان العمل';
        } else if (cityController.text.trim().isEmpty) {
          error = 'أدخل المدينة';
        } else if (salarySpecified) {
          if (salaryFrom.text.trim().isEmpty || salaryTo.text.trim().isEmpty) {
            error = 'أدخل نطاق الراتب';
          } else if (currency == null) {
            error = 'حدد العملة';
          }
        }
        break;
      case 2:
        if (descriptionLanguage == null) {
          error = 'اختر لغة الوصف';
        } else if (description.text.trim().isEmpty) {
          error = 'اكتب الوصف الوظيفي';
        }
        break;
      case 3:
        if (deadline.text.trim().isEmpty) {
          error = 'حدد تاريخ نهاية التقديم';
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
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'تنبيه',
      desc: message,
      btnOkText: 'حسناً',
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> submitJob() async {
    if (!validateStep(currentStep)) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول قبل إضافة إعلان')),
      );
      return;
    }
    setState(() => isSubmitting = true);
    try {
      await FirebaseFirestore.instance.collection('job_posts').add({
        'owner_uid': user.uid,
        'arabic_title': arabicTitle.text.trim(),
        'english_title': englishTitle.text.trim(),
        'education_level': educationLevel,
        'department': department,
        'experience_years': experience.text.trim(),
        'nationality': nationality,
        'country': country,
        'city': cityController.text.trim(),
        'salary_specified': salarySpecified,
        'salary_from': salarySpecified ? salaryFrom.text.trim() : null,
        'salary_to': salarySpecified ? salaryTo.text.trim() : null,
        'currency': salarySpecified ? currency : null,
        'description_language': descriptionLanguage,
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
        'status': 'active',
        'created_at': FieldValue.serverTimestamp(),
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حفظ الإعلان بنجاح')));
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تعذر حفظ الإعلان: $e')));
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }
}
