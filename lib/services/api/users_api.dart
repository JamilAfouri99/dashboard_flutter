import 'package:dashboard/configuration/config.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/http/http_service.dart';

class UsersApi {
  final httpService = HttpService(EnvConfig.instance.baseUrl);

  Future<UsersResponse> fetch() async {
    return await httpService.getRequest<UsersResponse>(
      path: ApiConstants.users,
      queryParameters: {'page': '1', 'perPage': '10'}, //FIXME: implement logic here
      expectedResponseModel: (json) {
        return UsersResponse.fromJson(json);
      },
    );
  }
}
