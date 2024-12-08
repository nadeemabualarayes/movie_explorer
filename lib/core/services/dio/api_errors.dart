import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_exception.dart';

class ApiErrorsParser {
  static Exception? parse(errors) {
    if (errors == null) {
      return null;
    }

    if (isNoInternetConnection(errors)) {
      return NoInternetConnectionException();
    }
    return _buildApiException(errors);
  }

  static bool isNoInternetConnection(errors) {
    if (errors == null || errors is! DioError) {
      return false;
    }

    final dioError = errors;
    if (dioError.error != null && dioError.error is SocketException) {
      SocketException socketException = dioError.error as SocketException;
      return (socketException.osError?.errorCode == 7);
    }
    return false;
  }

  static ApiException? _buildApiException(errors) {
    if (errors == null) {
      return null;
    }

    try {
      if (errors is DioError) {
        final dioError = errors;

        if (dioError.response != null) {
          final response = dioError.response;

          if (response?.statusCode == 401 &&
              response?.data is String &&
              response?.data.isEmpty) {
            return ApiException.unauthorized();
          }

          if (response?.statusCode == 401 && response?.data['errors'] == null) {
            return ApiException.unauthorized();
          }
          var error = '';
          if (response?.data['errors'] == null &&
              response?.data['error'] != null) {
            error = response?.data['error'];
          }

          if (response?.data['errors'] != null) {
            try {
              error = response?.data['errors'][0];
            } catch (e) {}
          }
          return ApiException.fromResponseError(response!.statusCode!, error);
        } else {
          var error = dioError.error;

          if (error is HandshakeException) {
            return ApiException.handshake();
          }
        }
      } else {
        return ApiException.unknown();
      }
    } catch (e) {
      return ApiException(
        message: e.toString(),
      );
    }

    return ApiException.unknown();
  }
}

class NoInternetConnectionException implements Exception {}
