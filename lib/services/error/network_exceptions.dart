import 'dart:convert';
import 'dart:io';

import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/services/navigation_service.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

BuildContext context = NavigationService.navigatorKey.currentState!.context;

abstract class NetworkExceptions {
  static String getHttpException(dynamic error) {
    try {
      if (error is http.ClientException) {
        return _handleClientException(error);
      } else if (error is SocketException) {
        return _handleSocketException(error);
      } else if (error is http.Response) {
        return _handleHttpResponse(error);
      } else {
        return _handleUnexpectedError();
      }
    } on FormatException catch (_) {
      return _handleFormatException();
    } catch (_) {
      return _handleUnexpectedError();
    }
  }

  static String _handleClientException(http.ClientException error) {
    return noInternetConnection();
  }

  static String _handleSocketException(SocketException error) {
    return error.osError!.message.toString();
  }

  static String _handleHttpResponse(http.Response response) {
    switch (response.statusCode) {
      case 400:
        return _handleBadRequest(response);
      case 401:
        const message = 'Authentication failed.';
        context.read<AuthCubit>().logout(context);
        CustomSnackbar.show(context, message);
        return message;
      case 403:
        final message = _handleNotAllowed(response);
        context.read<AuthCubit>().logout(context);
        CustomSnackbar.show(context, message);
        return message;
      case 404:
        return _handleNotFound(response);
      case 405:
        return _handleMethodNotAllowed(response);
      case 409:
        return _handleConflict(response);
      case 408:
        return requestTimeout();
      case 422:
        return _handleDataValidationFailed(response);
      case 500:
        return _handleInternalServerError(response);
      case 503:
        return serviceUnavailable();
      default:
        return _handleDefaultError(response);
    }
  }

  static String _handleBadRequest(http.Response response) {
    final decodedBody = jsonDecode(response.body);
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is List<dynamic> && message.isNotEmpty) {
        return message[0] as String;
      }
    }
    return 'Bad request';
  }

  static String _handleNotFound(http.Response response) {
    final message = response.body.isNotEmpty
        ? response.body as String
        : 'The requested resource does not exist';
    return notFound(message);
  }

  static String _handleMethodNotAllowed(http.Response response) {
    final message = response.body.isNotEmpty ? response.body as String : 'Method not Allowed';
    return notFound(message);
  }

  static String _handleConflict(http.Response response) {
    final message = response.body.isNotEmpty ? response.body as String : conflict();
    return message;
  }

  static String _handleDataValidationFailed(http.Response response) {
    final message = response.body.isNotEmpty ? response.body as String : 'Data validation failed';
    return message;
  }

  static String _handleInternalServerError(http.Response response) {
    final message = response.body.isNotEmpty ? response.body as String : internalServerError();
    return message;
  }

  static String _handleDefaultError(http.Response response) {
    final responseCode = response.statusCode;
    final message = response.body.isNotEmpty
        ? response.body as String
        : defaultError('Received invalid status code: $responseCode');
    return message;
  }

  static String _handleNotAllowed(http.Response response) {
    final decodedBody = jsonDecode(response.body);
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String) {
        return message;
      }
    }

    return 'The authenticated user is not allowed to access the specified API endpoint.';
  }

  static String _handleUnexpectedError() {
    return unexpectedError();
  }

  static String _handleFormatException() {
    return formatException();
  }

  static String notImplemented() {
    return 'Not Implemented';
  }

  static String requestCancelled() {
    return 'Request Cancelled';
  }

  static String internalServerError() {
    return 'Internal Server Error';
  }

  static String notFound(String reason) {
    return reason;
  }

  static String serviceUnavailable() {
    return 'Service unavailable';
  }

  static String badRequest() {
    return 'Bad request';
  }

  static String unexpectedError() {
    return 'Unexpected error occurred';
  }

  static String requestTimeout() {
    return 'Connection request timeout';
  }

  static String noInternetConnection() {
    return 'No internet connection';
  }

  static String conflict() {
    return 'Error due to a conflict';
  }

  static String sendTimeout() {
    return 'Send timeout in connection with API server';
  }

  static String unableToProcess() {
    return 'Unable to process the data';
  }

  static String defaultError(String error) {
    return error;
  }

  static String formatException() {
    return 'Unexpected error occurred';
  }

  static String notAcceptable() {
    return 'Not acceptable';
  }
}
