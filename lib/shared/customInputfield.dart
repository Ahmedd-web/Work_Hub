import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isPassword;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;

  const CustomInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    required this.prefixIcon,
    this.validator,
    this.textDirection,
  });

  @override
  State<CustomInputField> createState() => CustomInputFieldState();
}

class CustomInputFieldState extends State<CustomInputField> {
  bool hideText = true;
  @override
  Widget build(BuildContext context) {
    final fieldDirection = widget.textDirection ?? Directionality.of(context);
    final isRtl = fieldDirection == TextDirection.rtl;
    final mainIcon = Icon(widget.prefixIcon);
    final toggleIcon =
        widget.isPassword
            ? IconButton(
              icon: Icon(hideText ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => hideText = !hideText),
            )
            : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? hideText : false,
          validator: widget.validator,
          textDirection: fieldDirection,
          textAlign:
              fieldDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: isRtl ? toggleIcon : mainIcon,
            suffixIcon: isRtl ? mainIcon : toggleIcon,
          ),
        ),
      ],
    );
  }
}
