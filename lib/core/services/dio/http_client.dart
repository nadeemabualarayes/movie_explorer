import 'package:dio/dio.dart';
import 'package:movie_explorer/core/services/dio/api_errors.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  /// Execute post request and return data result
  /// or throw [ApiException].
  Future<dynamic> post(
    String path, {
    body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await _dio.post(path, data: body, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }

  Future<dynamic> put(String path, {body}) async {
    try {
      final response = await _dio.put(path, data: body);
      return response;
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }

  Future<dynamic> delete(String path, {body}) async {
    try {
      final response = await _dio.delete(path, data: body);
      return response;
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }

  Future<dynamic> head(String path) async {
    try {
      final response = await _dio.head(path);
      return response;
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }

  Future<dynamic> get(
    String path, {
     Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters,cancelToken: cancelToken);
      return response.data;
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }

  Future<dynamic> getResponse(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }

  Future<Response<T>> request<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      throw ApiErrorsParser.parse(e) ?? e;
    }
  }
}
