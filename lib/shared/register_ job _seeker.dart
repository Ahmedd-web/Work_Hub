import 'package:awesome_dialog/awesome_dialog.dart';
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

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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
            s.registerFirstNameLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,
            hint: s.registerFirstNameHint,
            controller: firstNameController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return s.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Text(
            s.registerLastNameLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,
            hint: s.registerLastNameHint,
            controller: lastNameController,
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
          const SizedBox(height: 30),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() => isLoading = true);
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (!mounted) return;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: s.dialogErrorTitle,
                      desc: s.authErrorWeakPassword,
                    ).show();
                  } else if (e.code == 'email-already-in-use') {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: s.dialogErrorTitle,
                      desc: s.authErrorEmailInUse,
                    ).show();
                  }
                } catch (e) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: s.dialogErrorTitle,
                    desc: e.toString(),
                  ).show();
                }
                setState(() => isLoading = false);
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
