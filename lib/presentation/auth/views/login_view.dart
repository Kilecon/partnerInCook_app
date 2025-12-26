import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/widget/logo_title.dart';
import 'package:partner_in_cook/widget/custom_input.dart';
import 'package:partner_in_cook/widget/custom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                // Logo et titre (padding uniquement en dessous dans LogoTitle)
                LogoTitle(
                  title: "Connexion",
                  subtitle: "Identifiez-vous pour récupérer\nvos couteaux",
                ),

                // Zone en dessous du logo : prend tout l'espace restant, arrondie en haut + ombre
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.yellowPrimary.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Scrollable content (inputs + forget pw)
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 30,
                            ),
                            child: Form(
                              key: controller.loginFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Email
                                  CustomInput(
                                    title: "Email",
                                    prefixIcon: Icons.email,
                                    hintText: "exemple@email.com",
                                    onSaved: (value) =>
                                        controller.email = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Le champ ne peut pas être vide";
                                      }
                                      if (!GetUtils.isEmail(value.trim())) {
                                        return "Entrez un email valide";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Password
                                  CustomInput(
                                    title: "Mot de passe",
                                    isPassword: true,
                                    prefixIcon: Icons.lock,
                                    hintText: "••••••••",
                                    onSaved: (value) =>
                                        controller.password = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Le champ ne peut pas être vide";
                                      }
                                      if (value.length < 3) {
                                        return "Au moins 3 caractères requis";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),

                                  // Forget password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.home);
                                      },
                                      child: const Text(
                                        "Mot de passe oublié ?",
                                        style: TextStyle(
                                          color: AppColors.primaryOrange,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Spacer optionnel si besoin de pousser la zone fixe vers le bas
                        const SizedBox(height: 4),

                        // Zone fixe en bas : bouton + lien d'inscription (SafeArea bottom only)
                        SafeArea(
                          top: false,
                          bottom: true,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              24,
                              8,
                              24,
                              bottomInset > 0 ? bottomInset : 24,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.8,
                                    child: CustomButton(
                                      name: "Se connecter",
                                      onClick: controller.login,
                                      isDisabled: controller.loading.value,
                                      isLoading: controller.loading.value,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Pas encore de compte ? ",
                                      style: TextStyle(
                                        color: AppColors.lightGray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.register);
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: const Text(
                                        "S'inscrire",
                                        style: TextStyle(
                                          color: AppColors.primaryOrange,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Loading overlay
            if (controller.loading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryOrange,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
