// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:qcarder/utils/configuration/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final GestureDetector? suffixIcon;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.hintStyle,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: Colors.white, // Set the background color to white
        filled: true, // Enable the background fill
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: AppColors.grey, // Set the border color to gray
            width: 1.0,
          ),
        ),
        hintStyle: hintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
      ),
      style: const TextStyle(
        color: AppColors.dark,
      ),
      validator: validator,
    );
  }
}
