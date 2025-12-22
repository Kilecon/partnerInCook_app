import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/auth.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:partner_in_cook/providers/api_helper.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/services/user_service.dart';
import 'auth_service.dart';

class RegisterService implements AuthService {
  final Rx<User?> currentUser = Get.find<UserService>().user;
  final DioClient _httpClient = DioClient();

  @override
  Future<void> performAuth(User user) async {
    try {
      // Appel de l'API d'inscription
      final response = await _httpClient.post(
        '/register', // remplace par ton endpoint réel
        data: json.encode(user.toJsonForSignUp()),
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

// Extension pour préparer les données d'inscription
extension RegisterUser on User {
  Map<String, dynamic> toJsonForSignUp() => {
        'username': username,
        'email': email,
        'password': password,
        'pic_url': profilePicture,
      };
}
