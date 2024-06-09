import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/utils/configuration/image-constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:qcarder/widgets/app_version.dart';
import 'package:qcarder/widgets/custom_dialog.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 80),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset(ImageConstants.fullWhiteLogo, width: 40, height: 40),
                ),
                itemBuilder(context, ' Dashboard', RouteConstants.users),
                itemBuilder(context, ' Analytics', null),
                itemBuilder(context, ' Contact us', null),
              ],
            ),
          ),
          _appDetails(context)
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, String name, String? route) {
    final routeName = ModalRoute.of(context)?.settings.name;
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Set the cursor to pointer
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: routeName == route ? AppColors.primary : AppColors.noColor,
        ),
        child: ListTile(
          onTap: () {
            if (route != null) {
              RouteManager.pushAndRemoveAll(
                routeName: route,
                context: context,
              );
            } else {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => comingSoonHandler(context),
              );
            }
          },
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
      ),
    );
  }

  CustomDialog comingSoonHandler(BuildContext context) {
    return CustomDialog(
        action: () => Navigator.of(context).pop(),
        actionName: 'Got it',
        title: 'Coming Soon',
        message: 'Stay tuned! This feature will be available soon.');
  }

  _appDetails(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QCarder © 2024',
              style: TextStyle(color: AppColors.lightGrey.withOpacity(0.6)),
            ),
            Text(
              ' | ',
              style: TextStyle(color: AppColors.lightGrey.withOpacity(0.6)),
            ),
            AppVersion(
              color: AppColors.lightGrey.withOpacity(0.6),
            )
          ],
        ),
      ),
    );
  }
}
