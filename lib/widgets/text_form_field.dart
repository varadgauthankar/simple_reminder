import 'package:flutter/material.dart';

class MyTextFromField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;

  const MyTextFromField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: labelText,
        hintText: labelText,
      ),
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
    );
  }
}
