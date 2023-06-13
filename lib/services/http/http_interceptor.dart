import 'package:dashboard/models/tokens.dart';
import 'package:dashboard/repositories/token.dart';
import 'package:dio/dio.dart';

final _localRepository = TokensRepository.make();

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['withAccessToken']) {
      final tokenRepo = await _localRepository;
      final String token;
      if (options.extra['withRefreshToken']) {
        RefreshToken? apiKey = await tokenRepo.getRefreshToken();
        token = apiKey!.token;
      } else {
        AccessToken? apiKey = await tokenRepo.getAccessToken();
        token = apiKey!.token;
      }
      options.headers['Authorization'] = 'Bearer $token';
    }
    // continue with the request
    super.onRequest(options, handler);
  }
}
