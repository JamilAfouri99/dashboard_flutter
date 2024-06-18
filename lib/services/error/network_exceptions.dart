import 'dart:convert';
import 'dart:io';

import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:qcarder_api/api.dart';

BuildContext context = KeysService.navigatorKey.currentState!.context;

class NetworkExceptions {
  static String getHttpException(dynamic error) {
    print(error);
    try {
      if (error is ApiException) {
        return _handleHttpResponse(error);
      } else if (error is AssertionError) {
        return _handleAssertionError(error);
      } else if (error is TypeError) {
        return _handleTypeError(error);
      } else if (error is String) {
        return error;
      } else {
        return _handleUnexpectedError();
      }
    } on FormatException catch (_) {
      return _handleFormatException();
    } catch (_) {
      return _handleUnexpectedError();
    }
  }

  static String _handleApiException(ApiException error) {
    return jsonDecode(error.message!)['message'];
  }

  static String _handleClientException(http.ClientException error) {
    return ErrorMessages.noInternetConnection;
  }

  static String _handleSocketException(SocketException error) {
    return error.osError!.message.toString();
  }

  static String _handleAssertionError(AssertionError error) {
    return error.message.toString();
  }

  static String _handleTypeError(TypeError error) {
    return error.toString();
  }

  static String _handleHttpResponse(ApiException response) {
    switch (response.code) {
      case 400:
        return _handleBadRequest(response);
      case 401:
        return handleAuthenticationFailed();
      case 403:
        return _handleNotAllowed(response);
      case 404:
        return _handleNotFound(response);
      case 405:
        return _handleMethodNotAllowed(response);
      case 409:
        return _handleConflict(response);
      case 408:
        return ErrorMessages.requestTimeout;
      case 422:
        return _handleDataValidationFailed(response);
      case 500:
        return _handleInternalServerError(response);
      case 503:
        return ErrorMessages.serviceUnavailable;
      default:
        return _handleDefaultError(response);
    }
  }

  static String _handleBadRequest(ApiException response) {
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is List<dynamic> && message.isNotEmpty) {
        return message[0] as String;
      } else if (message is String) {
        return message;
      }
    }
    return ErrorMessages.badRequest;
  }

  static String _handleNotFound(ApiException response) {
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.resourceNotFound;
  }

  static String _handleMethodNotAllowed(ApiException response) {
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.methodNotAllowed;
  }

  static String _handleConflict(ApiException response) {
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.conflict;
  }

  static String _handleDataValidationFailed(ApiException response) {
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.dataValidationFailed;
  }

  static String _handleInternalServerError(ApiException response) {
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.internalServerError;
  }

  static String _handleDefaultError(ApiException response) {
    final responseCode = response.code;
    final message = response.message != null
        ? response.message
        : ErrorMessages.defaultError('Received invalid status code: $responseCode');
    return message ?? '';
  }

  static String _handleNotAllowed(ApiException response) {
    // context.read<AuthCubit>().localLogout(context);
    final decodedBody = jsonDecode(response.message ?? '');
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.notAllowed;
  }

  static String _handleUnexpectedError() {
    return ErrorMessages.unexpectedError;
  }

  static String _handleFormatException() {
    return ErrorMessages.formatException;
  }

  static String handleAuthenticationFailed() {
    context.read<AuthCubit>().localLogout(context);
    return ErrorMessages.authenticationFailed;
  }
}

class ErrorMessages {
  static const authenticationFailed = 'Authentication failed';
  static const resourceNotFound = 'The requested resource does not exist';
  static const methodNotAllowed = 'Method not Allowed';
  static const conflict = 'Error due to a conflict';
  static const requestTimeout = 'Connection request timeout';
  static const dataValidationFailed = 'Data validation failed';
  static const internalServerError = 'Internal Server Error';
  static const serviceUnavailable = 'Service unavailable';
  static const badRequest = 'Bad request';
  static const unexpectedError = 'Unexpected error occurred';
  static const noInternetConnection = 'No internet connection';
  static const notAllowed =
      'The authenticated user is not allowed to access the specified API endpoint.';
  static const formatException = 'Unexpected error occurred';
  static String defaultError(String error) => error;
}
