import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/services/global_services.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, {SnackbarType type = SnackbarType.info}) {
    final key = KeysService.snackbarKey;
    if (key != null) {
      final snackbar = SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: AppColors.light),
        ),
        backgroundColor: _getSnackbarColor(type),
        behavior: SnackBarBehavior.floating,
      );
      key.currentState?.clearSnackBars();
      key.currentState?.showSnackBar(snackbar);
    }
  }

  static Color _getSnackbarColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.info:
        return AppColors.grey;
      case SnackbarType.error:
        return AppColors.onError;
      case SnackbarType.success:
        return AppColors.onSuccess;
    }
  }
}

enum SnackbarType { info, error, success }
