import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/auth.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:partner_in_cook/providers/api_helper.dart';
import 'package:partner_in_cook/services/user_service.dart';
import 'auth_service.dart';

class LoginService implements AuthService {
  final Rx<User?> currentUser = Get.find<UserService>().user;
  final DioClient _httpClient = DioClient();

  @override
  Future<void> performAuth(User user) async {
    try {
      // On envoie la requête de login
      final response = await _httpClient.post(
        '/login', // remplace par ton endpoint réel
        data: json.encode(user.toJsonForSignIn()),
      );

      final auth = Auth.fromJson(response as Map<String, dynamic>);

      // Mise à jour de l'état utilisateur + token
      await Get.find<UserService>().setAuth(auth);
      currentUser.value = auth.user;
    } on DioException catch (e) {
      // Gestion centralisée des erreurs
      final error = handleDioException(e);
      throw Exception(error.message);
    }
  }
}

// Extension pour préparer les données de connexion
extension LoginUser on User {
  Map<String, dynamic> toJsonForSignIn() => {
    'email': email,
    'password': password,
  };
}
