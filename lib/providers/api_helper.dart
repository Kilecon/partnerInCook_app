import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:partner_in_cook/exceptions/error_entity.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/services/auth_service.dart';

class DioClient {
  static DioClient? _instance;

  factory DioClient({CacheOptions? cacheOptions}) {
    _instance ??= DioClient._internal(cacheOptions: cacheOptions);
    return _instance!;
  }

  static const String _baseURL = "https://api_url/";
  late Dio _dio;
  late CacheOptions? cacheOptions;

  DioClient._internal({this.cacheOptions}) {
    BaseOptions options = BaseOptions(
      baseUrl: _baseURL,
      connectTimeout: const Duration(),
      receiveTimeout: const Duration(),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    final defaultCacheOptions = CacheOptions(
      store: MemCacheStore(),
      maxStale: const Duration(minutes: 5),
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      keyBuilder:
          ({required Uri url, Map<String, String>? headers, Object? body}) =>
              url.toString(),
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      DioCacheInterceptor(options: cacheOptions ?? defaultCacheOptions),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var authorization = _getAuthorizationHeader();
          if (authorization != null) {
            options.headers.addAll(authorization);
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          ErrorEntity errorEntity = handleDioException(e);
          handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              error: errorEntity.message,
              type: e.type,
              response: e.response,
            ),
          );
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false,
        ),
      );
    }
  }

  Map<String, dynamic>? _getAuthorizationHeader() {
    final authService = Get.find<AuthService>();
    String? accessToken = authService.apiToken.value;
    if (accessToken != null) {
      return {'Authorization': 'Bearer $accessToken'};
    }
    return null;
  }

  Future post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    var response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    return response.data;
  }

  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }

  Future delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }
}
