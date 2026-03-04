import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/component/widgets/qr_share_dialog.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';
import 'package:partner_in_cook/utils/qr_code.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class RecipeListDetailsController extends GetxController {
  var recipeList = Rx<RecipeList?>(null);
  var searchController = TextEditingController();
  final dynamic arguments = Get.arguments;
  String? fullInvitationLink;
  var isLoading = true.obs;
  final recipeListApi = RecipeListService();
  final recipeApi = RecipeService();
  QrImage? qrImage;

  // 1. Ajouter une variable pour stocker l'ID de l'utilisateur courant
  String? currentUserId;

  bool get isMyRecipes => arguments == 'my_recipes' ? true : false;

  // 2. Transformer le Future<bool> en bool
  bool get isMyPlaylist => recipeList.value?.author.id == currentUserId;

  @override
  void onInit() {
    super.onInit();
    if (isMyRecipes) {
      loadMyRecipes();
    } else if (arguments is String) {
      loadRecipeListDetails(arguments);
      fullInvitationLink = 'partnerincook://recipe-list/join/$arguments';
      qrImage = generateQrCode(fullInvitationLink!);
    }
  }

  Future<void> loadRecipeListDetails(String id) async {
    try {
      isLoading.value = true;
      // 3. Charger l'ID de l'utilisateur
      currentUserId = await AuthService.getUserId();

      final details = await recipeListApi.getById(id);
      recipeList.value = details;
    } catch (e) {
      print("Error loading recipe list details: $e");
      recipeList.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMyRecipes() async {
    final connectedUser = await AuthService.getUser();
    // 4. Stocker l'ID de l'utilisateur
    currentUserId = connectedUser?.userId;

    try {
      isLoading.value = true;
      final recipes = await recipeApi.getOwned();
      // Créer une RecipeList pour "Mes Recettes"
      recipeList.value = RecipeList(
        isFavorite: false,
        id: 'my_recipes',
        members: [],
        visibilityState: VisibilityStateEnum.privateState,
        name: 'Mes Recettes',
        recipes: recipes,
        pictureUrl: null,
        author: LightUser(
          id: connectedUser!.userId!,
          username: connectedUser.username!,
          profilePictureUrl: connectedUser.profilePicture,
        ),
      );
    } catch (e) {
      print("Error loading my recipes: $e");
      recipeList.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void onRecipeTap(String recipeId) {
    // Logique pour gérer le tap sur une recette
    Get.toNamed(Routes.recipeDetails, arguments: recipeId);
  }

  void onDeleteRecipeList() {
    // Logique pour supprimer la liste de recettes
    Get.defaultDialog(
      title: 'Supprimer la liste',
      middleText:
          'Êtes-vous sûr de vouloir supprimer cette liste de recettes ?',
      textConfirm: 'Supprimer',
      textCancel: 'Annuler',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        Get.back(); // Retour à la page précédente
        Get.snackbar(
          'Succès',
          'Liste supprimée avec succès',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void onEditRecipeList() {
    // Logique pour modifier la liste de recettes
    Get.snackbar(
      'Info',
      'Édition de la liste à implémenter',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onShareTap() {
    if (qrImage == null) return;

    Get.dialog(
      QrShareDialog(
        title: 'Partager ma liste de recettes',
        description:
            'Invitez vos amis en scannant ce code ou en copiant le lien ci-dessous.',
        data: fullInvitationLink!,
      ),
    );
  }

  Future<void> removeRecipeFromList(String id) async {
    try {
      isLoading.value = true;

      final details = await recipeListApi.getById(id);
      recipeList.value = details;
    } catch (e) {
      print("Error loading recipe list details: $e");
      recipeList.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addRecipeToList(String id) async {
    try {
      isLoading.value = true;

      final details = await recipeListApi.getById(id);
      recipeList.value = details;
    } catch (e) {
      print("Error loading recipe list details: $e");
      recipeList.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
