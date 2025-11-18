import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/employer_session.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/customInputfield.dart';

class EmployerLoginPage extends StatefulWidget {
  const EmployerLoginPage({super.key});

  @override
  State<EmployerLoginPage> createState() => _EmployerLoginPageState();
}

class _EmployerLoginPageState extends State<EmployerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final s = S.of(context);
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await EmployerSession.setMode(true);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const EmployerDashboardPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: s.dialogErrorTitle,
        desc:
            e.code == 'user-not-found'
                ? s.authErrorUserNotFound
                : e.code == 'wrong-password'
                ? s.authErrorWrongPassword
                : (e.message ?? s.dialogErrorTitle),
      ).show();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل دخول الشركات'),
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'أدخل بيانات شركتك للوصول إلى لوحة التحكم.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                s.loginEmail,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                hint: s.loginEmailHint,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? s.loginEmailRequired : null,
              ),
              const SizedBox(height: 20),
              Text(
                s.loginPassword,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomInputField(
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                hint: s.loginPasswordHint,
                isPassword: true,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? s.loginPasswordRequired : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bannerGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:
                    _isLoading
                        ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.onPrimary,
                            ),
                          ),
                        )
                        : const Text('دخول الشركات'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
