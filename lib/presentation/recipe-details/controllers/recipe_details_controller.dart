import 'package:get/get.dart';
import 'package:partner_in_cook/component/recipe_details/rating_dialog.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/model/api/notation.dart';
import 'package:partner_in_cook/model/api/recipe.dart';
import 'package:partner_in_cook/model/api/user.dart';
import 'package:partner_in_cook/presentation/explorer/controllers/explorer_controller.dart';
import 'package:partner_in_cook/presentation/recipe-list-details/controllers/recipe_list_details_controller.dart';
import 'package:partner_in_cook/services/notation_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';

class RecipeDetailsController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  var recipe = Rx<Recipe?>(null);
  final recipeApi = RecipeService();
  final notationApi = NotationService();

  final dynamic arguments = Get.arguments;
  var isLoading = true.obs;

  Rx<User?> get user => _authService.user;
  bool isMine = false;

  @override
  void onInit() {
    super.onInit();
    if (arguments is String) {
      loadRecipeDetails(arguments);
    }
  }

  Future<void> loadRecipeDetails(String id, {bool turnLoad = true}) async {
    try {
      if (turnLoad) {
        isLoading.value = true;
      }
      final details = await recipeApi.getById(id);
      recipe.value = details;
      isMine = recipe.value!.author.id == _authService.user.value?.userId;
    } catch (e) {
      print("Error loading recipe details: $e");
      recipe.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (recipe.value == null) return;

    try {
      final newFavoriteStatus = !recipe.value!.isFavorite;
      await recipeApi.toggleFavorite(recipe.value!.id, newFavoriteStatus);

      recipe.value!.isFavorite = newFavoriteStatus;
      recipe.refresh();

      if (Get.isRegistered<RecipeListDetailsController>()) {
        final listCtrl = Get.find<RecipeListDetailsController>();
        if (listCtrl.isMyRecipes) {
          listCtrl.loadMyRecipes();
        } else if (listCtrl.arguments is String) {
          listCtrl.loadRecipeListDetails(listCtrl.arguments);
        }
      }

      if (Get.isRegistered<ExplorerController>()) {
        final explorerCtrl = Get.find<ExplorerController>();
        await explorerCtrl.loadData();
      }
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  Future<void> editRecipe() async {
    if (recipe.value == null) return;

    if (recipe.value!.author.id == await AuthService.getUserId()) {
      Get.toNamed('/create-recipe', arguments: recipe.value!.id);
    }
    return;
  }

  Future<void> addNotation(int rating, String notationId) async {
    try {
      isLoading.value = true;
      final currentUserId = await AuthService.getUserId();
      if (notationId.isNotEmpty) {
        await notationApi.update(
          NotationCreateRequest(
            recipeId: recipe.value!.id,
            userId: currentUserId!,
            notation: rating,
          ),
          notationId,
        );
      } else {
        await notationApi.create(
          NotationCreateRequest(
            recipeId: recipe.value!.id,
            userId: currentUserId!,
            notation: rating,
          ),
        );
      }
    } catch (e) {
      print("Error loading recipe details: $e");
      recipe.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> showAddNotationDialog() async {
    if (recipe.value == null) return;
    Notation? userNotation = await notationApi.getUserNotationForRecipe(
      recipe.value!.id,
    );
    Get.dialog(
      RatingDialog(
        initialRating: userNotation.notation,
        title: 'Noter la recette',
        description: 'Veuillez attribuer une note à cette recette',
        onConfirm: (rating) {
          addNotation(rating, userNotation.id);
          print("Notation attribuée : $rating étoiles");
        },
      ),
    );
  }
}
