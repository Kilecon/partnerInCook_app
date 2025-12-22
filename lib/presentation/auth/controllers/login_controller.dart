import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/user.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/user_service.dart';
import 'package:partner_in_cook/utils/snackbar.dart';
import '../services/auth_service.dart';

class LoginController extends GetxController {
  LoginController({required this.authService});
  final AuthService authService;

  final loading = false.obs;
  final Rx<User?> currentUser = Get.find<UserService>().user;
  final hidePassword = true.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    currentUser.value ??= User();
    super.onInit();
  }

  /// Fonction de login
  void login() async {
    Get.focusScope?.unfocus(); // ferme le clavier
    if (!loginFormKey.currentState!.validate()) return;

    loginFormKey.currentState!.save();
    loading.value = true;

    final user = currentUser.value;
    if (user == null) {
      loading.value = false;
      showSnackError("Identifiants manquants");
      return;
    }

    try {
      // Appel du service d'authentification
      await authService.performAuth(user);

      // Redirection vers la page principale
      Get.offAllNamed(Routes.home);
    } catch (e) {
      // Gestion des erreurs avec Ui.ErrorSnackBar
      String message = "Une erreur est survenue";

      // Si c'est une erreur provenant de handleDioException
      if (e is Exception) message = e.toString().replaceAll("Exception: ", "");

      showSnackError(message);
    } finally {
      loading.value = false;
    }
  }
}
