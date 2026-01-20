import 'package:get/get.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';

class ProfilController extends GetxController {
  // Utilisateur réactif
  final Rxn<User> user = Rxn<User>();

  // Stats réactives
  final RxInt recipesCount = 0.obs;
  final RxInt recipeListsCount = 0.obs;
  final RxInt favoritesCount = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Charger l'utilisateur
    final u = await AuthService.getUser();
    user.value = u;

    // Charger les compteurs (placeholder — remplacer par appels réels si dispo)
    await _loadCounts();
  }

  Future<void> _loadCounts() async {
    // Si vous avez des services pour récupérer les counts, appelez-les ici.
    // Pour l'instant, on place des valeurs par défaut.
    recipesCount.value = 12;
    recipeListsCount.value = 4;
    favoritesCount.value = 7;
  }

  void logout() {
    AuthService.logout();
  }
}
