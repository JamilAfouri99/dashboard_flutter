import 'dart:developer';
import 'dart:io';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  static Future<File?> pickImage(BuildContext context) async {
    try {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final fileTemp = File(pickedImage.path);
        // final bytes = fileTemp.readAsBytesSync();
        // return bytes;
        return fileTemp;
      }
    } catch (error) {
      log('error', error: error);
      CustomSnackbar.show(
        context,
        error.toString(),
        type: SnackbarType.error,
      );
    }
    return null;
  }
}
