import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/model/api/user_stats.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/user_service.dart';

class ProfilController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  var userStats = UserStats(
    createdRecipesCount: 0,
    linkedRecipelists: 0,
    favoritesRecipesCount: 0,
    idFavorite: "",
  ).obs;
  var isLoading = true.obs;
  var userstatsApi = UserStatsService();

  Rx<User?> get user => _authService.user;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadCounts();
  }

  Future<void> _loadCounts() async {
    try {
      isLoading.value = true;
      final stats = await userstatsApi.getOwned();
      userStats.value = stats;
    } catch (e) {
      print("Error loading user stats: $e");
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
}
