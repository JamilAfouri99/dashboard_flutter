import 'package:dashboard/configuration/theme.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double width;
  const CustomProgressIndicator({Key? key, this.width = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: width,
          height: width,
          child: const CircularProgressIndicator(
            backgroundColor: AppColors.primary,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.light),
          )),
    );
  }
}
