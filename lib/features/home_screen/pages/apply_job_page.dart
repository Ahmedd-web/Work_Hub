import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/features/home_screen/models/job_post.dart';
import 'package:work_hub/generated/l10n.dart';

class ApplyJobPage extends StatefulWidget {
  const ApplyJobPage({super.key, required this.job});

  final JobPost job;

  @override
  State<ApplyJobPage> createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameArController = TextEditingController();
  final _nameEnController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String _phoneCode = '+218';
  Uint8List? _cvBytes;
  String? _cvFileName;
  bool _isPickingCv = false;

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final fieldDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.6)),
    );
    final surfaceFill = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    final nameArLabel = isArabic ? 'الاسم بالعربية' : 'Name in Arabic';
    final nameArHint = isArabic ? 'اكتب الاسم بالعربية' : 'Name in Arabic';
    final nameEnLabel = isArabic ? 'الاسم بالإنجليزية' : 'Name in English';
    final nameEnHint = isArabic ? 'اكتب الاسم بالإنجليزية' : 'Name in English';
    final phoneLabel = isArabic ? 'رقم الهاتف' : 'Phone Number';
    final phoneHint = isArabic ? 'رقم الهاتف' : 'Phone number';
    final phoneRequired = isArabic ? 'هذا الحقل مطلوب' : s.fieldRequired;
    final cvLabel = isArabic ? 'السيرة الذاتية (PDF)' : 'Resume (PDF)';
    final cvButtonText =
        isArabic ? 'رفع ملف السيرة الذاتية' : 'Upload resume file';
    final cvRequired =
        isArabic
            ? 'يرجى إرفاق ملف PDF للسيرة الذاتية'
            : 'Please attach a PDF resume';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Directionality(
        textDirection: fieldDirection,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    child: Icon(
                      Icons.work_outline,
                      size: 38,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _LabeledField(
                  showLabel: false,
                  label: nameArLabel,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: _AlignedTextField(
                    controller: _nameArController,
                    isArabic: isArabic,
                    decoration: InputDecoration(
                      labelText: nameArLabel,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: nameArHint,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.4,
                        ),
                      ),
                      filled: true,
                      fillColor: surfaceFill,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.trim().isEmpty
                                ? phoneRequired
                                : null,
                  ),
                ),
                const SizedBox(height: 18),
                _LabeledField(
                  showLabel: false,
                  label: nameEnLabel,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: _AlignedTextField(
                    controller: _nameEnController,
                    isArabic: isArabic,
                    decoration: InputDecoration(
                      labelText: nameEnLabel,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: nameEnHint,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.4,
                        ),
                      ),
                      filled: true,
                      fillColor: surfaceFill,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                _LabeledField(
                  showLabel: false,
                  label: phoneLabel,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: Row(
                    children: [
                      if (isArabic) ...[
                        Expanded(
                          flex: 6,
                          child: _PhoneCodeField(
                            border: border,
                            colorScheme: colorScheme,
                            textDirection: fieldDirection,
                            value: _phoneCode,
                            onChanged: (val) {
                              if (val != null) setState(() => _phoneCode = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 10,
                          child: _PhoneNumberField(
                            controller: _phoneController,
                            border: border,
                            colorScheme: colorScheme,
                            isArabic: isArabic,
                            labelText: phoneLabel,
                            hintText: phoneHint,
                            requiredText: phoneRequired,
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          flex: 10,
                          child: _PhoneNumberField(
                            controller: _phoneController,
                            border: border,
                            colorScheme: colorScheme,
                            isArabic: isArabic,
                            labelText: phoneLabel,
                            hintText: phoneHint,
                            requiredText: phoneRequired,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 6,
                          child: _PhoneCodeField(
                            border: border,
                            colorScheme: colorScheme,
                            textDirection: fieldDirection,
                            value: _phoneCode,
                            onChanged: (val) {
                              if (val != null) setState(() => _phoneCode = val);
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _LabeledField(
                  showLabel: false,
                  label: s.loginEmail,
                  alignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  labelAlign: isArabic ? TextAlign.right : TextAlign.left,
                  child: _AlignedTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    isArabic: isArabic,
                    decoration: InputDecoration(
                      labelText: s.loginEmail,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: s.loginEmailHint,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.4,
                        ),
                      ),
                      filled: true,
                      fillColor: surfaceFill,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return s.loginEmailRequired;
                      }
                      final emailRegex = RegExp(
                        r'^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,}$',
                      );
                      if (!emailRegex.hasMatch(val.trim())) {
                        return s.loginEmailInvalid;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 18),
                _LabeledField(
                  label: cvLabel,
                  alignment: CrossAxisAlignment.center,
                  labelAlign: TextAlign.center,
                  child: Column(
                    children: [
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                          side: BorderSide(
                            color: colorScheme.primary,
                            width: 1.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed:
                            _isPickingCv ? null : () => _pickCv(cvRequired),
                        icon:
                            _isPickingCv
                                ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: colorScheme.primary,
                                  ),
                                )
                                : Icon(
                                  Icons.upload_outlined,
                                  color: colorScheme.primary,
                                ),
                        label: Text(
                          _cvFileName ?? cvButtonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (_cvFileName != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _cvFileName!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _submit,
                    child: Text(
                      s.applyNow,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickCv(String errorText) async {
    setState(() => _isPickingCv = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        setState(() {
          _cvBytes = file.bytes;
          _cvFileName = file.name;
        });
      } else if (result != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorText)));
      }
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorText)));
    } finally {
      if (mounted) setState(() => _isPickingCv = false);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_cvBytes == null) {
      final locale = Localizations.localeOf(context);
      final isArabic = locale.languageCode == 'ar';
      final cvRequired =
          isArabic
              ? 'يرجى إرفاق ملف PDF للسيرة الذاتية'
              : 'Please attach a PDF resume';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(cvRequired)));
      return;
    }
    FocusScope.of(context).unfocus();
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final applySuccess =
        isArabic
            ? 'تم إرسال طلبك لوظيفة ${widget.job.title}'
            : 'Application sent for ${widget.job.title}';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(applySuccess)));
    Navigator.of(context).maybePop();
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
    this.alignment = CrossAxisAlignment.end,
    this.labelAlign = TextAlign.right,
    this.showLabel = true,
  });

  final String label;
  final Widget child;
  final CrossAxisAlignment alignment;
  final TextAlign labelAlign;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: labelAlign,
          ),
          const SizedBox(height: 8),
        ],
        child,
      ],
    );
  }
}

class _AlignedTextField extends StatelessWidget {
  const _AlignedTextField({
    required this.controller,
    required this.isArabic,
    required this.decoration,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final bool isArabic;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final textAlign = isArabic ? TextAlign.right : TextAlign.left;
    return Directionality(
      textDirection: textDirection,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: textAlign,
        decoration: decoration,
        validator: validator,
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField({
    required this.controller,
    required this.border,
    required this.colorScheme,
    required this.isArabic,
    required this.hintText,
    required this.requiredText,
    required this.labelText,
  });

  final TextEditingController controller;
  final OutlineInputBorder border;
  final ColorScheme colorScheme;
  final bool isArabic;
  final String hintText;
  final String requiredText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final textAlign = isArabic ? TextAlign.right : TextAlign.left;
    return Directionality(
      textDirection: textDirection,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textAlign: textAlign,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hintText,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator:
            (val) => val == null || val.trim().isEmpty ? requiredText : null,
      ),
    );
  }
}

class _PhoneCodeField extends StatelessWidget {
  const _PhoneCodeField({
    required this.border,
    required this.colorScheme,
    required this.textDirection,
    required this.value,
    required this.onChanged,
  });

  final OutlineInputBorder border;
  final ColorScheme colorScheme;
  final TextDirection textDirection;
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isArabic = textDirection == TextDirection.rtl;
    return Directionality(
      textDirection: textDirection,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        items: [
          DropdownMenuItem(
            value: '+218',
            child: Text(isArabic ? '+218 ليبيا' : '+218 Libya'),
          ),
          DropdownMenuItem(
            value: '+20',
            child: Text(isArabic ? '+20 مصر' : '+20 Egypt'),
          ),
          DropdownMenuItem(
            value: '+971',
            child: Text(isArabic ? '+971 الإمارات' : '+971 UAE'),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
