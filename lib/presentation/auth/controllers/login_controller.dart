import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/presentation/auth/services/login_service.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/utils/snackbar.dart';

class LoginController extends GetxController {
  LoginController({required this.localAuthService});
  final LoginService localAuthService;

  // Champs alimentés par les inputs
  String? email;
  String? password;

  final loading = false.obs;
  final hidePassword = true.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Fonction de login
  void login() async {
    Get.focusScope?.unfocus();
    if (!loginFormKey.currentState!.validate()) return;

    loginFormKey.currentState!.save();
    loading.value = true;

    if ((email == null || email!.isEmpty) ||
        (password == null || password!.isEmpty)) {
      loading.value = false;
      showSnackError("Identifiants manquants");
      return;
    }

    try {
      final authLogin = AuthLogin(email: email!.trim(), password: password!);

      await localAuthService.performAuth(authLogin);

      Get.offAllNamed(Routes.home);
    } catch (e) {
      String message = "Une erreur est survenue";
      if (e is Exception) message = e.toString().replaceAll("Exception: ", "");
      showSnackError(message);
    } finally {
      loading.value = false;
    }
  }
}
