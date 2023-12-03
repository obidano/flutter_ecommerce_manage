import 'package:flutter/material.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';

class MTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const MTextField({
    super.key,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.textStyle,
    this.inputDecoration,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.p16),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: textStyle,
          keyboardType: keyboardType,
          validator: validator,
          decoration: inputDecoration ??
              InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(),
              ),
        )
      ],
    );
  }
}
