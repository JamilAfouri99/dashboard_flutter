import 'package:qcarder/helpers/index.dart';
import 'package:qcarder/helpers/token_validator.dart';
import 'package:qcarder/models/tokens.dart';
import 'package:qcarder/repositories/token.dart';
import 'package:qcarder/services/error/network_exceptions.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:qcarder_api/api.dart';

class RemoteService {
  final makeRepository = TokensRepository.make();
  TokensRepository? tokensRepo;

  final ApiClient apiClient = ClientService.apiClient;
  late AuthApi authApi;

  RemoteService() {
    authApi = AuthApi(apiClient);
  }

  Future<Result<T>> asyncTryCatch<T>(
    Future<T> Function() action, {
    bool isAccessToken = true,
    bool isRefreshToken = false,
  }) async {
    tokensRepo = await makeRepository;
    try {
      if (isAccessToken || isRefreshToken) {
        final res = await _tokenHandler(isAccessToken, isRefreshToken);
        if (res.isError) throw res.error;
      }

      final result = await action();
      return Result.ok(result);
    } catch (e) {
      final error = NetworkExceptions.getHttpException(e);
      return Result.err(error);
    }
  }

  Future<Result<void>> _tokenHandler(bool withAccessToken, bool withRefreshToken) async {
    String? token;

    if (withRefreshToken) {
      RefreshToken? apiKey = await tokensRepo!.getRefreshToken();
      token = apiKey?.token;
    } else {
      AccessToken? apiKey = await tokensRepo!.getAccessToken();
      token = apiKey?.token;
    }

    // Check if the access token is expired, if so get it from refresh token
    if (token == null || token.isEmpty) {
      return Result.err(ErrorMessages.authenticationFailed);
    } else {
      final bool isExpired = isTokenExpired(token);
      if (isExpired) {
        final res = await _latestAccessTokenHandler(tokensRepo!);
        if (res.isError || res.value == null) return Result.err(res.error);
        token = res.value!.token;
      }
    }
    apiClient.addDefaultHeader('Authorization', 'Bearer $token');
    return Result.ok(null);
  }

  Future<Result<AccessToken>> _latestAccessTokenHandler(TokensRepository tokensRepository) async {
    try {
      final RefreshToken? refreshToken = await tokensRepository.getRefreshToken();
      if (refreshToken == null || isTokenExpired(refreshToken.token)) {
        throw NetworkExceptions.handleAuthenticationFailed();
      }

      final res = await _refreshTokenHandler(tokensRepository, refreshToken);
      if (res.isError) throw res.error;

      final AccessToken? latestAccessToken = await tokensRepository.getAccessToken();
      if (latestAccessToken == null) {
        throw NetworkExceptions.handleAuthenticationFailed();
      }
      return Result.ok(latestAccessToken);
    } catch (e) {
      final error = NetworkExceptions.getHttpException(e);
      return Result.err(error);
    }
  }

  Future<Result<void>> _refreshTokenHandler(
      TokensRepository tokensRepository, RefreshToken refreshToken) async {
    try {
      apiClient.addDefaultHeader('Authorization', 'Bearer ${refreshToken.token}');

      final AuthUser? response = await authApi.signinUsingRefreshToken();
      if (response == null) throw NetworkExceptions.handleAuthenticationFailed();
      await tokensRepository.setTokens(
        accessToken: AccessToken(response.accessToken),
        refreshToken: RefreshToken(response.refreshToken),
      );
      return Result.ok(null);
    } catch (e) {
      final error = NetworkExceptions.getHttpException(e);
      return Result.err(error);
    }
  }
}
