import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_explorer/config/config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio createDio(
    String baseUrl,
  ) {
    Dio dio = Dio(BaseOptions(
        contentType: "application/json",
        baseUrl: baseUrl,
        headers: {'Authorization': 'Bearer ${kAppConfig.apiKey()}'},
        receiveTimeout: const Duration(seconds: 20)));

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        compact: false,
        responseHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
      ));
    }

    return dio;
  }
}
