import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Widget? prefixIcon;
  final EdgeInsets? scrollPadding;
  final bool? readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.hintStyle,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.scrollPadding,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.inputFormatters,
  });

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
          borderSide: BorderSide(
            color: AppColors.grey.withOpacity(0.4), // Set the border color to gray
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
        prefixIcon: prefixIcon,
      ),
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      style: const TextStyle(color: AppColors.dark, fontSize: 16, height: 1),
      validator: validator,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
