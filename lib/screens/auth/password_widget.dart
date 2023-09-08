import 'package:flutter/material.dart';
import 'package:qcarder/configuration/theme.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField(this.controller, {super.key});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // Use the provided controller here
      style: Theme.of(context).textTheme.bodySmall,

      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: Theme.of(context).textTheme.bodySmall,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.grey.withOpacity(0.5),
            ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      obscureText: _obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
