import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  static Future<AppInfo> fromPlatform() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}
