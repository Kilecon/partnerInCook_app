import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_version.dart';
import 'package:partner_in_cook/model/api/auth.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';

class SplashController extends GetxController {
  final version = versionNumber;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Initialise le service et crée un utilisateur de test si aucun n'est présent
    final authService = Get.put(AuthService());
    await authService.init();

    if (!authService.isAuth) {
      final dummyUser = User(
        userId: 'test-id',
        username: 'Test User',
        email: 'test@example.com',
        profilePicture: 'https://s3.mizury.fr/partnerincook/chef.png',
      );
      final dummyAuth = AuthRes(user: dummyUser, token: 'dummy-token', refreshToken: 'dummy-refresh-token');
      await authService.setAuth(dummyAuth);
    }

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/login');
    });
  }
}
