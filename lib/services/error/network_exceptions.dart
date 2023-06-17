import 'dart:convert';
import 'dart:io';

import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/services/navigation_service.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

BuildContext context = NavigationService.navigatorKey.currentState!.context;

class NetworkExceptions {
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
    return ErrorMessages.noInternetConnection;
  }

  static String _handleSocketException(SocketException error) {
    return error.osError!.message.toString();
  }

  static String _handleHttpResponse(http.Response response) {
    switch (response.statusCode) {
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

  static String _handleBadRequest(http.Response response) {
    final decodedBody = jsonDecode(response.body);
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is List<dynamic> && message.isNotEmpty) {
        return message[0] as String;
      }
    }
    return ErrorMessages.badRequest;
  }

  static String _handleNotFound(http.Response response) {
    final decodedBody = jsonDecode(response.body);
    if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
      final message = decodedBody['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return ErrorMessages.resourceNotFound;
  }

  static String _handleMethodNotAllowed(http.Response response) {
    final message = response.body.isNotEmpty ? response.body : ErrorMessages.methodNotAllowed;
    return message;
  }

  static String _handleConflict(http.Response response) {
    final message = response.body.isNotEmpty ? response.body : ErrorMessages.conflict;
    return message;
  }

  static String _handleDataValidationFailed(http.Response response) {
    final message = response.body.isNotEmpty ? response.body : ErrorMessages.dataValidationFailed;
    return message;
  }

  static String _handleInternalServerError(http.Response response) {
    final message = response.body.isNotEmpty ? response.body : ErrorMessages.internalServerError;
    return message;
  }

  static String _handleDefaultError(http.Response response) {
    final responseCode = response.statusCode;
    final message = response.body.isNotEmpty
        ? response.body
        : ErrorMessages.defaultError('Received invalid status code: $responseCode');
    return message;
  }

  static String _handleNotAllowed(http.Response response) {
    final decodedBody = jsonDecode(response.body);
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
    context.read<AuthCubit>().logout(context);
    CustomSnackbar.show(context, ErrorMessages.authenticationFailed);
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
