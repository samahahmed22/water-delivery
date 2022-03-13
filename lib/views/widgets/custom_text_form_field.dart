import 'package:flutter/material.dart';

import '../../brand_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final TextInputType keyboardType;
  // final TextEditingController controller;
  final Function(String?) onSave;
  final String? Function(String?) validator;
  bool obscureText;

  CustomTextFormField({
    this.label,
    this.keyboardType = TextInputType.text,
    // required this.controller,
    required this.onSave,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: BrandColors.colorLightGrey,
          ),
        ),
      ),
      keyboardType: keyboardType,
      onSaved: onSave,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
