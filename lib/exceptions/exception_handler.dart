import 'package:dio/dio.dart';
import 'package:partner_in_cook/exceptions/exception_message.dart';
import 'error_entity.dart';

ErrorEntity handleDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ErrorEntity(
        message: ExceptionMessages.timeout,
      );

    case DioExceptionType.connectionError:
      return ErrorEntity(
        message: ExceptionMessages.noInternet,
      );

    case DioExceptionType.badResponse:
      final code = error.response?.statusCode;

      if (code == 401) {
        return ErrorEntity(code: 401, message: ExceptionMessages.unauthorized);
      }
      if (code == 404) {
        return ErrorEntity(code: 404, message: ExceptionMessages.notFound);
      }
      if (code != null && code >= 500) {
        return ErrorEntity(code: code, message: ExceptionMessages.serverError);
      }

      return ErrorEntity(
        code: code,
        message: error.response?.statusMessage ?? ExceptionMessages.unexpected,
      );

    default:
      return ErrorEntity(
        message: ExceptionMessages.unexpected,
      );
  }
}
