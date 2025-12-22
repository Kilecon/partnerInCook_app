import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AbsorbPointer(
                    absorbing: controller.loading.value,
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const FlutterLogo(size: 100),
                        const SizedBox(height: 24),
                        Text(
                          "Welcome",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(letterSpacing: 1.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Login to your account!",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 40),

                        /// Formulaire
                        Form(
                          key: controller.loginFormKey,
                          child: Column(
                            children: [
                              // Email
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  hintText: "abc@xyz.com",
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(),
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
                                    hintText: "*****",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: GestureDetector(
                                      onTap: () => controller.hidePassword.value =
                                          !controller.hidePassword.value,
                                      child: Icon(controller.hidePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    border: const OutlineInputBorder(),
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
                                      controller.currentUser.value?.password = value,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Forget password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.register); // TODO: Navigate to forgot password
                                  },
                                  child: const Text("Forget password?"),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Login button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: controller.login,
                                  child: Obx(() => controller.loading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Text("Login")),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Loading overlay
              if (controller.loading.value)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          )),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () => Get.toNamed(Routes.register),
                child: const Text("Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
