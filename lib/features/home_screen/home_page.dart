import 'package:flutter/material.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            title: "WorkHub",
            showBackButton: false,
            showMenuButton: true,
            showNotificationButton: true,
            showSearchBar: true,
          ),
        ],
      ),
    );
  }
}
