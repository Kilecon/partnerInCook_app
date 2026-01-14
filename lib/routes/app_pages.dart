import 'package:get/get.dart';
import 'package:partner_in_cook/presentation/create-recipe-list/bindings/create_recipe_list_binding.dart';
import 'package:partner_in_cook/presentation/create-recipe-list/views/create_recipe_list_view.dart';

import '../presentation/create-recipe/bindings/create_recipe_binding.dart';
import '../presentation/create-recipe/views/create_recipe_view.dart';
import '../presentation/auth/bindings/auth_binding.dart';
import '../presentation/auth/views/login_view.dart';
import '../presentation/auth/views/register_view.dart';
import '../presentation/explorer/bindings/explorer_binding.dart';
import '../presentation/explorer/views/explorer_view.dart';
import '../presentation/fridge-details/bindings/fridge_details_binding.dart';
import '../presentation/fridge-details/views/fridge_details_view.dart';
import '../presentation/fridge/bindings/fridge_binding.dart';
import '../presentation/fridge/views/fridge_view.dart';
import '../presentation/home/bindings/home_binding.dart';
import '../presentation/home/views/home_manager_view.dart';
import '../presentation/pantry-details/bindings/pantry_details_binding.dart';
import '../presentation/pantry-details/views/pantry_details_view.dart';
import '../presentation/profil/bindings/profil_binding.dart';
import '../presentation/profil/views/profil_view.dart';
import '../presentation/recipe-details/bindings/recipe_details_binding.dart';
import '../presentation/recipe-details/views/recipe_details_view.dart';
import '../presentation/recipe-list-details/bindings/recipe_list_details_binding.dart';
import '../presentation/recipe-list-details/views/recipe_list_details_view.dart';
import '../presentation/recipe-list/bindings/recipe_list_binding.dart';
import '../presentation/recipe-list/views/recipe_list_view.dart';
import '../presentation/splash/bindings/splash_binding.dart';
import '../presentation/splash/views/splash_view.dart';

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
    GetPage(
      name: _Paths.profile,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.recipeDetails,
      page: () => const RecipeDetailsView(),
      binding: RecipeDetailsBinding(),
    ),
    GetPage(
      name: _Paths.explorer,
      page: () => const ExplorerView(),
      binding: ExplorerBinding(),
    ),
    GetPage(
      name: _Paths.fridge,
      page: () => const FridgeView(),
      binding: FridgeBinding(),
    ),
    GetPage(
      name: _Paths.fridgeDetails,
      page: () => const FridgeDetailsView(),
      binding: FridgeDetailsBinding(),
    ),
    GetPage(
      name: _Paths.pantryDetails,
      page: () => const PantryDetailsView(),
      binding: PantryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.recipeList,
      page: () => const RecipeListView(),
      binding: RecipeListBinding(),
    ),
    GetPage(
      name: _Paths.recipeListDetails,
      page: () => const RecipeListDetailsView(),
      binding: RecipeListDetailsBinding(),
    ),
    GetPage(
      name: _Paths.createRecipe,
      page: () => const CreateRecipeView(),
      binding: CreateRecipeBinding(),
    ),
    GetPage(
      name: _Paths.createRecipeList,
      page: () => const CreateRecipeListView(),
      binding: CreateRecipeListBinding(),
    ),
  ];
}
