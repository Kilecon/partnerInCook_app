import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_version.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final version = versionNumber;
  Rx<String?> get refreshToken => _authService.refreshToken;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _authService.init();
    // Si on a un refresh token, on tente de rafraîchir
    if (_authService.refreshToken.value != null) {
      final success = await _authService.refreshAuthToken();
      if (success) {
        print('Token rafraîchi avec succès');
        print('Redirection vers l\'app principale');
        // Token rafraîchi avec succès → redirection vers l'app
        Get.offAllNamed(Routes.home);
      } else {
        print('Échec du rafraîchissement du token');
        print('Redirection vers login');
        // Échec du refresh → redirection vers login
        Get.offAllNamed(Routes.login);
      }
    } else {
      // Pas de refresh token → redirection vers login
      Get.offAllNamed(Routes.login);
    }
  }
}
