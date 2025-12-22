import 'package:get/get.dart';
import 'package:partner_in_cook/presentation/auth/bindings/auth_binding.dart';
import 'package:partner_in_cook/presentation/auth/views/login_view.dart';
import 'package:partner_in_cook/presentation/auth/views/register_view.dart';
import 'package:partner_in_cook/presentation/home/bindings/home_binding.dart';
import 'package:partner_in_cook/presentation/home/views/home_manager_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

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
  ];
}
