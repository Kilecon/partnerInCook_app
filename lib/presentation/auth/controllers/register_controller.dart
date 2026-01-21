import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/presentation/auth/services/register_service.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class RegisterController extends GetxController {
  RegisterController({required this.localAuthService});

  final RegisterService localAuthService;

  /// Form key
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  /// Text controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// State
  final loading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  /// Register logic
  Future<void> register() async {
    Get.focusScope?.unfocus();

    if (!registerFormKey.currentState!.validate()) return;

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      return;
    }

    if (password != confirmPassword) {
      return;
    }

    loading.value = true;

    try {
      final authRegister = AuthRegister(
        username: username,
        email: email,
        password: password,
        picUrl: "https://s3.mizury.fr/partnerincook/chef.png",
      );

      await localAuthService.performAuth(authRegister);
      Get.offAllNamed(Routes.home);
    } catch (e) {
      String message = "Une erreur est survenue";
      if (e is Exception) {
        message = e.toString().replaceAll("Exception: ", "");
      }
      print("Register error: $message");
    } finally {
      loading.value = false;
    }
  }

  /// Dispose controllers
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
