import 'package:dio/dio.dart';

class ApiErrorHandling {
  static String handlingDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with API server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with API server';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with API server';
      case DioExceptionType.badCertificate:
        return 'Bad certificate from API server';
      case DioExceptionType.badResponse:
        return 'Wrong username or password';
      case DioExceptionType.cancel:
        return 'Request to API server was cancelled';
      case DioExceptionType.connectionError:
        return 'something went wrong, please Please check your internet connection and try again';
      case DioExceptionType.transformTimeout:
        return 'something went wrong, take too long to process the data, please try again later';
      case DioExceptionType.unknown:
        return 'something went wrong, please try again later';
    }
  }

  static String handlingErrorResponse(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized request';
      case 403:
        return 'Forbidden request';
      case 404:
        return 'Not found';

      case 500:
        return 'Internal server error';
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return 'Client error: $statusCode';
        } else if (statusCode >= 500 && statusCode < 600) {
          return 'Server error: $statusCode';
        } else {
          return 'Unexpected error: $statusCode';
        }
    }
  }
}

