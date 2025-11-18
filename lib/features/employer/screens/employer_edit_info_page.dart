import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/constants/app_assets.dart';
import 'package:work_hub/core/theme/app_theme.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ بيانات المنشأة بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('فشل الحفظ: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
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
            overlayChild: _HeaderPill(title: 'معلومات المنشأة'),
            overlayHeight: 70,
            height: 190,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _RoundedField(
                      label: 'اسم الشركة بالعربية',
                      controller: _companyNameAr,
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: 'مجال عمل الشركة بالعربية',
                      controller: _industryAr,
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: 'صفة المعلن',
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
                      label: 'العنوان',
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
                    _RoundedField(label: 'موقع الشركة', controller: _website),
                    const SizedBox(height: 24),
                    Text(
                      'رقم الهاتف',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
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
                            hintText: '945236782',
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
                      label: 'رقم هاتف آخر (اختياري)',
                      controller: _phoneNumberSecondary,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _RoundedField(
                      label: 'البريد الإلكتروني',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _saving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.purple,
                          foregroundColor: Colors.white,
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
                                : const Text(
                                  'حفظ',
                                  style: TextStyle(
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
    final options = ['صاحب العمل', 'شركة توظيف', 'ممثل الموارد البشرية'];
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => _OptionSheet(
            title: 'حدد صفة المعلن',
            options: options,
            current: current,
          ),
    );
  }

  Future<String?> _selectAddress(BuildContext context, String current) {
    final options = ['طرابلس', 'بنغازي', 'مصراتة', 'سبها', 'درنة', 'غريان'];
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => _OptionSheet(
            title: 'اختر المدينة',
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2C1F4F),
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
    final labelWidget =
        label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
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
              if ((value ?? '').trim().isEmpty) return 'هذا الحقل مطلوب';
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              suffixIcon:
                  suffixIcon != null
                      ? Icon(suffixIcon, color: Colors.grey)
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.grey.shade300),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...options.map(
              (option) => ListTile(
                title: Text(option),
                trailing:
                    option == current
                        ? const Icon(Icons.check, color: AppColors.purple)
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
