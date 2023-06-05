import 'package:dashboard/models/token.dart';
import 'package:dashboard/repositories/token.dart';
import 'package:dio/dio.dart';

final _localRepository = TokenRepository.make();

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['withToken']) {
      final tokenRepo = await _localRepository;
      Token? apiKey = await tokenRepo.getToken();
      options.headers['Authorization'] = 'Bearer ${apiKey!.token}';
    }
    // continue with the request
    super.onRequest(options, handler);
  }
}
