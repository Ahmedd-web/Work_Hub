import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/login.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/customInputfield.dart';

class JobSeekerForm extends StatefulWidget {
  const JobSeekerForm({super.key});

  @override
  State<JobSeekerForm> createState() => _JobSeekerForm();
}

class _JobSeekerForm extends State<JobSeekerForm> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool hideText = true;
  bool agreeToTerms = false;
  bool allowPublishing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            s.profileNameLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,
            hint: s.registerFirstNameHint,
            controller: fullNameController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return s.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text(
            s.registerPhoneLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            hint: s.registerPhoneHint,
            controller: phoneController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return s.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text(
            s.registerEmailLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            hint: s.registerEmailHint,
            controller: emailController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return s.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text(
            s.registerPasswordLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.lock,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            hint: s.registerPasswordHint,
            controller: passwordController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return s.fieldRequired;
              }
              if (val.length < 6) {
                return s.registerPasswordTooShort;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text(
            s.registerConfirmPasswordLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.lock,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            hint: s.registerConfirmPasswordHint,
            controller: confirmPassController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return s.fieldRequired;
              }
              if (passwordController.text != confirmPassController.text) {
                return s.registerPasswordMismatch;
              }
              return null;
            },
          ),
          const SizedBox(height: 50),

          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final dialogContext = context;
              if (!_formKey.currentState!.validate()) return;
              setState(() => isLoading = true);
              bool registrationSucceeded = false;
              String? errorMessage;
              try {
                final credential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
                final uid = credential.user!.uid;
                final fullName = fullNameController.text.trim();
                await FirebaseFirestore.instance
                    .collection('Profile')
                    .doc(uid)
                    .set({
                      'full_name': fullName,
                      'first_name': fullName,
                      'last_name': '',
                      'phone': phoneController.text.trim(),
                      'email': emailController.text.trim(),
                      'photo_url': '',
                    });
                registrationSucceeded = true;
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  errorMessage = s.authErrorWeakPassword;
                } else if (e.code == 'email-already-in-use') {
                  errorMessage = s.authErrorEmailInUse;
                } else {
                  errorMessage = s.dialogErrorTitle;
                }
              } catch (e) {
                errorMessage = e.toString();
              } finally {
                if (mounted) {
                  setState(() => isLoading = false);
                }
              }

              if (!context.mounted) return;
              if (registrationSucceeded) {
                await AwesomeDialog(
                  context: dialogContext,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: s.dialogErrorTitle,
                  desc: s.registerButton,
                  btnOkText: s.loginButton,
                  btnOkOnPress: () {},
                ).show();
                if (!context.mounted) return;
                navigator.pushReplacement(
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              } else if (errorMessage != null) {
                if (!context.mounted) return;
                AwesomeDialog(
                  context: dialogContext,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: s.dialogErrorTitle,
                  desc: errorMessage,
                ).show();
              }
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child:
                isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : Text(
                      s.registerButton,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${s.registerHaveAccount} ',
                      style: const TextStyle(color: Colors.purple),
                    ),
                    TextSpan(
                      text: s.registerLoginLink,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
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
}
