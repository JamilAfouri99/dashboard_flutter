import 'dart:io';
import 'package:dashboard/services/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

BuildContext context = NavigationService.navigatorKey.currentState!.context;

abstract class NetworkExceptions {
  static Future<String> getDioException(error) async {
    if (error is Exception) {
      try {
        String networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = requestCancelled();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = requestTimeout();
              break;
            // case DioErrorType.other:
            //   networkExceptions = noInternetConnection();
            //   break;
            case DioErrorType.receiveTimeout:
              networkExceptions = sendTimeout();
              break;
            // case DioErrorType.response:
            //   switch (error.response!.statusCode) {
            //     case 400:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : badRequest();
            //       break;
            //     case 401:
            //       return 'Authentication failed.';
            //     case 403:
            //       return 'The authenticated user is not allowed to access the specified API endpoint.';
            //     case 404:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : notFound('The requested resource does not exist');
            //       break;
            //     case 405:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : notFound('Method not Allowed');
            //       break;
            //     case 409:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : conflict();
            //       break;
            //     case 408:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : requestTimeout();
            //       break;
            //     case 422:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : 'Data validation failed';
            //       break;
            //     case 500:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : internalServerError();
            //       break;
            //     case 503:
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : serviceUnavailable();
            //       break;
            //     default:
            //       var responseCode = error.response!.statusCode;
            //       networkExceptions = error.response!.data['message'] != null
            //           ? error.response!.data['message'] as String
            //           : defaultError(
            //               'Received invalid status code: $responseCode',
            //             );
            //   }
            //   break;
            case DioErrorType.sendTimeout:
              networkExceptions = sendTimeout();
              break;
            case DioErrorType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioErrorType.badResponse:
              // TODO: Handle this case.
              break;
            case DioErrorType.connectionError:
              // TODO: Handle this case.
              break;
            case DioErrorType.unknown:
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = noInternetConnection();
        } else {
          networkExceptions = unexpectedError();
        }
        networkExceptions = '';
        return networkExceptions;
      } on FormatException catch (_) {
        return formatException();
      } catch (_) {
        return unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return unableToProcess();
      } else {
        return unexpectedError();
      }
    }
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

  static String methodNotAllowed() {
    return 'Method Allowed';
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
