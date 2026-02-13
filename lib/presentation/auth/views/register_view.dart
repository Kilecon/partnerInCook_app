import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/component/widgets/logo_title.dart';
import 'package:partner_in_cook/component/widgets/custom_input.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const LogoTitle(
                      title: "Inscription",
                      subtitle: "Inscrivez-vous pour rejoindre les partners !",
                    ),

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
                              color: AppColors.yellowPrimary.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 30,
                          ),
                          child: Form(
                            key: controller.registerFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /// Username
                                CustomInput(
                                  controller: controller.usernameController,
                                  keyboardType: TextInputType.text,
                                  title: "Nom d'utilisateur",
                                  prefixIcon: Icons.person,
                                  hintText: "Votre pseudo",
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
                                const SizedBox(height: 16),

                                /// Email
                                CustomInput(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  title: "Email",
                                  prefixIcon: Icons.email,
                                  hintText: "exemple@email.com",
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

                                /// Password
                                Obx(
                                  () => CustomInput(
                                    controller: controller.passwordController,
                                    keyboardType: TextInputType.text,
                                    title: "Mot de passe",
                                    isPassword: controller.hidePassword.value,
                                    prefixIcon: Icons.lock,
                                    hintText: "••••••••",
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
                                ),
                                const SizedBox(height: 16),

                                /// Confirm password
                                Obx(
                                  () => CustomInput(
                                    controller:
                                        controller.confirmPasswordController,
                                    keyboardType: TextInputType.text,
                                    title: "Confirmer le mot de passe",
                                    isPassword:
                                        controller.hideConfirmPassword.value,
                                    prefixIcon: Icons.lock,
                                    hintText: "••••••••",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Le champ ne peut pas être vide";
                                      }
                                      if (value !=
                                          controller.passwordController.text) {
                                        return "Les mots de passe ne correspondent pas";
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                const Spacer(),

                                /// Bottom buttons avec SafeArea
                                SafeArea(
                                  top: false,
                                  bottom: true,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: bottomInset > 0 ? 16 : 0,
                                      top: 16,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(
                                          () => FractionallySizedBox(
                                            widthFactor: 0.8,
                                            child: CustomButton(
                                              name: "S'inscrire",
                                              onClick: controller.register,
                                              isDisabled:
                                                  controller.loading.value,
                                              isLoading:
                                                  controller.loading.value,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Déjà un compte ? ",
                                              style: TextStyle(
                                                color: AppColors.lightGray,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Get.offAllNamed(Routes.login),
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: Size.zero,
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              child: const Text(
                                                "Se connecter",
                                                style: TextStyle(
                                                  color:
                                                      AppColors.primaryOrange,
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Loading overlay
          Obx(
            () => controller.loading.value
                ? Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
