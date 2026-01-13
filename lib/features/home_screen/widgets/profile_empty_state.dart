import 'package:flutter/material.dart';

/// حالة عدم وجود بيانات في صفحة الملف الشخصي.
class ProfileEmptyState extends StatelessWidget {
  const ProfileEmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
