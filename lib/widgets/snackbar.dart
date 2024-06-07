import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/services/global_services.dart';
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
        backgroundColor: _getSnackbarColor(type, context),
        behavior: SnackBarBehavior.floating,
      );
      key.currentState?.clearSnackBars();
      key.currentState?.showSnackBar(snackbar);
    }
  }

  static Color _getSnackbarColor(SnackbarType type, BuildContext context) {
    switch (type) {
      case SnackbarType.info:
        return Theme.of(context).colorScheme.shadow;
      case SnackbarType.error:
        return AppColors.onError;
      case SnackbarType.success:
        return AppColors.onSuccess;
    }
  }
}

enum SnackbarType { info, error, success }
