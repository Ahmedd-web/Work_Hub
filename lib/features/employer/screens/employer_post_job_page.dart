import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerPostJobPage extends StatefulWidget {
  const EmployerPostJobPage({super.key});

  @override
  State<EmployerPostJobPage> createState() => _EmployerPostJobPageState();
}

class _EmployerPostJobPageState extends State<EmployerPostJobPage> {
  final _arabicTitle = TextEditingController();
  final _englishTitle = TextEditingController();
  final _experience = TextEditingController();
  final _description = TextEditingController();
  final _salaryFrom = TextEditingController();
  final _salaryTo = TextEditingController();
  final _deadline = TextEditingController();
  final _skills = <String>[];
  final _skillController = TextEditingController();
  final _cityController = TextEditingController();

  int _currentStep = 0;
  String? _educationLevel;
  String? _department;
  String? _nationality;
  String? _country;
  bool _salarySpecified = true;
  String? _currency;
  String? _descriptionLanguage;
  String? _selectedSkill;
  bool _applyViaEmail = false;
  bool _applyViaPhone = false;
  bool _applyViaCv = true;
  bool _highlight = false;
  bool _showCompany = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _arabicTitle.dispose();
    _englishTitle.dispose();
    _experience.dispose();
    _description.dispose();
    _salaryFrom.dispose();
    _salaryTo.dispose();
    _deadline.dispose();
    _skillController.dispose();
    _cityController.dispose();
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
                  _stepTitles[_currentStep],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.purple,
                  ),
                ),
                const SizedBox(height: 16),
                _StepIndicator(
                  steps: _stepTitles.length,
                  currentStep: _currentStep,
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
                  child: _buildStepContent(),
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
              if (_currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        _isSubmitting
                            ? null
                            : () => setState(() => _currentStep--),
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
              if (_currentStep > 0) const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      _isSubmitting
                          ? null
                          : () async {
                            if (_currentStep < _stepTitles.length - 1) {
                              if (_validateStep(_currentStep)) {
                                setState(() => _currentStep++);
                              }
                            } else {
                              await _submitJob();
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _currentStep == _stepTitles.length - 1
                            ? AppColors.bannerGreen
                            : AppColors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child:
                      _isSubmitting
                          ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            _currentStep == _stepTitles.length - 1
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FormFieldCard(
              label: 'المسمى الوظيفي بالعربية',
              child: _PlainTextField(
                controller: _arabicTitle,
                hint: 'ادخل المسمى الوظيفي بالعربية',
              ),
            ),
            const SizedBox(height: 16),
            _FormFieldCard(
              label: 'المسمى الوظيفي بالإنجليزية',
              child: _PlainTextField(
                controller: _englishTitle,
                hint: 'ادخل المسمى الوظيفي بالإنجليزية',
                textDirection: TextDirection.ltr,
              ),
            ),
            const SizedBox(height: 16),
            _DropdownCard(
              label: 'المستوى التعليمي',
              value: _educationLevel,
              items: const ['دبلوم', 'بكالوريوس', 'ماجستير'],
              onChanged: (value) => setState(() => _educationLevel = value),
            ),
            const SizedBox(height: 16),
            _DropdownCard(
              label: 'القسم',
              value: _department,
              items: const ['الموارد البشرية', 'التسويق', 'التصميم'],
              onChanged: (value) => setState(() => _department = value),
            ),
            const SizedBox(height: 16),
            _FormFieldCard(
              label: 'عدد سنوات الخبرة',
              child: _PlainTextField(
                controller: _experience,
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
            _DropdownCard(
              label: 'الجنسية',
              value: _nationality,
              items: const ['ليبي', 'تونسي', 'سوداني'],
              onChanged: (value) => setState(() => _nationality = value),
            ),
            const SizedBox(height: 16),
            _DropdownCard(
              label: 'مكان العمل',
              value: _country,
              items: const ['ليبيا', 'مصر', 'السودان'],
              onChanged: (value) => setState(() => _country = value),
            ),
            const SizedBox(height: 16),
            _FormFieldCard(
              label: 'المدينة',
              child: _PlainTextField(
                controller: _cityController,
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
                    groupValue: _salarySpecified,
                    onChanged:
                        (value) =>
                            setState(() => _salarySpecified = value ?? true),
                    title: const Text('محدد'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: _salarySpecified,
                    onChanged:
                        (value) =>
                            setState(() => _salarySpecified = value ?? false),
                    title: const Text('غير محدد'),
                  ),
                ),
              ],
            ),
            if (_salarySpecified) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _FormFieldCard(
                      label: 'الراتب من',
                      child: _PlainTextField(
                        controller: _salaryFrom,
                        keyboardType: TextInputType.number,
                        hint: 'من',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FormFieldCard(
                      label: 'الراتب إلى',
                      child: _PlainTextField(
                        controller: _salaryTo,
                        keyboardType: TextInputType.number,
                        hint: 'إلى',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _DropdownCard(
                label: 'العملة',
                value: _currency,
                items: const ['LYD', 'USD', 'EUR'],
                onChanged: (value) => setState(() => _currency = value),
              ),
            ],
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DropdownCard(
              label: 'لغة الوصف',
              value: _descriptionLanguage,
              items: const ['العربية', 'الإنجليزية'],
              onChanged:
                  (value) => setState(() => _descriptionLanguage = value),
            ),
            const SizedBox(height: 16),
            _FormFieldCard(
              label: 'الوصف الوظيفي',
              child: _PlainTextField(
                controller: _description,
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
            _DropdownCard(
              label: 'اختر مهارة من القائمة',
              value: _selectedSkill,
              items: const ['القيادة', 'التواصل', 'التفاوض'],
              onChanged: (value) {
                if (value != null && !_skills.contains(value)) {
                  setState(() => _skills.add(value));
                }
                setState(() => _selectedSkill = null);
              },
            ),
            const SizedBox(height: 16),
            _FormFieldCard(
              label: 'أضف مهارة يدوياً',
              child: _PlainTextField(
                controller: _skillController,
                hint: 'اكتب اسم المهارة ثم اضغط إضافة',
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_skillController.text.trim().isNotEmpty) {
                    setState(() => _skills.add(_skillController.text.trim()));
                    _skillController.clear();
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
            if (_skills.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children:
                    _skills
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
                            onDeleted:
                                () => setState(() => _skills.remove(skill)),
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
            _FormFieldCard(
              label: 'موعد التقديم',
              child: _PlainTextField(
                controller: _deadline,
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
                    _deadline.text = '${date.year}-${date.month}-${date.day}';
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
                  value: _applyViaEmail,
                  onChanged:
                      (value) =>
                          setState(() => _applyViaEmail = value ?? false),
                  title: const Text('التقديم عبر البريد الإلكتروني'),
                ),
                CheckboxListTile(
                  value: _applyViaPhone,
                  onChanged:
                      (value) =>
                          setState(() => _applyViaPhone = value ?? false),
                  title: const Text('التقديم عبر الهاتف'),
                ),
                CheckboxListTile(
                  value: _applyViaCv,
                  onChanged:
                      (value) => setState(() => _applyViaCv = value ?? true),
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
                    groupValue: _highlight,
                    onChanged:
                        (value) => setState(() => _highlight = value ?? false),
                    title: const Text('نعم'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: _highlight,
                    onChanged:
                        (value) => setState(() => _highlight = value ?? false),
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
                    groupValue: _showCompany,
                    onChanged:
                        (value) => setState(() => _showCompany = value ?? true),
                    title: const Text('نعم'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    groupValue: _showCompany,
                    onChanged:
                        (value) => setState(() => _showCompany = value ?? true),
                    title: const Text('لا'),
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  List<String> get _stepTitles => const [
    'إنشاء وظيفة جديدة',
    'معلومات الوظيفة',
    'وصف الوظيفة',
    'معلومات التقديم',
  ];

  bool _validateStep(int step) {
    String? error;
    switch (step) {
      case 0:
        if (_arabicTitle.text.trim().isEmpty) {
          error = 'يرجى إدخال المسمى الوظيفي بالعربية';
        } else if (_educationLevel == null) {
          error = 'اختر المستوى التعليمي';
        } else if (_department == null) {
          error = 'اختر القسم';
        } else if (_experience.text.trim().isEmpty) {
          error = 'حدد عدد سنوات الخبرة';
        }
        break;
      case 1:
        if (_nationality == null) {
          error = 'حدد الجنسية المطلوبة';
        } else if (_country == null) {
          error = 'حدد مكان العمل';
        } else if (_cityController.text.trim().isEmpty) {
          error = 'أدخل المدينة';
        } else if (_salarySpecified) {
          if (_salaryFrom.text.trim().isEmpty ||
              _salaryTo.text.trim().isEmpty) {
            error = 'أدخل نطاق الراتب';
          } else if (_currency == null) {
            error = 'حدد العملة';
          }
        }
        break;
      case 2:
        if (_descriptionLanguage == null) {
          error = 'اختر لغة الوصف';
        } else if (_description.text.trim().isEmpty) {
          error = 'اكتب الوصف الوظيفي';
        }
        break;
      case 3:
        if (_deadline.text.trim().isEmpty) {
          error = 'حدد تاريخ نهاية التقديم';
        }
        break;
    }
    if (error != null) {
      _showErrorDialog(error);
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
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

  Future<void> _submitJob() async {
    if (!_validateStep(_currentStep)) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول قبل إضافة إعلان')),
      );
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await FirebaseFirestore.instance.collection('job_posts').add({
        'owner_uid': user.uid,
        'arabic_title': _arabicTitle.text.trim(),
        'english_title': _englishTitle.text.trim(),
        'education_level': _educationLevel,
        'department': _department,
        'experience_years': _experience.text.trim(),
        'nationality': _nationality,
        'country': _country,
        'city': _cityController.text.trim(),
        'salary_specified': _salarySpecified,
        'salary_from': _salarySpecified ? _salaryFrom.text.trim() : null,
        'salary_to': _salarySpecified ? _salaryTo.text.trim() : null,
        'currency': _salarySpecified ? _currency : null,
        'description_language': _descriptionLanguage,
        'description': _description.text.trim(),
        'skills': _skills,
        'application_channels': {
          'email': _applyViaEmail,
          'phone': _applyViaPhone,
          'cv': _applyViaCv,
        },
        'deadline': _deadline.text.trim(),
        'highlight': _highlight,
        'show_company': _showCompany,
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
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.steps, required this.currentStep});

  final int steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps, (index) {
        final isActive = index == currentStep;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? AppColors.purple : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }
}

class _FormFieldCard extends StatelessWidget {
  const _FormFieldCard({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.6,
            ),
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.2 : 0.05,
                ),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _PlainTextField extends StatelessWidget {
  const _PlainTextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.textDirection = TextDirection.rtl,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      textDirection: textDirection,
      textAlign:
          textDirection == TextDirection.rtl ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: textDirection,
        border: InputBorder.none,
      ),
    );
  }
}

class _DropdownCard extends StatelessWidget {
  const _DropdownCard({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.25 : 0.6,
            ),
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.2 : 0.05,
                ),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: value,
              onChanged: onChanged,
              decoration: const InputDecoration(border: InputBorder.none),
              hint: Text('حدد $label'),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.purple,
              ),
              items:
                  items
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
