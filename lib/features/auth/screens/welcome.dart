import 'package:flutter/material.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(title: "WorkHub"),
          const SizedBox(height: 100),
          Column(
            children: [
              const Text(
                "Welcome to WorkHub",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your gateway to seamless work management.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              Container(width: 280, height: 1, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
