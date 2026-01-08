import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/utils/snackbar.dart';
import '../services/auth_service.dart' as local;

class RegisterController extends GetxController {
  RegisterController({required this.localAuthService});

  final local.AuthService<AuthRegister> localAuthService;

  String? username;
  String? email;
  String? password;

  final loading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void register() async {
    Get.focusScope?.unfocus();

    if (!registerFormKey.currentState!.validate()) return;
    registerFormKey.currentState!.save();

    if (username == null ||
        email == null ||
        password == null) {
      showSnackError("Informations manquantes");
      return;
    }

    loading.value = true;

    try {
      final authRegister = AuthRegister(
        email: email!.trim(),
        password: password!,
        username: username!.trim(),
        picUrl:
            "https://s3.mizury.fr/partnerincook/chef.png",
      );

      await localAuthService.performAuth(authRegister);
      Get.offAllNamed(Routes.home);
    } catch (e) {
      showSnackError(
        e.toString().replaceAll("Exception: ", ""),
      );
    } finally {
      loading.value = false;
    }
  }
}
