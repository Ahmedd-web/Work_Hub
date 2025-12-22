// ignore_for_file: unused_element

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/employer_session.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/employer/screens/employer_dashboard_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/customInputfield.dart';
import 'package:work_hub/networking/notification_service.dart';

class EmployerLoginPage extends StatefulWidget {
  const EmployerLoginPage({super.key});

  @override
  State<EmployerLoginPage> createState() => EmployerLoginPageState();
}

class EmployerLoginPageState extends State<EmployerLoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    final s = S.of(context);
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await EmployerSession.setMode(true);
      final current = FirebaseAuth.instance.currentUser;
      if (current != null) {
        await NotificationService.instance.ensurePermissionsAndSaveToken(
          current.uid,
        );
      }
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
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).employerCompanyLoginTitle),
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                s.employerLoginIntro,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.start,
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
                controller: emailController,
                prefixIcon: Icons.email_outlined,
                hint: s.loginEmailHint,
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty
                            ? s.loginEmailRequired
                            : null,
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
                controller: passwordController,
                prefixIcon: Icons.lock_outline,
                hint: s.loginPasswordHint,
                isPassword: true,
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty
                            ? s.loginPasswordRequired
                            : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bannerGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:
                    isLoading
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
