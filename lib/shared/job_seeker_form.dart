import 'package:flutter/material.dart';

class JobSeekerForm extends StatefulWidget {
  const JobSeekerForm({super.key});

  @override
  State<JobSeekerForm> createState() => _JobSeekerFormState();
}

class _JobSeekerFormState extends State<JobSeekerForm> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "First Name(required)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          shadowColor: Colors.grey,
          child: TextField(
            decoration: InputDecoration(
              hintText: "enter first name...",
              prefixIcon: const Icon(Icons.person),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "Last Name(required)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          shadowColor: Colors.grey,
          child: TextField(
            decoration: InputDecoration(
              hintText: "enter last name...",
              prefixIcon: const Icon(Icons.person),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "Phone Number",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          shadowColor: Colors.grey,
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "enter phone number...",
              prefixIcon: const Icon(Icons.phone),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          shadowColor: Colors.grey,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "enter email address...",
              prefixIcon: const Icon(Icons.email),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          shadowColor: Colors.grey,
          child: TextField(
            obscureText: hideText,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "enter password...",
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(hideText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hideText = !hideText;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "Confirm Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: hideText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: "enter password...",
            prefixIcon: const Icon(Icons.lock),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(hideText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  hideText = !hideText;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.cyan,
          ),
          onPressed: () {
            print("guest==============");
          },
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),

        Center(
          child: InkWell(
            onTap: () {
              print("contact============");
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
    );
  }
}
