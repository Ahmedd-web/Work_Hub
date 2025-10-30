import 'package:flutter/material.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ads Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Services Ads',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: const Column(
                children: [
                  Text('إعلانات وظائف مُميزة في الصدارة'),
                  SizedBox(height: 10),
                  Text('باقات إعلانية متنوعة الأسعار'),
                  SizedBox(height: 10),
                  Text('تقارير أداء وتحليلات متقدمة'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
