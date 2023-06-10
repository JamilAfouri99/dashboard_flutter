import 'dart:io';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  static Future<Uint8List?> takePicture(BuildContext context) async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        final fileTemp = File(pickedImage.path);
        final bytes = fileTemp.readAsBytesSync();
        return bytes;
      }
    } catch (error) {
      CustomSnackbar.show(
        context,
        error.toString(),
        type: SnackbarType.error,
      );
    }
  }
}
