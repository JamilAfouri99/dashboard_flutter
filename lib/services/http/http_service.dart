import 'dart:async';
import 'dart:convert';
import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/models/logged_in_user.dart';
import 'package:dashboard/models/tokens.dart';
import 'package:http/http.dart' as http;
import 'package:dashboard/repositories/token.dart';
import 'package:dashboard/services/error/network_exceptions.dart';

class HttpService {
  final String baseUrl;
  final Future<TokensRepository> _localRepository;

  HttpService(this.baseUrl) : _localRepository = TokensRepository.make();

  Future<T> getRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) expectedResponseModel,
    bool withAccessToken = true,
    bool withRefreshToken = false,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final headers = await _buildHeaders(withAccessToken, withRefreshToken);

    final response = await http.get(url, headers: headers);
    return _handleResponse<T>(response, expectedResponseModel);
  }

  Future<T> postRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    required T Function(dynamic) expectedResponseModel,
    bool withAccessToken = true,
    bool withRefreshToken = false,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final headers = await _buildHeaders(withAccessToken, withRefreshToken);

    final response = await http.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse<T>(response, expectedResponseModel);
  }

  Future<T> putRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    required T Function(dynamic) expectedResponseModel,
    bool withAccessToken = true,
    bool withRefreshToken = false,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final headers = await _buildHeaders(withAccessToken, withRefreshToken);

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    return _handleResponse<T>(response, expectedResponseModel);
  }

  Future<T> deleteRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) expectedResponseModel,
    bool withAccessToken = true,
    bool withRefreshToken = false,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final headers = await _buildHeaders(withAccessToken, withRefreshToken);

    final response = await http.delete(url, headers: headers);
    return _handleResponse<T>(response, expectedResponseModel);
  }

  Uri _buildUrl(String path, Map<String, dynamic>? queryParameters) {
    final url = Uri.parse(baseUrl + path);
    return url.replace(queryParameters: queryParameters);
  }

  T _handleResponse<T>(http.Response response, T Function(dynamic) expectedResponseModel) {
    if (response.statusCode == 200) {
      final parsedResponse = jsonDecode(response.body);
      return expectedResponseModel(parsedResponse);
    } else {
      final errorMessage = NetworkExceptions.getHttpException(response);
      throw errorMessage;
    }
  }

  Future<Map<String, String>> _buildHeaders(bool withAccessToken, bool withRefreshToken) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (withAccessToken) {
      final tokenRepo = await _localRepository;
      String token;

      if (withRefreshToken) {
        RefreshToken? apiKey = await tokenRepo.getRefreshToken();
        token = apiKey!.token;
      } else {
        AccessToken? apiKey = await tokenRepo.getAccessToken();
        token = apiKey!.token;
      }

      // Check if the access token is expired, if so get it from refresh token
      final bool isExpired = _isTokenExpired(token);
      if (isExpired) token = (await _latestAccessTokenHandler(tokenRepo)).token;

      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  bool _isTokenExpired(String token) {
    final List<String> tokenParts = token.split('.');
    if (tokenParts.length != 3) {
      return true;
    }

    final String payloadBase64 = tokenParts[1];
    final String decodedPayload = String.fromCharCodes(base64Url.decode(payloadBase64));
    final Map<String, dynamic> payload = jsonDecode(decodedPayload);

    if (payload.containsKey('exp') && payload['exp'] is int) {
      final int expirationTime = payload['exp'];
      final int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return expirationTime < currentTimeInSeconds;
    }

    return true;
  }

  Future<AccessToken> _latestAccessTokenHandler(TokensRepository tokensRepository) async {
    try {
      final RefreshToken? refreshToken = await tokensRepository.getRefreshToken();
      if (refreshToken == null || _isTokenExpired(refreshToken.token)) throw 'Unauthenticated';

      await _refreshTokenHandler(tokensRepository, refreshToken);

      final AccessToken? latestAccessToken = await tokensRepository.getAccessToken();
      if (latestAccessToken == null) throw 'Unauthenticated';
      return latestAccessToken;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _refreshTokenHandler(
      TokensRepository tokensRepository, RefreshToken refreshToken) async {
    try {
      final path = _buildUrl(ApiConstants.refreshToken, null);
      final response = await http.post(
        path,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${refreshToken.token}'
        },
        body: null,
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final LoggedInUser responseBody = jsonDecode(response.body);

        await tokensRepository.setTokens(
          accessToken: responseBody.accessToken,
          refreshToken: responseBody.refreshToken,
        );
      } else {
        throw NetworkExceptions.getHttpException(response);
      }
    } catch (error) {
      rethrow;
    }
  }
}
