import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder_api/api.dart';

String linkPathByLabel(LinkLabelEnum label) {
  switch (label.toJson().split('.').last.toLowerCase()) {
    case 'facebook':
      return ImageConstants.facebook;
    case 'whatsapp':
      return ImageConstants.whatsapp;
    case 'gmail':
      return ImageConstants.gmail;
    case 'linkedin':
      return ImageConstants.linkedin;
    case 'x':
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
    case 'link':
      return ImageConstants.defaultLink;
    default:
      return ImageConstants.defaultLink;
  }
}

LinkLabelEnum stringToEnumLink(String label) {
  switch (label.toLowerCase()) {
    case 'facebook':
      return LinkLabelEnum.facebook;
    case 'whatsapp':
      return LinkLabelEnum.whatsApp;
    case 'gmail':
      return LinkLabelEnum.gmail;
    case 'linkedin':
      return LinkLabelEnum.linkedIn;
    case 'x':
      return LinkLabelEnum.X;
    case 'instagram':
      return LinkLabelEnum.instagram;
    case 'github':
      return LinkLabelEnum.gitHub;
    case 'outlook':
      return LinkLabelEnum.outLook;
    case 'skype':
      return LinkLabelEnum.skype;
    case 'slack':
      return LinkLabelEnum.slack;
    case 'qcarder':
      return LinkLabelEnum.qCarder;
    case 'link':
      return LinkLabelEnum.link;
    default:
      return LinkLabelEnum.link;
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
