import 'package:get/get.dart';
import 'package:partner_in_cook/presentation/auth/controllers/login_controller.dart';
import 'package:partner_in_cook/presentation/auth/controllers/register_controller.dart';
import 'package:partner_in_cook/presentation/auth/services/login_service.dart';
import 'package:partner_in_cook/presentation/auth/services/register_service.dart';
import 'package:partner_in_cook/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => LoginService());
    Get.lazyPut(() => RegisterService());
    Get.lazyPut(
      () => LoginController(localAuthService: Get.find<LoginService>()),
    );
    Get.lazyPut(
      () => RegisterController(localAuthService: Get.find<RegisterService>()),
    );
  }
}
