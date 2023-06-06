import 'package:dashboard/configuration/config.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/models/contact.dart';
import 'package:dashboard/services/http/http_service.dart';

class ContactsApi {
  final httpService = HttpService(EnvConfig.instance.baseUrl);
  static const delay = 500;

  Future<List<Contact>> fetchContacts() async {
    return await httpService.getRequest<List<Contact>>(
      path: ApiConstants.contacts,
      expectedResponseModel: (json) {
        return List.generate(json.length, (i) => Contact.fromJson(json[i]));
      },
    );
  }
}
