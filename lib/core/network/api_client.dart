import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:partner_in_cook/core/network/auth_interceptor.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://partnerincook-api.mizury.fr/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // Auth + Refresh
    dio.interceptors.add(AuthInterceptor(dio));

    // Cache
    dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
        maxStale: const Duration(minutes: 5),
        policy: CachePolicy.forceCache,
        priority: CachePriority.high,
        keyBuilder: ({required Uri url, Map<String, String>? headers, Object? body}) => url.toString(),
      ),
    ));

    // Error Mapping
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        final error = handleDioException(e);
        handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            error: ApiException(error.message, code: error.code),
            type: e.type,
            response: e.response,
          ),
        );
      },
    ));

    // Logging (debug)
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false,
      ));
    }
  }

  // === Méthodes génériques ===
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.get(path, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw e.error ?? e; // ApiException sera dans e.error
    }
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.post(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.put(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.delete(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await dio.patch(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }
}
