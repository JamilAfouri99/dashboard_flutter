import 'package:url_launcher/url_launcher.dart';

downloadApp() async {
  // Replace with your Flutter app's deep link URL scheme
  const String appDeepLink = "myflutterapp://";

  const String appStoreURL =
      "https://play.google.com/store/apps/details?id=com.example.myflutterapp";

  bool isAppInstalled = await canLaunchUrl(Uri(path: appDeepLink));

  if (isAppInstalled) {
    await launchUrl(Uri(path: appDeepLink));
  } else {
    await launchUrl(Uri(path: appStoreURL));
  }
}
