import 'dart:async';
import 'dart:convert';

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

  Future<Map<String, String>> _buildHeaders(bool withAccessToken, bool withRefreshToken) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (withAccessToken) {
      final tokenRepo = await _localRepository;
      final String token;
      if (withRefreshToken) {
        RefreshToken? apiKey = await tokenRepo.getRefreshToken();
        token = apiKey!.token;
      } else {
        AccessToken? apiKey = await tokenRepo.getAccessToken();
        token = apiKey!.token;
      }
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
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
}
