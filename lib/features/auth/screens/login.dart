import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/core/employer_session.dart';
import 'package:work_hub/core/theme/app_theme.dart';
import 'package:work_hub/features/auth/screens/register.dart';
import 'package:work_hub/features/employer/screens/employer_login_page.dart';
import 'package:work_hub/features/home_screen/home_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/customInputfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          s.loginTitle,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const BackButtonIcon(),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 12),

            Text(
              s.loginEmail,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            CustomInputField(
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              hint: s.loginEmailHint,

              controller: emailController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return s.loginEmailRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            Text(
              s.loginPassword,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            CustomInputField(
              prefixIcon: Icons.lock,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              hint: s.loginPasswordHint,

              controller: passwordController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return s.loginPasswordRequired;
                }
                if (val.length < 6) {
                  return s.loginPasswordTooShort;
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                setState(() => isLoading = true);
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                  await EmployerSession.setMode(false);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } on FirebaseAuthException catch (e) {
                  final message =
                      e.code == 'user-not-found'
                          ? s.authErrorUserNotFound
                          : e.code == 'wrong-password'
                          ? s.authErrorWrongPassword
                          : (e.message ?? s.dialogErrorTitle);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: s.dialogErrorTitle,
                    desc: message,
                  ).show();
                } catch (e) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: s.dialogErrorTitle,
                    desc: e.toString(),
                  ).show();
                } finally {
                  if (mounted) {
                    setState(() => isLoading = false);
                  }
                }
              },
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
                      : Text(s.loginButton),
            ),

            const SizedBox(height: 20),

            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${s.loginNoAccount} ',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: s.loginRegister,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EmployerLoginPage()),
                );
              },
              child: const Text('تسجيل دخول الشركات'),
            ),
          ],
        ),
      ),
    );
  }
}
