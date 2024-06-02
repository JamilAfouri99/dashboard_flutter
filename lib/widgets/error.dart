import 'package:flutter/material.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/widgets/custom_button.dart';

class GlobalErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetryPressed;

  const GlobalErrorWidget({
    Key? key,
    required this.title,
    required this.message,
    this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.onError,
            size: 120,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            )),
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: CustomButton(
            title: 'Back to Home',
            onPressed: () {
              if (onRetryPressed != null) {
                onRetryPressed!();
              }
            },
          ),
        )
      ],
    );
  }
}
