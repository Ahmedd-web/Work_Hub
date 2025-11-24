import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class EmployerEditInfoPage extends StatefulWidget {
  const EmployerEditInfoPage({super.key, required this.initialData});

  final Map<String, dynamic> initialData;

  @override
  State<EmployerEditInfoPage> createState() => _EmployerEditInfoPageState();
}

class _EmployerEditInfoPageState extends State<EmployerEditInfoPage> {
  late final TextEditingController _companyNameAr;
  late final TextEditingController _industryAr;
  late final TextEditingController _advertiserRole;
  late final TextEditingController _address;
  late final TextEditingController _website;
  late final TextEditingController _phoneNumber;
  late final TextEditingController _phoneNumberSecondary;
  late final TextEditingController _email;
  String _phonePrefix = 'LY (+218)';
  bool _saving = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    _companyNameAr = TextEditingController(
      text: data['company_name'] as String? ?? '',
    );
    _industryAr = TextEditingController(
      text: data['industry'] as String? ?? '',
    );
    _advertiserRole = TextEditingController(
      text: data['advertiser_role'] as String? ?? '',
    );
    _address = TextEditingController(text: data['address'] as String? ?? '');
    _website = TextEditingController(text: data['website'] as String? ?? '');
    _phoneNumber = TextEditingController(
      text: data['phone_primary']?.toString() ?? '',
    );
    _phoneNumberSecondary = TextEditingController(
      text: data['phone_secondary']?.toString() ?? '',
    );
    _email = TextEditingController(text: data['email'] as String? ?? '');
    _phonePrefix = data['phone_country'] as String? ?? 'LY (+218)';
  }

  @override
  void dispose() {
    _companyNameAr.dispose();
    _industryAr.dispose();
    _advertiserRole.dispose();
    _address.dispose();
    _website.dispose();
    _phoneNumber.dispose();
    _phoneNumberSecondary.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final s = S.of(context);
    setState(() => _saving = true);
    try {
      await FirebaseFirestore.instance
          .collection('employers')
          .doc(user.uid)
          .update({
            'company_name': _companyNameAr.text.trim(),
            'industry': _industryAr.text.trim(),
            'advertiser_role': _advertiserRole.text.trim(),
            'address': _address.text.trim(),
            'website': _website.text.trim(),
            'phone_primary': _phoneNumber.text.trim(),
            'phone_country': _phonePrefix,
            'phone_secondary': _phoneNumberSecondary.text.trim(),
            'email': _email.text.trim(),
            'updated_at': FieldValue.serverTimestamp(),
          });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(s.employerEditInfoSuccess)));
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(s.employerEditInfoFailure('$e'))));
    } finally {
      if (mounted) setState(() => _saving = false);
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
            showMenuButton: false,
            showNotificationButton: false,
            overlayChild: _HeaderPill(title: s.employerEditInfoHeader),
            overlayHeight: 70,
            height: 190,
          ),
          SizedBox(height: 45),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _RoundedField(
                      label: s.employerEditInfoLabelCompanyName,
                      controller: _companyNameAr,
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: s.employerEditInfoLabelIndustry,
                      controller: _industryAr,
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: s.employerEditInfoLabelAdvertiserRole,
                      controller: _advertiserRole,
                      suffixIcon: Icons.arrow_drop_down,
                      readOnly: true,
                      onTap: () async {
                        final value = await _selectAdvertiserRole(
                          context,
                          _advertiserRole.text,
                        );
                        if (value != null) {
                          _advertiserRole.text = value;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: s.employerEditInfoLabelAddress,
                      controller: _address,
                      suffixIcon: Icons.arrow_drop_down,
                      readOnly: true,
                      onTap: () async {
                        final value = await _selectAddress(
                          context,
                          _address.text,
                        );
                        if (value != null) _address.text = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: s.employerEditInfoLabelWebsite,
                      controller: _website,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      s.employerEditInfoSectionPhones,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      s.employerEditInfoLabelPhonePrimary,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _RoundedField(
                            controller: _phoneNumber,
                            keyboardType: TextInputType.phone,
                            label: null,
                            hintText: s.employerEditInfoPhoneHint,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 120,
                          child: _RoundedDropdown(
                            value: _phonePrefix,
                            onChanged:
                                (value) => setState(() => _phonePrefix = value),
                            options: const [
                              'LY (+218)',
                              'TN (+216)',
                              'EG (+20)',
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: s.employerEditInfoLabelPhoneSecondary,
                      controller: _phoneNumberSecondary,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: s.employerEditInfoLabelEmail,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _saving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child:
                            _saving
                                ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : Text(
                                  s.employerEditInfoSaveButton,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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

  Future<String?> _selectAdvertiserRole(
    BuildContext context,
    String current,
  ) async {
    final s = S.of(context);
    final options = [
      s.employerEditInfoRoleOwner,
      s.employerEditInfoRoleAgency,
      s.employerEditInfoRoleHR,
    ];
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => _OptionSheet(
            title: s.employerEditInfoSelectRoleTitle,
            options: options,
            current: current,
          ),
    );
  }

  Future<String?> _selectAddress(BuildContext context, String current) {
    final s = S.of(context);
    final options = [
      s.employerEditInfoAddressTripoli,
      s.employerEditInfoAddressBenghazi,
      s.employerEditInfoAddressMisrata,
      s.employerEditInfoAddressSabha,
      s.employerEditInfoAddressDerna,
      s.employerEditInfoAddressGharyan,
    ];
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => _OptionSheet(
            title: s.employerEditInfoSelectAddressTitle,
            options: options,
            current: current,
          ),
    );
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
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

class _RoundedField extends StatelessWidget {
  const _RoundedField({
    this.label,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.hintText,
  });

  final String? label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final s = S.of(context);
    final borderColor = colorScheme.outline.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.5 : 0.25,
    );
    final labelWidget =
        label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        GestureDetector(
          onTap: readOnly ? onTap : null,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            onTap: readOnly ? onTap : null,
            keyboardType: keyboardType,
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return s.employerEditInfoValidationRequired;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: borderColor),
              ),
              suffixIcon:
                  suffixIcon != null
                      ? Icon(
                        suffixIcon,
                        color: colorScheme.outline.withValues(alpha: 0.7),
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundedDropdown extends StatelessWidget {
  const _RoundedDropdown({
    required this.value,
    required this.onChanged,
    required this.options,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = colorScheme.outline.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.5 : 0.25,
    );
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items:
              options
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ),
    );
  }
}

class _OptionSheet extends StatelessWidget {
  const _OptionSheet({
    required this.title,
    required this.options,
    required this.current,
  });

  final String title;
  final List<String> options;
  final String current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...options.map(
              (option) => ListTile(
                title: Text(option),
                trailing:
                    option == current
                        ? Icon(Icons.check, color: colorScheme.primary)
                        : null,
                onTap: () => Navigator.of(context).pop(option),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
