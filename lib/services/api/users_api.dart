import 'package:dashboard/configuration/config.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/http/http_service.dart';

class UsersApi {
  final httpService = HttpService(EnvConfig.instance.baseUrl);

  Future<UsersResponse> fetch({int page = 1, int perPage = 10}) async {
    return await httpService.getRequest<UsersResponse>(
      path: ApiConstants.users,
      queryParameters: {'page': page.toString(), 'perPage': perPage.toString()},
      expectedResponseModel: (json) {
        return UsersResponse.fromJson(json);
      },
    );
  }
}
