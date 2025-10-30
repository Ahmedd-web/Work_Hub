import 'package:flutter/material.dart';



class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color.fromARGB(255, 25, 181, 215),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40.0),
              child: const Text(
                'عن موقع WoorkHup',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            _buildQuestionCard(
              question: 'ما هو الموقع WoorkHup؟',
              answer:
                  'منصة إلكترونية متكاملة تهدف إلى ربط الباحثين عن عمل بفرص التوظيف المناسبة، وتسهيل عملية البحث والتقديم للوظائف بمختلف المجالات.',
              icon: Icons.work,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            _buildQuestionCard(
              question: 'لماذا موقع WoorkHup  ؟',
              answer:
                  'نوفر وقت وجهد الباحثين عن عمل، ونقدم للشركات كفاءات مؤهلة، مع واجهة سهلة الاستخدام وتجربة مستخدم متميزة.',
              icon: Icons.thumb_up,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            _buildQuestionCard(
              question: 'ما يميز موقع WoorkHup؟',
              answer:
                  'شبكة واسعة من الشركات، توصيات ذكية للوظائف، تطبيقات متنوعة على جميع الأجهزة، ودعم متواصل للباحثين عن عمل.',
              icon: Icons.star,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard({
    required String question,
    required String answer,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color:Colors.grey ,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
