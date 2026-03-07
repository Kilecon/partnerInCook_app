import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
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
  var recipeLists = <RecipeList>[].obs;
  var searchController = TextEditingController();
  final dynamic arguments = Get.arguments;
  String? fullInvitationLink;
  var isLoading = true.obs;
  var isRecipeListLoading = false.obs;
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

  Future<void> loadRecipeLists() async {
    try {
      isRecipeListLoading.value = true;

      // Charger les listes owned et joined
      final owned = await recipeListApi.getOwned();
      print("Owned recipe lists loaded: ${owned.length}");

      final joined = await recipeListApi.getJoined();
      print("Joined recipe lists loaded: ${joined.length}");

      // Combiner les deux listes
      recipeLists.value = [...owned, ...joined];

      // Trier : les favoris en premier
      final sortedList = List<RecipeList>.from(recipeLists);
      sortedList.removeWhere((recipe) => recipe.isFavorite);
      recipeLists.value = sortedList;

      print("Total recipe lists: ${recipeLists.length}");
    } catch (e) {
      print("Error loading recipe lists: $e");
      recipeLists.value = [];
    } finally {
      isRecipeListLoading.value = false;
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

  void showAddPlaylist() {
    loadRecipeLists();
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // On utilise Obx pour que la liste se mette à jour si loadRecipeLists est asynchrone
          child: Obx(() {
            if (isRecipeListLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              );
            }
            return Wrap(
              children: [
                // Correction de la syntaxe de la boucle for (ajout des parenthèses)
                for (var recipeList in recipeLists)
                  ListTile(
                    leading:
                        recipeList.pictureUrl != null &&
                            recipeList.pictureUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ), // Ajustez la valeur du radius selon vos besoins
                            child: Image.network(
                              recipeList.pictureUrl!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.playlist_play),
                    title: Text(
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      recipeList.name,
                    ),
                    onTap: () {
                      // Correction de l'accès à l'ID (pas besoin de .value! si recipeList est l'élément de la boucle)
                      addRecipeToList(recipeList.id);
                      Get.back();
                    },
                  ),
                const SizedBox(height: 8, width: double.infinity),
              ],
            );
          }),
        ),
      ),
      isScrollControlled: false,
    );
  }

  void onCreateRecipeTap() {
    Get.toNamed(Routes.createRecipe);
  }

  void onCreateRecipeListTap() {
    Get.toNamed(Routes.createRecipeList);
  }
}
