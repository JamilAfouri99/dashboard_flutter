import 'package:url_launcher/url_launcher.dart';

downloadApp() async {
  const String appDeepLink = 'qcarder://';

  const String appStoreURL = 'https://play.google.com/store/apps/details?id=com.qcarder.qcarder';
  https: //play.google.com/store/apps/details?id=com.qlixar.rewards&hl=en&gl=US

  bool isAppInstalled = await canLaunchUrl(Uri(path: appDeepLink));

  if (isAppInstalled) {
    await launchUrl(Uri(path: appDeepLink));
  } else {
    await launchUrl(Uri(path: appStoreURL));
  }
}
