import 'package:qcarder/configuration/image_constants.dart';

String linkPathByLabel(String label) {
  switch (label.toLowerCase()) {
    case 'facebook':
      return ImageConstants.facebook;
    case 'wahtsapp':
      return ImageConstants.wahtsapp;
    case 'gmail':
      return ImageConstants.gmail;
    case 'linkedin':
      return ImageConstants.linkedin;
    case 'twitter':
      return ImageConstants.twitter;
    case 'instagram':
      return ImageConstants.instagram;
    case 'github':
      return ImageConstants.github;
    case 'outlook':
      return ImageConstants.outlook;
    case 'skype':
      return ImageConstants.skype;
    case 'slack':
      return ImageConstants.slack;
    case 'qcarder':
      return ImageConstants.letterLogoWhite;
    default:
      return ImageConstants.defaultLink;
  }
}

String flagPathByName(String name) {
  switch (name.toLowerCase()) {
    case 'jordan':
      return ImageConstants.jordan;
    case 'uae':
      return ImageConstants.uae;
    default:
      return ImageConstants.uae;
  }
}
