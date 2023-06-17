import 'package:dashboard/configuration/config.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/http/http_service.dart';

class UserApi {
  final httpService = HttpService(EnvConfig.instance.baseUrl);

  Future<User> fetch(String userId) async {
    return await httpService.getRequest<User>(
      path: ApiConstants.user(userId),
      expectedResponseModel: (json) {
        return User.fromJson(json);
      },
    );
  }

  Future<User> update(User updatedUser) async {
    return await httpService.patchRequest<User>(
      path: ApiConstants.user(updatedUser.id.toString()),
      expectedResponseModel: (json) {
        return User.fromJson(json);
      },
    );
  }

  Future<User> add(User updatedUser) async {
    return await httpService.postRequest<User>(
      path: ApiConstants.users,
      expectedResponseModel: (json) {
        return User.fromJson(json);
      },
    );
  }

  Future<void> delete(String userId) async {
    await httpService.deleteRequest(
      path: ApiConstants.user(userId),
      expectedResponseModel: (_) {},
    );
  }
}
