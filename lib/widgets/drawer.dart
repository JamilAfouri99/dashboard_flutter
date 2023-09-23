import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/navigation/router_manager.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkPrimary,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [
          SvgPicture.asset(ImageConstants.fullWhiteLogo, width: 40, height: 40),
          itemBuilder(context, 'Group Users', RouteConstants.users),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, String name, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: ListTile(
        onTap: () => RouteManager.pushAndRemoveAll(
          routeName: route,
          context: context,
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.light,
              ),
        ),
        leading: const Icon(Icons.group_outlined),
        iconColor: AppColors.light,
        textColor: AppColors.light,
        tileColor: AppColors.light.withOpacity(0.12),
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
