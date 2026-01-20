import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/model/api/user.dart';

class LoginService {
  final AuthService _authService = Get.find<AuthService>();
  final ApiClient _httpClient = ApiClient();

  /// Effectue la connexion
  Future<void> performAuth(AuthLogin loginData) async {
    try {
      final response = await _httpClient.post(
        '/Auth/login',
        data: json.encode(loginData.toJson()),
      );

      final data = response.data as Map<String, dynamic>;
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      final token = data['access_token'] as String;
      final refresh = data['refresh_token'] as String;

      final auth = AuthRes(user: user, token: token, refreshToken: refresh);

      await _authService.setAuth(auth);

    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
