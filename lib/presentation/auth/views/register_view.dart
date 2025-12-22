import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(
        () => Stack(
          children: [
            AbsorbPointer(
              absorbing: controller.loading.value,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    /// Formulaire
                    Form(
                      key: controller.registerFormKey,
                      child: Column(
                        children: [
                          // Username
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field cannot be empty";
                              }
                              if (value.length < 3) {
                                return "Enter at least 3 characters";
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                controller.currentUser.value?.username = value,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field cannot be empty";
                              }
                              if (!GetUtils.isEmail(value.trim())) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                controller.currentUser.value?.email = value,
                          ),
                          const SizedBox(height: 16),

                          // Password
                          Obx(
                            () => TextFormField(
                              obscureText: controller.hidePassword.value,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () => controller.hidePassword.value =
                                      !controller.hidePassword.value,
                                  child: Icon(
                                    controller.hidePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field cannot be empty";
                                }
                                if (value.length < 3) {
                                  return "Enter at least 3 characters";
                                }
                                return null;
                              },
                              onSaved: (value) =>
                                  controller.currentUser.value?.password =
                                      value,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Confirm password
                          Obx(
                            () => TextFormField(
                              obscureText: controller.hideConfirmPassword.value,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      controller.hideConfirmPassword.value =
                                          !controller.hideConfirmPassword.value,
                                  child: Icon(
                                    controller.hideConfirmPassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  value !=
                                      controller.currentUser.value?.password
                                  ? "Passwords do not match"
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Terms & Conditions
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller
                                      .isTermsAndConditionsAccepted
                                      .value,
                                  onChanged: (val) =>
                                      controller
                                              .isTermsAndConditionsAccepted
                                              .value =
                                          val!,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Sign up button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.register,
                              child: Obx(
                                () => controller.loading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text("Sign Up"),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Navigate to Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account? "),
                              TextButton(
                                onPressed: () => Get.offAllNamed(Routes.login),
                                child: const Text("Sign in"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Loading overlay
            if (controller.loading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "Let's get started",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Create your account",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
