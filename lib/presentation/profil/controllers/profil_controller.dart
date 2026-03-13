import 'package:get/get.dart';
import 'package:partner_in_cook/component/profile/update_dialog.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/model/api/user_stats.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/upload_service.dart';
import 'package:partner_in_cook/services/user_service.dart';

class ProfilController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final UploadService _uploadService = UploadService();
  var userStats = UserStats(
    createdRecipesCount: 0,
    linkedRecipelists: 0,
    favoritesRecipesCount: 0,
    idFavorite: "",
  ).obs;
  var isLoading = true.obs;
  var userApi = UserService();

  Rx<User?> get user => _authService.user;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadCounts();
  }

  Future<void> _loadCounts() async {
    try {
      isLoading.value = true;
      final stats = await userApi.getOwned();
      userStats.value = stats;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les statistiques du profil: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onMyRecipesTap() {
    Get.toNamed(Routes.recipeListDetails, arguments: 'my_recipes');
  }

  void onRecipeListTap() {
    Get.toNamed(
      Routes.recipeListDetails,
      arguments: userStats.value.idFavorite,
    );
  }

  void onFridgeTap() {
    Get.toNamed(Routes.fridgeDetails);
  }

  void logout() {
    AuthService.logout();
  }

  void openEditProfile() {
    Get.dialog(
      EditProfileDialog(
        initialUsername: user.value?.username ?? '',
        initialEmail: user.value?.email ?? '',
        initialPicUrl: user.value?.profilePicture ?? '',
        onConfirm: (username, email, newImage) async {
          String? picUrl = user.value?.profilePicture;

          if (newImage != null) {
            picUrl = await _uploadService.uploadImage(newImage);
          }

          // Appelle ton service API ici
          await userApi.update(
            UserUpdateRequest(
              username: username,
              email: email,
              profilePicture: picUrl,
            )
          );

          // Mettre à jour les propriétés locales
          user.value?.username = username;
          user.value?.email = email;
          user.value?.profilePicture = picUrl;

          // Rafraîchir l'UI après l'update
          await AuthService.updateUser(user.value!);
          user.refresh(); // Force la mise à jour des Obx
        },
      ),
    );
  }
}
