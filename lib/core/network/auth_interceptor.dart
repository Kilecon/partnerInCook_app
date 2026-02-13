import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../auth/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio; // 🔹 on passe Dio ici
  bool _isRefreshing = false;
  final List<Completer<void>> _refreshQueue = [];

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. SI c'est la requête de refresh, on ne touche à rien (pas de Bearer token)
    if (options.path.contains('/Auth/refresh')) {
      return handler.next(options);
    }
    try {
      final token = await AuthService.getToken();
      if (token?.isNotEmpty == true) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {}
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || err.requestOptions.path.contains('/Auth/refresh')) {
      handler.next(err);
      return;
    }

    final completer = Completer<void>();
    _refreshQueue.add(completer);

    if (!_isRefreshing) {
      _isRefreshing = true;

      final success = await Get.find<AuthService>().refreshAuthToken();

      _isRefreshing = false;

      for (final c in _refreshQueue) {
        success ? c.complete() : c.completeError('refresh_failed');
      }
      _refreshQueue.clear();
    }

    try {
      await completer.future;

      final newToken = await AuthService.getToken();
      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

      // 🔹 ici on réutilise l'instance Dio passée dans l'interceptor
      final response = await dio.fetch(err.requestOptions);

      handler.resolve(response);
    } catch (_) {
      handler.reject(err);
    }
  }
}
