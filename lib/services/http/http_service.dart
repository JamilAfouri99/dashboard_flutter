import 'dart:developer';

import 'package:dashboard/services/error/network_exceptions.dart';
import 'package:dashboard/services/http/http_interceptor.dart';
import 'package:dio/dio.dart';

class HttpService {
  final String baseUrl;

  late final Dio client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      // connectTimeout: const Duration(seconds: 6),
      // receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    ),
  )..interceptors.add(AuthorizationInterceptor());

  HttpService(this.baseUrl);

  Future<T> getRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) expectedResponseModel,
    bool? withToken = true,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'withToken': withToken}),
      );
      log('status code is ${response.statusCode}');
      return expectedResponseModel(response.data);
    } catch (error) {
      final errorMessage = await NetworkExceptions.getDioException(error);
      throw errorMessage;
    }
  }

  Future<T> postRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    required T Function(dynamic) expectedResponseModel,
    bool? withToken = true,
    bool isHeaders = false,
  }) async {
    try {
      final response = await client.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          extra: {'withToken': withToken},
          headers: isHeaders ? {'X-API-VERSION': '3.2'} : null,
        ),
      );
      log('status code is ${response.statusCode}');
      return expectedResponseModel(response.data);
    } catch (error) {
      final errorMessage = await NetworkExceptions.getDioException(error);
      throw errorMessage;
    }
  }

  Future<T> putRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    required T Function(dynamic) expectedResponseModel,
    bool? withToken = true,
  }) async {
    try {
      final response = await client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(extra: {'withToken': withToken}),
      );
      log('status code is ${response.statusCode}');
      return expectedResponseModel(response.data);
    } catch (error) {
      final errorMessage = await NetworkExceptions.getDioException(error);
      throw errorMessage;
    }
  }

  Future<T> deleteRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) expectedResponseModel,
    bool? withToken = true,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'withToken': withToken}),
      );
      return expectedResponseModel(response.data);
    } catch (error) {
      final errorMessage = await NetworkExceptions.getDioException(error);
      throw errorMessage;
    }
  }
}
