import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool showBackButton;

  const CustomHeader({
    super.key,
    required this.title,
    this.backgroundColor = Colors.cyan,
    this.textColor = Colors.black,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 200;

    return SizedBox(
      width: double.infinity,
      height: headerHeight,
      child: Stack(
        children: [
          // خلفية بالشكل الجديد (قَصّة سفلية منحنية للداخل)
          Positioned.fill(
            child: CustomPaint(
              painter: _CurvedHeaderPainter(color: backgroundColor),
            ),
          ),

          // زر الرجوع (اختياري)
          if (showBackButton)
            Positioned(
              left: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                color: textColor,
              ),
            ),

          // العنوان في المنتصف
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// يرسم مستطيلاً أعلى مع حافة سفلية مقعّرة في المنتصف (بدون صور)
class _CurvedHeaderPainter extends CustomPainter {
  final Color color;

  _CurvedHeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final double dipHeight = 46; // عمق الانحناءة
    final double sideY = size.height - 52; // ارتفاع الجوانب قبل النزول للمنتصف

    final Path path =
        Path()
          ..moveTo(0, 0) // أعلى يسار
          ..lineTo(size.width, 0) // أعلى يمين
          ..lineTo(size.width, sideY) // نزول يميناً
          // قوس من اليمين نحو المنتصف (نزول للداخل)
          ..quadraticBezierTo(
            size.width,
            size.height, // نقطة تحكم
            size.width * 0.5,
            size.height, // قاع المنتصف
          )
          // قوس من المنتصف عائداً إلى اليسار
          ..quadraticBezierTo(
            0,
            size.height, // نقطة تحكم
            0,
            sideY, // صعود يساراً
          )
          ..close();

    canvas.drawPath(path, paint);

   
  }

  @override
  bool shouldRepaint(covariant _CurvedHeaderPainter oldDelegate) =>
      oldDelegate.color != color;
}
