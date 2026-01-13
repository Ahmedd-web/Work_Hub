import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/home_screen/models/cv_data.dart';
import 'package:work_hub/features/home_screen/services/cv_repository.dart';
import 'package:work_hub/features/home_screen/widgets/cv_wizard/cv_wizard_components.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class CvWizardPage extends StatelessWidget {
  const CvWizardPage({super.key, this.initialData});
  final CvData? initialData;

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
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
    this.enableScrolling = true,
    this.onCompleted,
  });
  final CvData? initialData;
  final EdgeInsetsGeometry? padding;
  final bool enableScrolling;
  final ValueChanged<CvData>? onCompleted;

  @override
  State<CvWizardForm> createState() => CvWizardFormState();
}

class CvWizardFormState extends State<CvWizardForm> {
  static const int totalSteps = 7;
  int currentStep = 0;
  bool isSaving = false;

  late final TextEditingController jobTitleArController;
  late final TextEditingController jobTitleEnController;
  late final TextEditingController educationLevelController;
  late final TextEditingController yearsExperienceController;
  late final TextEditingController phone1Controller;
  late final TextEditingController phone2Controller;
  late final TextEditingController phone3Controller;
  late final TextEditingController emailController;
  late final TextEditingController skillController;
  late final TextEditingController summaryArController;
  late final TextEditingController summaryEnController;
  late final TextEditingController eduInstitutionController;
  late final TextEditingController eduMajorArController;
  late final TextEditingController eduMajorEnController;
  late final TextEditingController eduStartController;
  late final TextEditingController eduEndController;
  late final TextEditingController expCompanyArController;
  late final TextEditingController expCompanyEnController;
  late final TextEditingController expRoleArController;
  late final TextEditingController expRoleEnController;
  late final TextEditingController expDescController;
  late final TextEditingController expStartController;
  late final TextEditingController expEndController;
  late final TextEditingController courseOrgController;
  late final TextEditingController courseTitleController;
  late final TextEditingController courseDateController;

  final List<String> skills = [];
  final List<CvEducationEntry> education = [];
  final List<CvCourseEntry> courses = [];
  final List<CvExperienceEntry> experiences = [];

  @override
  void initState() {
    super.initState();
    initControllers();
    applyInitialData(widget.initialData, resetCollections: true);
  }

  @override
  void didUpdateWidget(covariant CvWizardForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newData = widget.initialData;
    if (newData == null) return;
    final prev = oldWidget.initialData;
    if (prev == null || prev.updatedAt != newData.updatedAt) {
      applyInitialData(newData, resetCollections: true);
    }
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  List<TextEditingController> get controllers => [
    jobTitleArController,
    jobTitleEnController,
    educationLevelController,
    yearsExperienceController,
    phone1Controller,
    phone2Controller,
    phone3Controller,
    emailController,
    summaryArController,
    summaryEnController,
    skillController,
    eduInstitutionController,
    eduMajorArController,
    eduMajorEnController,
    eduStartController,
    eduEndController,
    expCompanyArController,
    expCompanyEnController,
    expRoleArController,
    expRoleEnController,
    expDescController,
    expStartController,
    expEndController,
    courseOrgController,
    courseTitleController,
    courseDateController,
  ];

  void initControllers() {
    jobTitleArController = TextEditingController();
    jobTitleEnController = TextEditingController();
    educationLevelController = TextEditingController();
    yearsExperienceController = TextEditingController();
    phone1Controller = TextEditingController();
    phone2Controller = TextEditingController();
    phone3Controller = TextEditingController();
    emailController = TextEditingController();
    summaryArController = TextEditingController();
    summaryEnController = TextEditingController();
    skillController = TextEditingController();
    eduInstitutionController = TextEditingController();
    eduMajorArController = TextEditingController();
    eduMajorEnController = TextEditingController();
    eduStartController = TextEditingController();
    eduEndController = TextEditingController();
    expCompanyArController = TextEditingController();
    expCompanyEnController = TextEditingController();
    expRoleArController = TextEditingController();
    expRoleEnController = TextEditingController();
    expDescController = TextEditingController();
    expStartController = TextEditingController();
    expEndController = TextEditingController();
    courseOrgController = TextEditingController();
    courseTitleController = TextEditingController();
    courseDateController = TextEditingController();
  }

  void applyInitialData(CvData? data, {bool resetCollections = false}) {
    if (resetCollections) {
      skills.clear();
      education.clear();
      courses.clear();
      experiences.clear();
    }
    if (data == null) {
      jobTitleArController.text = '';
      jobTitleEnController.text = '';
      educationLevelController.text = '';
      yearsExperienceController.text = '';
      phone1Controller.text = '';
      phone2Controller.text = '';
      phone3Controller.text = '';
      emailController.text = '';
      summaryArController.text = '';
      summaryEnController.text = '';
      return;
    }
    jobTitleArController.text = data.jobTitleAr;
    jobTitleEnController.text = data.jobTitleEn;
    educationLevelController.text = data.educationLevel;
    yearsExperienceController.text = data.yearsExperience;
    phone1Controller.text = data.phones.elementAtOrNull(0) ?? '';
    phone2Controller.text = data.phones.elementAtOrNull(1) ?? '';
    phone3Controller.text = data.phones.elementAtOrNull(2) ?? '';
    emailController.text = data.email;
    summaryArController.text = data.summaryAr;
    summaryEnController.text = data.summaryEn;
    if (resetCollections) {
      skills.addAll(data.skills);
      education.addAll(data.education);
      courses.addAll(data.courses);
      experiences.addAll(data.experiences);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CvStepIndicator(currentStep: currentStep + 1, totalSteps: totalSteps),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: buildStep(s),
        ),
        const SizedBox(height: 16),
        NavigationButtons(
          s: s,
          currentStep: currentStep,
          totalSteps: totalSteps,
          isSaving: isSaving,
          onBack: () => setState(() => currentStep--),
          onNext: () {
            if (validateStep(currentStep, s)) {
              setState(() => currentStep++);
            }
          },
          onFinish: () => saveCv(s),
        ),
      ],
    );

    return widget.enableScrolling
        ? SingleChildScrollView(
          padding: widget.padding ?? EdgeInsets.zero,
          child: child,
        )
        : Padding(padding: widget.padding ?? EdgeInsets.zero, child: child);
  }

  Widget buildStep(S s) {
    switch (currentStep) {
      case 0:
        return MainInfoStep(
          s: s,
          jobTitleArController: jobTitleArController,
          jobTitleEnController: jobTitleEnController,
          educationLevelController: educationLevelController,
          yearsExperienceController: yearsExperienceController,
        );
      case 1:
        return ContactStep(
          s: s,
          phone1Controller: phone1Controller,
          phone2Controller: phone2Controller,
          phone3Controller: phone3Controller,
          emailController: emailController,
        );
      case 2:
        return SkillsStep(
          s: s,
          skillController: skillController,
          skills: skills,
          onAddSkill: addSkill,
          onRemoveSkill: removeSkill,
        );
      case 3:
        return SummaryStep(
          s: s,
          summaryArController: summaryArController,
          summaryEnController: summaryEnController,
        );
      case 4:
        return EducationStep(
          s: s,
          eduInstitutionController: eduInstitutionController,
          eduMajorArController: eduMajorArController,
          eduMajorEnController: eduMajorEnController,
          eduStartController: eduStartController,
          eduEndController: eduEndController,
          education: education,
          onAdd: addEducation,
          onRemove: removeEducation,
          pickDate: pickDate,
        );
      case 5:
        return CoursesStep(
          s: s,
          courseOrgController: courseOrgController,
          courseTitleController: courseTitleController,
          courseDateController: courseDateController,
          courses: courses,
          onAdd: addCourse,
          onRemove: removeCourse,
          pickDate: pickDate,
        );
      case 6:
      default:
        return ExperienceStep(
          s: s,
          expCompanyArController: expCompanyArController,
          expCompanyEnController: expCompanyEnController,
          expRoleArController: expRoleArController,
          expRoleEnController: expRoleEnController,
          expDescController: expDescController,
          expStartController: expStartController,
          expEndController: expEndController,
          experiences: experiences,
          onAdd: addExperience,
          onRemove: removeExperience,
          pickDate: pickDate,
        );
    }
  }

  bool validateStep(int step, S s) {
    String? error;
    switch (step) {
      case 0:
        if (jobTitleArController.text.trim().isEmpty) error = s.fieldRequired;
        break;
      case 1:
        if (phone1Controller.text.trim().isEmpty &&
            phone2Controller.text.trim().isEmpty &&
            phone3Controller.text.trim().isEmpty) {
          error = s.fieldRequired;
        } else if (emailController.text.trim().isEmpty) {
          error = s.fieldRequired;
        }
        break;
      case 2:
        if (skills.isEmpty) error = s.cvSkillsEmpty;
        break;
      case 3:
        if (summaryArController.text.trim().isEmpty &&
            summaryEnController.text.trim().isEmpty) {
          error = s.cvSummaryEmpty;
        }
        break;
      case 4:
        if (education.isEmpty) error = s.cvNoData;
        break;
      case 6:
        if (experiences.isEmpty) error = s.cvNoData;
        break;
    }
    if (error != null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: s.dialogWarningTitle,
        desc: error,
        btnOkText: s.dialogOk,
        btnOkOnPress: () {},
      ).show();
      return false;
    }
    return true;
  }

  Future<void> saveCv(S s) async {
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
    setState(() => isSaving = true);
    try {
      final data = CvData(
        jobTitleAr: jobTitleArController.text.trim(),
        jobTitleEn: jobTitleEnController.text.trim(),
        educationLevel: educationLevelController.text.trim(),
        yearsExperience: yearsExperienceController.text.trim(),
        phones:
            [
              phone1Controller.text.trim(),
              phone2Controller.text.trim(),
              phone3Controller.text.trim(),
            ].where((e) => e.isNotEmpty).toList(),
        email: emailController.text.trim(),
        skills: List<String>.from(skills),
        summaryAr: summaryArController.text.trim(),
        summaryEn: summaryEnController.text.trim(),
        education: List<CvEducationEntry>.from(education),
        courses: List<CvCourseEntry>.from(courses),
        experiences: List<CvExperienceEntry>.from(experiences),
        updatedAt: DateTime.now(),
      );
      await CvRepository.saveCv(user.uid, data);
      widget.onCompleted?.call(data);
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: s.dialogSuccessTitle,
          desc: s.editProfileSuccessMessage,
          btnOkText: s.dialogOk,
          btnOkOnPress: () {},
        ).show();
      });
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
      if (mounted) setState(() => isSaving = false);
    }
  }

  Future<void> pickDate(TextEditingController controller) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      controller.text = '${date.year}-${date.month}-${date.day}';
    }
  }

  void addSkill() {
    final value = skillController.text.trim();
    if (value.isNotEmpty) {
      setState(() {
        skills.add(value);
        skillController.clear();
      });
    }
  }

  void removeSkill(String value) {
    setState(() => skills.remove(value));
  }

  void addEducation() {
    if (eduInstitutionController.text.trim().isEmpty) return;
    setState(() {
      education.add(
        CvEducationEntry(
          institution: eduInstitutionController.text.trim(),
          majorAr: eduMajorArController.text.trim(),
          majorEn: eduMajorEnController.text.trim(),
          startDate: eduStartController.text.trim(),
          endDate: eduEndController.text.trim(),
        ),
      );
      eduInstitutionController.clear();
      eduMajorArController.clear();
      eduMajorEnController.clear();
      eduStartController.clear();
      eduEndController.clear();
    });
  }

  void removeEducation(int index) {
    setState(() => education.removeAt(index));
  }

  void addCourse() {
    if (courseTitleController.text.trim().isEmpty) return;
    setState(() {
      courses.add(
        CvCourseEntry(
          organization: courseOrgController.text.trim(),
          title: courseTitleController.text.trim(),
          date: courseDateController.text.trim(),
        ),
      );
      courseOrgController.clear();
      courseTitleController.clear();
      courseDateController.clear();
    });
  }

  void removeCourse(int index) {
    setState(() => courses.removeAt(index));
  }

  void addExperience() {
    if (expCompanyArController.text.trim().isEmpty) return;
    setState(() {
      experiences.add(
        CvExperienceEntry(
          companyAr: expCompanyArController.text.trim(),
          companyEn: expCompanyEnController.text.trim(),
          roleAr: expRoleArController.text.trim(),
          roleEn: expRoleEnController.text.trim(),
          description: expDescController.text.trim(),
          startDate: expStartController.text.trim(),
          endDate: expEndController.text.trim(),
        ),
      );
      expCompanyArController.clear();
      expCompanyEnController.clear();
      expRoleArController.clear();
      expRoleEnController.clear();
      expDescController.clear();
      expStartController.clear();
      expEndController.clear();
    });
  }

  void removeExperience(int index) {
    setState(() => experiences.removeAt(index));
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    required this.s,
    required this.currentStep,
    required this.totalSteps,
    required this.isSaving,
    required this.onBack,
    required this.onNext,
    required this.onFinish,
  });

  final S s;
  final int currentStep;
  final int totalSteps;
  final bool isSaving;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final Future<void> Function() onFinish;

  @override
  Widget build(BuildContext context) {
    final hasPrevious = currentStep > 0;
    final isLast = currentStep == totalSteps - 1;
    return Row(
      children: [
        if (hasPrevious)
          Expanded(
            child: OutlinedButton(
              onPressed: isSaving ? null : onBack,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.purple),
                foregroundColor: AppColors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(s.cvButtonPrevious),
            ),
          ),
        if (hasPrevious) const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed:
                isSaving
                    ? null
                    : () async {
                      if (isLast) {
                        await onFinish();
                      } else {
                        onNext();
                      }
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isLast ? AppColors.bannerGreen : AppColors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
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
                    : Text(isLast ? s.cvButtonFinish : s.cvButtonSaveContinue),
          ),
        ),
      ],
    );
  }
}

class MainInfoStep extends StatelessWidget {
  const MainInfoStep({
    required this.s,
    required this.jobTitleArController,
    required this.jobTitleEnController,
    required this.educationLevelController,
    required this.yearsExperienceController,
  });
  final S s;
  final TextEditingController jobTitleArController;
  final TextEditingController jobTitleEnController;
  final TextEditingController educationLevelController;
  final TextEditingController yearsExperienceController;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: s.cvStepPersonalInfo,
      child: Column(
        children: [
          CvTextField(
            controller: jobTitleArController,
            label: s.cvFieldJobTitleAr,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: jobTitleEnController,
            label: s.cvFieldJobTitleEn,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: educationLevelController,
            label: s.cvFieldEducationLevel,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: yearsExperienceController,
            label: s.cvFieldYearsExperience,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class ContactStep extends StatelessWidget {
  const ContactStep({
    required this.s,
    required this.phone1Controller,
    required this.phone2Controller,
    required this.phone3Controller,
    required this.emailController,
  });
  final S s;
  final TextEditingController phone1Controller;
  final TextEditingController phone2Controller;
  final TextEditingController phone3Controller;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: s.cvStepContact,
      child: Column(
        children: [
          CvTextField(
            controller: phone1Controller,
            label: s.cvFieldPhone1,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: phone2Controller,
            label: s.cvFieldPhone2,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: phone3Controller,
            label: s.cvFieldPhone3,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: emailController,
            label: s.cvFieldEmail,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}

class SkillsStep extends StatelessWidget {
  const SkillsStep({
    required this.s,
    required this.skillController,
    required this.skills,
    required this.onAddSkill,
    required this.onRemoveSkill,
  });
  final S s;
  final TextEditingController skillController;
  final List<String> skills;
  final VoidCallback onAddSkill;
  final ValueChanged<String> onRemoveSkill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // ألوان ثابتة لضمان وضوحها في الدارك مود
    final chipBg = theme.colorScheme.primary;
    final chipTextColor = Colors.white;
    return CardWrapper(
      title: s.cvStepSkills,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CvTextField(
            controller: skillController,
            label: s.cvFieldSkillPlaceholder,
            suffix: IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.purple),
              onPressed: onAddSkill,
            ),
          ),
          const SizedBox(height: 12),
          if (skills.isEmpty)
            Text(s.cvNoData)
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  skills
                      .map(
                        (skill) => Chip(
                          backgroundColor: chipBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: theme.colorScheme.primary),
                          ),
                          label: Text(
                            skill,
                            style: TextStyle(
                              color: chipTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          deleteIcon: Icon(
                            Icons.close,
                            size: 18,
                            color: chipTextColor,
                          ),
                          onDeleted: () => onRemoveSkill(skill),
                        ),
                      )
                      .toList(),
            ),
        ],
      ),
    );
  }
}

class SummaryStep extends StatelessWidget {
  const SummaryStep({
    required this.s,
    required this.summaryArController,
    required this.summaryEnController,
  });
  final S s;
  final TextEditingController summaryArController;
  final TextEditingController summaryEnController;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: s.cvStepSummary,
      child: Column(
        children: [
          CvTextField(
            controller: summaryArController,
            label: s.cvFieldSummaryAr,
            maxLines: 4,
          ),
          const SizedBox(height: 18),
          CvTextField(
            controller: summaryEnController,
            label: s.cvFieldSummaryEn,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}

class EducationStep extends StatelessWidget {
  const EducationStep({
    required this.s,
    required this.eduInstitutionController,
    required this.eduMajorArController,
    required this.eduMajorEnController,
    required this.eduStartController,
    required this.eduEndController,
    required this.education,
    required this.onAdd,
    required this.onRemove,
    required this.pickDate,
  });
  final S s;
  final TextEditingController eduInstitutionController;
  final TextEditingController eduMajorArController;
  final TextEditingController eduMajorEnController;
  final TextEditingController eduStartController;
  final TextEditingController eduEndController;
  final List<CvEducationEntry> education;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final Future<void> Function(TextEditingController) pickDate;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: s.cvStepEducation,
      child: Column(
        children: [
          CvTextField(
            controller: eduInstitutionController,
            label: s.cvEducationInstitution,
          ),
          const SizedBox(height: 12),
          CvTextField(
            controller: eduMajorArController,
            label: s.cvEducationMajorAr,
          ),
          const SizedBox(height: 12),
          CvTextField(
            controller: eduMajorEnController,
            label: s.cvEducationMajorEn,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CvTextField(
                  controller: eduStartController,
                  label: s.cvEducationStartDate,
                  readOnly: true,
                  onTap: () => pickDate(eduStartController),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CvTextField(
                  controller: eduEndController,
                  label: s.cvEducationEndDate,
                  readOnly: true,
                  onTap: () => pickDate(eduEndController),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PrimaryButton(label: s.cvButtonAdd, onPressed: onAdd),
          const SizedBox(height: 16),
          EntryList(
            entries: education.map((e) => e.institution).toList(),
            onDelete: onRemove,
          ),
        ],
      ),
    );
  }
}

class CoursesStep extends StatelessWidget {
  const CoursesStep({
    required this.s,
    required this.courseOrgController,
    required this.courseTitleController,
    required this.courseDateController,
    required this.courses,
    required this.onAdd,
    required this.onRemove,
    required this.pickDate,
  });
  final S s;
  final TextEditingController courseOrgController;
  final TextEditingController courseTitleController;
  final TextEditingController courseDateController;
  final List<CvCourseEntry> courses;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final Future<void> Function(TextEditingController) pickDate;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: s.cvStepCourses,
      child: Column(
        children: [
          CvTextField(
            controller: courseOrgController,
            label: s.cvCourseOrganization,
          ),
          const SizedBox(height: 12),
          CvTextField(
            controller: courseTitleController,
            label: s.cvCourseTitle,
          ),
          const SizedBox(height: 12),
          CvTextField(
            controller: courseDateController,
            label: s.cvCourseDate,
            readOnly: true,
            onTap: () => pickDate(courseDateController),
          ),
          const SizedBox(height: 12),
          PrimaryButton(label: s.cvButtonAdd, onPressed: onAdd),
          const SizedBox(height: 16),
          EntryList(
            entries: courses.map((e) => e.title).toList(),
            onDelete: onRemove,
          ),
        ],
      ),
    );
  }
}

class ExperienceStep extends StatelessWidget {
  const ExperienceStep({
    required this.s,
    required this.expCompanyArController,
    required this.expCompanyEnController,
    required this.expRoleArController,
    required this.expRoleEnController,
    required this.expDescController,
    required this.expStartController,
    required this.expEndController,
    required this.experiences,
    required this.onAdd,
    required this.onRemove,
    required this.pickDate,
  });
  final S s;
  final TextEditingController expCompanyArController;
  final TextEditingController expCompanyEnController;
  final TextEditingController expRoleArController;
  final TextEditingController expRoleEnController;
  final TextEditingController expDescController;
  final TextEditingController expStartController;
  final TextEditingController expEndController;
  final List<CvExperienceEntry> experiences;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final Future<void> Function(TextEditingController) pickDate;

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: s.cvStepExperience,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CvTextField(
              controller: expCompanyArController,
              label: s.cvExperienceCompanyAr,
            ),
            const SizedBox(height: 12),
            CvTextField(
              controller: expCompanyEnController,
              label: s.cvExperienceCompanyEn,
            ),
            const SizedBox(height: 12),
            CvTextField(
              controller: expRoleArController,
              label: s.cvExperienceRoleAr,
            ),
            const SizedBox(height: 12),
            CvTextField(
              controller: expRoleEnController,
              label: s.cvExperienceRoleEn,
            ),
            const SizedBox(height: 12),
            CvTextField(
              controller: expDescController,
              label: s.cvExperienceDescription,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            CvTextField(
              controller: expStartController,
              label: s.cvExperienceStartDate,
              readOnly: true,
              onTap: () => pickDate(expStartController),
            ),
            const SizedBox(height: 12),
            CvTextField(
              controller: expEndController,
              label: s.cvExperienceEndDate,
              readOnly: true,
              onTap: () => pickDate(expEndController),
            ),
            const SizedBox(height: 12),
            PrimaryButton(label: s.cvButtonAdd, onPressed: onAdd),
            const SizedBox(height: 16),
            EntryList(
              entries: experiences.map((e) => e.companyAr).toList(),
              onDelete: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
