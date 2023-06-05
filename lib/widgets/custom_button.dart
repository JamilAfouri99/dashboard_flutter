import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class KeyperCustomButton extends StatelessWidget {
  final String title;
  final bool isInverted;
  final bool isDisabled;
  final bool isLoading;
  final Widget? leading;
  final Function() selected;

  const KeyperCustomButton({
    Key? key,
    required this.title,
    required this.selected,
    required this.isLoading,
    this.isInverted = false,
    this.isDisabled = false,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isInverted
            ? const LinearGradient(
                colors: [Color(0xffF3F6FC), Color(0xffF3F6FC)],
              )
            : LinearGradient(
                colors: [
                  isDisabled ? AppColors.primary.withAlpha(120) : AppColors.primary,
                  isDisabled ? AppColors.secondary.withAlpha(120) : AppColors.secondary
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        child: isLoading
            ? const CustomProgressIndicator(
                width: 20,
              )
            : leading == null
                ? Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: isInverted ? AppColors.primary : Colors.white),
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: isInverted ? AppColors.primary : Colors.white),
                      )
                    ],
                  ),
        onPressed: () {
          isLoading ? null : selected();
        },
      ),
    );
  }
}
