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
      child: Stack(
        children: [
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
