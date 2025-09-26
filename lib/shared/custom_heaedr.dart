import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;

  const CustomHeader({
    super.key,
    required this.title,
    this.backgroundColor = Colors.cyan,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 48,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
