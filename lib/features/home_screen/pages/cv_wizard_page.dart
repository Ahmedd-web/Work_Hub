import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/cv_data.dart';
import 'package:work_hub/features/home_screen/services/cv_repository.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class CvWizardPage extends StatelessWidget {
  const CvWizardPage({super.key, this.initialData});

  final CvData? initialData;

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
            showBackButton: true,
            showMenuButton: false,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: CvWizardForm(
                initialData: initialData,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CvWizardForm extends StatefulWidget {
  const CvWizardForm({
    super.key,
    this.initialData,
    this.padding,
    this.compact = false,
    this.enableScrolling = true,
    this.onCompleted,
  });

  final CvData? initialData;
  final EdgeInsetsGeometry? padding;
  final bool compact;
  final bool enableScrolling;
  final ValueChanged<CvData>? onCompleted;

  @override
  State<CvWizardForm> createState() => _CvWizardFormState();
}

class _CvWizardFormState extends State<CvWizardForm> {
  static const int _totalSteps = 7;
  int _currentStep = 0;
  bool _isSaving = false;

  late final TextEditingController _jobTitleArController;
  late final TextEditingController _jobTitleEnController;
  late final TextEditingController _educationLevelController;
  late final TextEditingController _yearsExperienceController;
  late final TextEditingController _phone1Controller;
  late final TextEditingController _phone2Controller;
  late final TextEditingController _phone3Controller;
  late final TextEditingController _emailController;
  late final TextEditingController _skillController;
  late final TextEditingController _summaryArController;
  late final TextEditingController _summaryEnController;
  late final TextEditingController _eduInstitutionController;
  late final TextEditingController _eduMajorArController;
  late final TextEditingController _eduMajorEnController;
  late final TextEditingController _eduStartController;
  late final TextEditingController _eduEndController;
  late final TextEditingController _expCompanyArController;
  late final TextEditingController _expCompanyEnController;
  late final TextEditingController _expRoleArController;
  late final TextEditingController _expRoleEnController;
  late final TextEditingController _expDescController;
  late final TextEditingController _expStartController;
  late final TextEditingController _expEndController;
  late final TextEditingController _courseOrgController;
  late final TextEditingController _courseTitleController;
  late final TextEditingController _courseDateController;

  final List<String> _skills = [];
  final List<CvEducationEntry> _education = [];
  final List<CvCourseEntry> _courses = [];
  final List<CvExperienceEntry> _experiences = [];

  @override
  void initState() {
    super.initState();
    _initControllers();
    _applyInitialData(widget.initialData, resetCollections: true);
  }

  void _initControllers() {
    _jobTitleArController = TextEditingController();
    _jobTitleEnController = TextEditingController();
    _educationLevelController = TextEditingController();
    _yearsExperienceController = TextEditingController();
    _phone1Controller = TextEditingController();
    _phone2Controller = TextEditingController();
    _phone3Controller = TextEditingController();
    _emailController = TextEditingController();
    _summaryArController = TextEditingController();
    _summaryEnController = TextEditingController();
    _skillController = TextEditingController();
    _eduInstitutionController = TextEditingController();
    _eduMajorArController = TextEditingController();
    _eduMajorEnController = TextEditingController();
    _eduStartController = TextEditingController();
    _eduEndController = TextEditingController();
    _expCompanyArController = TextEditingController();
    _expCompanyEnController = TextEditingController();
    _expRoleArController = TextEditingController();
    _expRoleEnController = TextEditingController();
    _expDescController = TextEditingController();
    _expStartController = TextEditingController();
    _expEndController = TextEditingController();
    _courseOrgController = TextEditingController();
    _courseTitleController = TextEditingController();
    _courseDateController = TextEditingController();
  }

  void _applyInitialData(CvData? data, {bool resetCollections = false}) {
    if (resetCollections) {
      _skills.clear();
      _education.clear();
      _courses.clear();
      _experiences.clear();
    }
    if (data == null) {
      _jobTitleArController.text = '';
      _jobTitleEnController.text = '';
      _educationLevelController.text = '';
      _yearsExperienceController.text = '';
      _phone1Controller.text = '';
      _phone2Controller.text = '';
      _phone3Controller.text = '';
      _emailController.text = '';
      _summaryArController.text = '';
      _summaryEnController.text = '';
      return;
    }
    _jobTitleArController.text = data.jobTitleAr;
    _jobTitleEnController.text = data.jobTitleEn;
    _educationLevelController.text = data.educationLevel;
    _yearsExperienceController.text = data.yearsExperience;
    _phone1Controller.text = data.phones.elementAtOrNull(0) ?? '';
    _phone2Controller.text = data.phones.elementAtOrNull(1) ?? '';
    _phone3Controller.text = data.phones.elementAtOrNull(2) ?? '';
    _emailController.text = data.email;
    _summaryArController.text = data.summaryAr;
    _summaryEnController.text = data.summaryEn;
    if (resetCollections) {
      _skills.addAll(data.skills);
      _education.addAll(data.education);
      _courses.addAll(data.courses);
      _experiences.addAll(data.experiences);
    }
  }

  @override
  void didUpdateWidget(covariant CvWizardForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newData = widget.initialData;
    if (newData == null) return;
    final previous = oldWidget.initialData;
    final shouldApply =
        previous == null || previous.updatedAt != newData.updatedAt;
    if (shouldApply) {
      _applyInitialData(newData, resetCollections: true);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<TextEditingController> get _controllers => [
        _jobTitleArController,
        _jobTitleEnController,
        _educationLevelController,
        _yearsExperienceController,
        _phone1Controller,
        _phone2Controller,
        _phone3Controller,
        _emailController,
        _summaryArController,
        _summaryEnController,
        _skillController,
        _eduInstitutionController,
        _eduMajorArController,
        _eduMajorEnController,
        _eduStartController,
        _eduEndController,
        _expCompanyArController,
        _expCompanyEnController,
        _expRoleArController,
        _expRoleEnController,
        _expDescController,
        _expStartController,
        _expEndController,
        _courseOrgController,
        _courseTitleController,
        _courseDateController,
      ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    Widget content =
        widget.compact ? _buildCompactContent(s) : _buildExpandedContent(s);
    if (widget.padding != null) {
      content = Padding(
        padding: widget.padding!,
        child: content,
      );
    }
    return content;
  }

  Widget _buildExpandedContent(S s) {
    return Column(
      children: [
        _CvStepIndicator(currentStep: _currentStep + 1, totalSteps: _totalSteps),
        const SizedBox(height: 16),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildStep(context, s),
          ),
        ),
        const SizedBox(height: 16),
        _buildNavigationButtons(s),
      ],
    );
  }

  Widget _buildCompactContent(S s) {
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CvStepIndicator(currentStep: _currentStep + 1, totalSteps: _totalSteps),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildStep(context, s),
        ),
        const SizedBox(height: 16),
        _buildNavigationButtons(s),
      ],
    );
    if (!widget.enableScrolling) {
      return column;
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: column,
    );
  }

  Future<void> _handleCompletion(CvData data, S s) async {
    if (!mounted) return;
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: s.cvCreateTitle,
      desc: s.cvButtonFinish,
      btnOkText: s.commonOk,
      btnOkOnPress: () {},
    ).show();
    if (!mounted) return;
    if (widget.onCompleted != null) {
      widget.onCompleted!(data);
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget _buildStep(BuildContext context, S s) {
    switch (_currentStep) {
      case 0:
        return _buildMainInfoStep(s);
      case 1:
        return _buildContactStep(s);
      case 2:
        return _buildSkillsStep(s);
      case 3:
        return _buildSummaryStep(s);
      case 4:
        return _buildEducationStep(s);
      case 5:
        return _buildCoursesStep(s);
      case 6:
      default:
        return _buildExperienceStep(s);
    }
  }

  Widget _buildMainInfoStep(S s) {
    return _CardWrapper(
      title: s.cvStepPersonalInfo,
      child: Column(
        children: [
          _CvTextField(controller: _jobTitleArController, label: s.cvFieldJobTitleAr),
          const SizedBox(height: 12),
          _CvTextField(controller: _jobTitleEnController, label: s.cvFieldJobTitleEn),
          const SizedBox(height: 12),
          _CvTextField(controller: _educationLevelController, label: s.cvFieldEducationLevel),
          const SizedBox(height: 12),
          _CvTextField(
            controller: _yearsExperienceController,
            label: s.cvFieldYearsExperience,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildContactStep(S s) {
    return _CardWrapper(
      title: s.cvStepContact,
      child: Column(
        children: [
          _CvTextField(controller: _phone1Controller, label: s.cvFieldPhone1, keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          _CvTextField(controller: _phone2Controller, label: s.cvFieldPhone2, keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          _CvTextField(controller: _phone3Controller, label: s.cvFieldPhone3, keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          _CvTextField(controller: _emailController, label: s.cvFieldEmail, keyboardType: TextInputType.emailAddress),
        ],
      ),
    );
  }

  Widget _buildSkillsStep(S s) {
    return _CardWrapper(
      title: s.cvStepSkills,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CvTextField(
            controller: _skillController,
            label: s.cvFieldSkillPlaceholder,
            suffix: IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.purple),
              onPressed: _addSkill,
            ),
          ),
          const SizedBox(height: 12),
          if (_skills.isEmpty)
            Text(s.cvNoData)
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() => _skills.remove(skill));
                      },
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryStep(S s) {
    return _CardWrapper(
      title: s.cvStepSummary,
      child: Column(
        children: [
          _CvTextField(
            controller: _summaryArController,
            label: s.cvFieldSummaryAr,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          _CvTextField(
            controller: _summaryEnController,
            label: s.cvFieldSummaryEn,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationStep(S s) {
    return _CardWrapper(
      title: s.cvStepEducation,
      child: Column(
        children: [
          _CvTextField(controller: _eduInstitutionController, label: s.cvEducationInstitution),
          const SizedBox(height: 12),
          _CvTextField(controller: _eduMajorArController, label: s.cvEducationMajorAr),
          const SizedBox(height: 12),
          _CvTextField(controller: _eduMajorEnController, label: s.cvEducationMajorEn),
          const SizedBox(height: 12),
          _CvTextField(
            controller: _eduStartController,
            label: s.cvEducationStartDate,
            readOnly: true,
            onTap: () => _pickDate(_eduStartController),
          ),
          const SizedBox(height: 12),
          _CvTextField(
            controller: _eduEndController,
            label: s.cvEducationEndDate,
            readOnly: true,
            onTap: () => _pickDate(_eduEndController),
          ),
          const SizedBox(height: 12),
          _PrimaryButton(
            label: s.cvButtonAdd,
            onPressed: _addEducation,
          ),
          const SizedBox(height: 16),
          _EntryList(
            entries: _education.map((e) => e.institution).toList(),
            onDelete: (index) => setState(() => _education.removeAt(index)),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesStep(S s) {
    return _CardWrapper(
      title: s.cvStepCourses,
      child: Column(
        children: [
          _CvTextField(controller: _courseOrgController, label: s.cvCourseOrganization),
          const SizedBox(height: 12),
          _CvTextField(controller: _courseTitleController, label: s.cvCourseTitle),
          const SizedBox(height: 12),
          _CvTextField(
            controller: _courseDateController,
            label: s.cvCourseDate,
            readOnly: true,
            onTap: () => _pickDate(_courseDateController),
          ),
          const SizedBox(height: 12),
          _PrimaryButton(
            label: s.cvButtonAdd,
            onPressed: _addCourse,
          ),
          const SizedBox(height: 16),
          _EntryList(
            entries: _courses.map((e) => e.title).toList(),
            onDelete: (index) => setState(() => _courses.removeAt(index)),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceStep(S s) {
    return _CardWrapper(
      title: s.cvStepExperience,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _CvTextField(controller: _expCompanyArController, label: s.cvExperienceCompanyAr),
            const SizedBox(height: 12),
            _CvTextField(controller: _expCompanyEnController, label: s.cvExperienceCompanyEn),
            const SizedBox(height: 12),
            _CvTextField(controller: _expRoleArController, label: s.cvExperienceRoleAr),
            const SizedBox(height: 12),
            _CvTextField(controller: _expRoleEnController, label: s.cvExperienceRoleEn),
            const SizedBox(height: 12),
            _CvTextField(
              controller: _expDescController,
              label: s.cvExperienceDescription,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            _CvTextField(
              controller: _expStartController,
              label: s.cvExperienceStartDate,
              readOnly: true,
              onTap: () => _pickDate(_expStartController),
            ),
            const SizedBox(height: 12),
            _CvTextField(
              controller: _expEndController,
              label: s.cvExperienceEndDate,
              readOnly: true,
              onTap: () => _pickDate(_expEndController),
            ),
            const SizedBox(height: 12),
            _PrimaryButton(
              label: s.cvButtonAdd,
              onPressed: _addExperience,
            ),
            const SizedBox(height: 16),
            _EntryList(
              entries: _experiences.map((e) => e.companyAr).toList(),
              onDelete: (index) => setState(() => _experiences.removeAt(index)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(S s) {
    final hasPrevious = _currentStep > 0;
    final isLast = _currentStep == _totalSteps - 1;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: hasPrevious ? _previousStep : null,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: AppColors.purple),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            ),
            child: Text(s.cvButtonPrevious),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _isSaving ? null : (isLast ? _submit : _nextStep),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            ),
            child:
                _isSaving
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Text(isLast ? s.cvButtonFinish : s.cvButtonSaveContinue),
          ),
        ),
      ],
    );
  }

  void _addSkill() {
    final value = _skillController.text.trim();
    if (value.isEmpty) return;
    setState(() {
      _skills.add(value);
      _skillController.clear();
    });
  }

  void _addEducation() {
    if (_eduInstitutionController.text.trim().isEmpty) return;
    setState(() {
      _education.add(
        CvEducationEntry(
          institution: _eduInstitutionController.text.trim(),
          majorAr: _eduMajorArController.text.trim(),
          majorEn: _eduMajorEnController.text.trim(),
          startDate: _eduStartController.text.trim(),
          endDate: _eduEndController.text.trim(),
        ),
      );
      _eduInstitutionController.clear();
      _eduMajorArController.clear();
      _eduMajorEnController.clear();
      _eduStartController.clear();
      _eduEndController.clear();
    });
  }

  void _addCourse() {
    if (_courseTitleController.text.trim().isEmpty) return;
    setState(() {
      _courses.add(
        CvCourseEntry(
          organization: _courseOrgController.text.trim(),
          title: _courseTitleController.text.trim(),
          date: _courseDateController.text.trim(),
        ),
      );
      _courseOrgController.clear();
      _courseTitleController.clear();
      _courseDateController.clear();
    });
  }

  void _addExperience() {
    if (_expCompanyArController.text.trim().isEmpty) return;
    setState(() {
      _experiences.add(
        CvExperienceEntry(
          companyAr: _expCompanyArController.text.trim(),
          companyEn: _expCompanyEnController.text.trim(),
          roleAr: _expRoleArController.text.trim(),
          roleEn: _expRoleEnController.text.trim(),
          description: _expDescController.text.trim(),
          startDate: _expStartController.text.trim(),
          endDate: _expEndController.text.trim(),
        ),
      );
      _expCompanyArController.clear();
      _expCompanyEnController.clear();
      _expRoleArController.clear();
      _expRoleEnController.clear();
      _expDescController.clear();
      _expStartController.clear();
      _expEndController.clear();
    });
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 30),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      controller.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _submit() async {
    final s = S.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.profileNoData)),
      );
      return;
    }
    final filteredSkills = _skills.where((e) => e.trim().isNotEmpty).toList();
    final phones = [
      _phone1Controller.text.trim(),
      _phone2Controller.text.trim(),
      _phone3Controller.text.trim(),
    ]..removeWhere((element) => element.isEmpty);
    final data = CvData(
      jobTitleAr: _jobTitleArController.text.trim(),
      jobTitleEn: _jobTitleEnController.text.trim(),
      educationLevel: _educationLevelController.text.trim(),
      yearsExperience: _yearsExperienceController.text.trim(),
      phones: phones,
      email: _emailController.text.trim(),
      skills: filteredSkills,
      summaryAr: _summaryArController.text.trim(),
      summaryEn: _summaryEnController.text.trim(),
      education: List.from(_education),
      experiences: List.from(_experiences),
      courses: List.from(_courses),
      updatedAt: DateTime.now(),
    );
    try {
      setState(() => _isSaving = true);
      await CvRepository.saveCv(user.uid, data);
      await _handleCompletion(data, s);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

class _CvStepIndicator extends StatelessWidget {
  const _CvStepIndicator({required this.currentStep, required this.totalSteps});

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final List<int> steps = List.generate(totalSteps, (index) => index + 1);
    return Row(
      children: steps.map((step) {
        final isActive = step == currentStep;
        final isCompleted = step < currentStep;
        final color =
            isActive
                ? AppColors.purple
                : isCompleted
                ? AppColors.purpleDark.withValues(alpha: 0.6)
                : AppColors.pillBackground;
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$step',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              if (step != totalSteps)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 2,
                  color: AppColors.purple.withValues(alpha: 0.3),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _CardWrapper extends StatelessWidget {
  const _CardWrapper({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _CvTextField extends StatelessWidget {
  const _CvTextField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.maxLines = 1,
    this.suffix,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? suffix;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bannerGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Text(label),
      ),
    );
  }
}

class _EntryList extends StatelessWidget {
  const _EntryList({required this.entries, required this.onDelete});

  final List<String> entries;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          S.of(context).cvNoData,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
    return Column(
      children: [
        const SizedBox(height: 8),
        ...entries.asMap().entries.map(
          (entry) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(entry.value),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => onDelete(entry.key),
            ),
          ),
        ),
      ],
    );
  }
}

extension _ListExt<E> on List<E> {
  E? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
