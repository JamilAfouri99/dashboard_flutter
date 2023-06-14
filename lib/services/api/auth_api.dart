import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/models/sign_in.dart';
import 'package:dashboard/models/sign_up.dart';
import 'package:dashboard/models/logged_in_user.dart';
import 'package:dashboard/services/http/http_service.dart';

class AuthApi {
  final httpService = HttpService(EnvConfig.instance.baseUrl);
  static const delay = 500;

  Future<LoggedInUser> accessToken() async {
    return await httpService.postRequest<LoggedInUser>(
      path: ApiConstants.accessToken,
      expectedResponseModel: (json) => LoggedInUser.fromJson(json),
    );
  }

  Future<LoggedInUser> signIn(SignIn info) async {
    return await httpService.postRequest(
      path: ApiConstants.signIn,
      body: info.toJson(),
      expectedResponseModel: (json) => LoggedInUser.fromJson(json),
      withAccessToken: false,
    );
  }

  Future<LoggedInUser> signUp(SignUp info) async {
    return await httpService.postRequest(
      path: ApiConstants.signIn,
      body: info.toJson(),
      expectedResponseModel: (json) => LoggedInUser.fromJson(json),
      withAccessToken: false,
    );
  }

  Future<void> logout() async {
    return await Future.delayed(const Duration(milliseconds: delay), () {});
  }
}
