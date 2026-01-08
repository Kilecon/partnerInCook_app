import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/providers/api_helper.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/services/auth_service.dart' as service;
import 'auth_service.dart' as local;

class RegisterService implements local.AuthService<AuthRegister> {
  final Rx<User?> currentUser = Get.find<service.AuthService>().user;
  final DioClient _httpClient = DioClient();

  @override
  Future<void> performAuth(AuthRegister registerData) async {
    try {
      // Appel de l'API d'inscription
      final response = await _httpClient.post(
        '/register', // remplace par ton endpoint réel
        data: json.encode(registerData.toJson()),
      );

      final auth = AuthRes.fromJson(response as Map<String, dynamic>);

      // Mise à jour de l'état utilisateur + token
      await Get.find<service.AuthService>().setAuth(auth);
      currentUser.value = auth.user;
    } on DioException catch (e) {
      // Gestion centralisée des erreurs
      final error = handleDioException(e);
      throw Exception(error.message);
    }
  }
}

// Extension pour préparer les données d'inscription
extension RegisterUser on User {
  Map<String, dynamic> toJsonForSignUp() => {
    'username': username,
    'email': email,
    'password': password,
    'pic_url': profilePicture,
  };
}
