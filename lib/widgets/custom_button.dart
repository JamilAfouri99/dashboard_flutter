import 'package:qcarder/utils/configuration/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isInverted;
  final bool isDisabled;
  final Widget? leading;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isInverted = false,
    this.isDisabled = false,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: isInverted
            ? const LinearGradient(
                colors: [Color(0xffF3F6FC), Color(0xffF3F6FC)],
              )
            : LinearGradient(
                colors: [
                  isDisabled
                      ? AppColors.primary.withAlpha(120)
                      : AppColors.primary,
                  isDisabled
                      ? AppColors.primary.withAlpha(120)
                      : AppColors.primary
                ],
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        onPressed: onPressed,
        child: leading == null
            ? Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: isInverted ? AppColors.primary : AppColors.light),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leading!,
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color:
                            isInverted ? AppColors.primary : AppColors.light),
                  )
                ],
              ),
      ),
    );
  }
}
