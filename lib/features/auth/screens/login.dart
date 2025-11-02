import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/register.dart';
import 'package:work_hub/features/home_screen/home_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/customInputfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 40),
            Text(
              s.loginTitle,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 40),

            /// Email Field
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

            /// Password Field
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

            /// Login Button
            ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: s.dialogErrorTitle,
                      desc: s.authErrorUserNotFound,
                    ).show();
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: s.dialogErrorTitle,
                      desc: s.authErrorWrongPassword,
                    ).show();
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

            /// Navigate to Register
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
          ],
        ),
      ),
    );
  }
}
