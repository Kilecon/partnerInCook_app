import 'package:get/get.dart';

import '../presentation/splash/bindings/splash_binding.dart';
import '../presentation/splash/views/splash_view.dart';
import '../presentation/auth/bindings/auth_binding.dart';
import '../presentation/auth/views/login_view.dart';
import '../presentation/auth/views/register_view.dart';
import '../presentation/home/bindings/home_binding.dart';
import '../presentation/home/views/home_manager_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeManagerView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
