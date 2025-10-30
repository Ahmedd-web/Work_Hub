import 'package:flutter/material.dart';



class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child: const Text(
                'سياسة الخصوصية وشروط الاستخدام',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: const Text(
                'شروط الاستخدام',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'نحن في موقع "وظفني" نلتزم بحماية خصوصيتك وبياناتك الشخصية. توضح هذه السياسة كيفية جمعنا واستخدامنا وحماية معلوماتك.\n\n'
                '1. جمع المعلومات:\n'
                '• نجمع المعلومات التي تقدمها لنا مباشرة عند التسجيل وإنشاء الحساب\n'
                '• معلومات الاتصال والسيرة الذاتية\n'
                '• بيانات التصفح والتفاعل مع المنصة\n\n'
                '2. استخدام المعلومات:\n'
                '• تقديم وتطوير خدمات التوظيف\n'
                '• توصيل الوظائف المناسبة لمؤهلاتك\n'
                '• تحسين تجربة المستخدم\n'
                '• التواصل معك بشأن التحديثات والفرص\n\n'
                '3. حماية البيانات:\n'
                '• نستخدم تقنيات تشفير متقدمة\n'
                '• نقوم بتخزين البيانات على خوادم آمنة\n'
                '• نحدد الوصول إلى المعلومات الشخصية\n\n'
                '4. مشاركة المعلومات:\n'
                '• لا نبيع بياناتك الشخصية لأطراف ثالثة\n'
                '• نشارك المعلومات مع أصحاب العمل فقط بموافقتك\n'
                '• يمكن مشاركة البيانات المجمعة لأغراض إحصائية\n\n'
                '5. حقوق المستخدم:\n'
                '• يمكنك طلب تصحيح أو حذف بياناتك\n'
                '• لديك الحق في معرفة المعلومات المخزنة عنك\n'
                '• يمكنك إلغاء الاشتراك في الرسائل الإخبارية\n\n'
                '6. التحديثات:\n'
                '• قد نقوم بتحديث هذه السياسة periodically\n'
                '• سنخطرك بأي تغييرات جوهرية\n'
                '• استمرار استخدامك للموقع يعني موافقتك على التحديثات\n\n'
                'للاستفسارات حول سياسة الخصوصية، يرجى التواصل معنا عبر صفحة اتصل بنا.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('شكراً لموافقتك على شروط الاستخدام'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: const Color.fromARGB(255, 147, 8, 228),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'أوافق على شروط الاستخدام',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
