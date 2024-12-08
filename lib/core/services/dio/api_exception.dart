class ApiException implements Exception {
  ApiException({
     this.message,
     this.code,
     this.statusCode,
  });

  factory ApiException.unknown() => ApiException();

  factory ApiException.unauthorized() => ApiException(
        statusCode: 401,
      );

  factory ApiException.handshake() => ApiException(
      code: "HANDSHAKE",
      message:
      "CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate");

  factory ApiException.fromResponseError(int statusCode, dynamic error) {
    try {
      final message = error['details'];

      final code = error['code'];

      return ApiException(
        statusCode: statusCode,
        message: message,
        code: code,
      );
    } catch (e) {
      return ApiException(
        statusCode: statusCode,
        message: error?.toString(),
      );
    }
  }

  final String? message;
  final String? code;
  final int? statusCode;

  @override
  String toString() {
    return 'ApiException: $message';
  }
}
