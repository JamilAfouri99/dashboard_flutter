import 'package:flutter/material.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/utils/models/app_info.dart';

class AppVersion extends StatelessWidget {
  final Color color;
  const AppVersion({Key? key, this.color = AppColors.light}) : super(key: key);

  Future<AppInfo> _getAppInfo() async {
    final appInfo = await AppInfo.fromPlatform();
    return appInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppInfo>(
      future: _getAppInfo(),
      builder: (BuildContext context, AsyncSnapshot<AppInfo> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Loading...',
            style: textStyle(context),
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: textStyle(context),
          );
        } else {
          final appInfo = snapshot.data!;
          return Text(
            '${appInfo.version}(${appInfo.buildNumber})',
            textAlign: TextAlign.center,
            style: textStyle(context),
          );
        }
      },
    );
  }

  TextStyle textStyle(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
