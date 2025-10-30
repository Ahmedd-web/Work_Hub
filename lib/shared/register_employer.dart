import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/login.dart';
import 'package:work_hub/shared/customInputfield.dart';

class EmployerForm extends StatefulWidget {
  const EmployerForm({super.key});

  @override
  State<EmployerForm> createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
  final _formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
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
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Employer name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,

            hint: "name of company,organization,restaurant...",
            controller: companyNameController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
          ),

          const SizedBox(height: 30),
          const Text(
            "Phone Number",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,

            hint: "enter phone number...",
            controller: phoneController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          const Text(
            "Email ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,

            hint: "enter email address...",
            controller: emailController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          const Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.lock,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,

            hint: "enter password...",
            controller: passwordController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          const Text(
            "Confirm Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          CustomInputField(
            prefixIcon: Icons.lock,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,

            hint: "re-enter password...",
            controller: confirmPassController,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "Required";
              }
              if (passwordController.text != confirmPassController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'The password provided is too weak',
                    ).show();
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'The account already exists for that email',
                    ).show();
                  }
                } catch (e) {
                  print(e);
                }
                setState(() {
                  isLoading = false;
                });
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
                    : const Text(
                      "Register",
                      style: TextStyle(
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
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.purple),
                    ),
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
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
