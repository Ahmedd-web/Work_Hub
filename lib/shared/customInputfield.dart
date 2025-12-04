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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? hideText : false,
          validator: widget.validator,
          textDirection: widget.textDirection,
          textAlign:
              widget.textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        hideText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => hideText = !hideText);
                      },
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
