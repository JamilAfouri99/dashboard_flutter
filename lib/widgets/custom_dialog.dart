import 'package:qcarder/utils/configuration/theme.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final void Function() action;
  final String actionName;
  final String title;
  final String message;

  const CustomDialog({
    super.key,
    required this.action,
    required this.actionName,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      actions: [
        Wrap(
          children: [
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primary],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  alignment: Alignment.center,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ),
                onPressed: action,
                child: Text(
                  actionName,
                  style: const TextStyle(color: AppColors.light),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
