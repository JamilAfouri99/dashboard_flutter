import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget {
  final Function onPressed;
  final String error;

  const FailedWidget({
    Key? key,
    required this.onPressed,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          error,
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: () => onPressed(),
          child: const Text('Reload'),
        ),
      ],
    );
  }
}
