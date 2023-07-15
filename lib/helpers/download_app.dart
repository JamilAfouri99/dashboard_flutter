import 'package:url_launcher/url_launcher.dart';

downloadApp() async {
  // TODO
  // Replace with your Flutter app's deep link URL scheme
  const String appDeepLink = "qcarder://";

  const String appStoreURL =
      "https://play.google.com/store/apps/details?id=com.qcarder.qcarder";

  bool isAppInstalled = await canLaunchUrl(Uri(path: appDeepLink));

  if (isAppInstalled) {
    await launchUrl(Uri(path: appDeepLink));
  } else {
    await launchUrl(Uri(path: appStoreURL));
  }
}
