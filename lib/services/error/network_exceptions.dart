// import 'dart:convert';
// import 'dart:io';

// import 'package:dashboard/cubit/auth/auth_cubit.dart';
// import 'package:dashboard/services/navigation_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:qcarder_api/api.dart';

// BuildContext context = NavigationService.navigatorKey.currentState!.context;

// class NetworkExceptions {
//   static String getHttpException(dynamic error) {
//     try {
//       if (error is http.ClientException) {
//         return _handleClientException(error);
//       } else if (error is SocketException) {
//         return _handleSocketException(error);
//       } else if (error is http.Response) {
//         return _handleHttpResponse(error);
//       } else if (error is ApiException) {
//         return _handleApiException(error);
//       } else if (error is String) {
//         return error;
//       } else {
//         return _handleUnexpectedError();
//       }
//     } on FormatException catch (_) {
//       return _handleFormatException();
//     } catch (_) {
//       return _handleUnexpectedError();
//     }
//   }

//   static String _handleApiException(ApiException error) {
//     return jsonDecode(error.message!)['message'];
//   }

//   static String _handleClientException(http.ClientException error) {
//     return ErrorMessages.noInternetConnection;
//   }

//   static String _handleSocketException(SocketException error) {
//     return error.osError!.message.toString();
//   }

//   static String _handleHttpResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 400:
//         return _handleBadRequest(response);
//       case 401:
//         return handleAuthenticationFailed();
//       case 403:
//         return _handleNotAllowed(response);
//       case 404:
//         return _handleNotFound(response);
//       case 405:
//         return _handleMethodNotAllowed(response);
//       case 409:
//         return _handleConflict(response);
//       case 408:
//         return ErrorMessages.requestTimeout;
//       case 422:
//         return _handleDataValidationFailed(response);
//       case 500:
//         return _handleInternalServerError(response);
//       case 503:
//         return ErrorMessages.serviceUnavailable;
//       default:
//         return _handleDefaultError(response);
//     }
//   }

//   static String _handleBadRequest(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message is List<dynamic> && message.isNotEmpty) {
//         return message[0] as String;
//       }
//     }
//     return ErrorMessages.badRequest;
//   }

//   static String _handleNotFound(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message is String && message.isNotEmpty) {
//         return message;
//       }
//     }
//     return ErrorMessages.resourceNotFound;
//   }

//   static String _handleMethodNotAllowed(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message is String && message.isNotEmpty) {
//         return message;
//       }
//     }
//     return ErrorMessages.methodNotAllowed;
//   }

//   static String _handleConflict(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message is String && message.isNotEmpty) {
//         return message;
//       }
//     }
//     return ErrorMessages.conflict;
//   }

//   static String _handleDataValidationFailed(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message is String && message.isNotEmpty) {
//         return message;
//       }
//     }
//     return ErrorMessages.dataValidationFailed;
//   }

//   static String _handleInternalServerError(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message is String && message.isNotEmpty) {
//         return message;
//       }
//     }
//     return ErrorMessages.internalServerError;
//   }

//   static String _handleDefaultError(http.Response response) {
//     final responseCode = response.statusCode;
//     final message = response.body.isNotEmpty
//         ? response.body
//         : ErrorMessages.defaultError('Received invalid status code: $responseCode');
//     return message;
//   }

//   static String _handleNotAllowed(http.Response response) {
//     final decodedBody = jsonDecode(response.body);
//     if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
//       final message = decodedBody['message'];
//       if (message.isNotEmpty) {
//         return message;
//       }
//     }
//     return ErrorMessages.notAllowed;
//   }

//   static String _handleUnexpectedError() {
//     return ErrorMessages.unexpectedError;
//   }

//   static String _handleFormatException() {
//     return ErrorMessages.formatException;
//   }

//   static String handleAuthenticationFailed() {
//     context.read<AuthCubit>().unAuth(context, null);
//     return ErrorMessages.authenticationFailed;
//   }
// }

// class ErrorMessages {
//   static const authenticationFailed = 'Authentication failed';
//   static const resourceNotFound = 'The requested resource does not exist';
//   static const methodNotAllowed = 'Method not Allowed';
//   static const conflict = 'Error due to a conflict';
//   static const requestTimeout = 'Connection request timeout';
//   static const dataValidationFailed = 'Data validation failed';
//   static const internalServerError = 'Internal Server Error';
//   static const serviceUnavailable = 'Service unavailable';
//   static const badRequest = 'Bad request';
//   static const unexpectedError = 'Unexpected error occurred';
//   static const noInternetConnection = 'No internet connection';
//   static const notAllowed =
//       'The authenticated user is not allowed to access the specified API endpoint.';
//   static const formatException = 'Unexpected error occurred';
//   static String defaultError(String error) => error;
// }
import 'dart:convert';
import 'dart:io';

import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:qcarder_api/api.dart';

BuildContext context = NavigationService.navigatorKey.currentState!.context;

class NetworkExceptions {
  static String getHttpException(dynamic error) {
    try {
      // if (error is http.ClientException) {
      //   return _handleClientException(error);
      // } else if (error is SocketException) {
      //   return _handleSocketException(error);
      // } else if (error is http.Response) {
      //   return _handleHttpResponse(error);
      // } else
      if (error is ApiException) {
        return _handleHttpResponse(error);
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
