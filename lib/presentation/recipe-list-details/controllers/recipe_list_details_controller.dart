import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/component/widgets/qr_share_dialog.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/presentation/recipe-list/controllers/recipe_list_controller.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/recipe_list_service.dart';
import 'package:partner_in_cook/services/recipe_service.dart';
import 'package:partner_in_cook/services/upload_service.dart';
import 'package:partner_in_cook/component/recipe-list-detail/edit_recipe_list_dialog.dart';
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
  final UploadService _uploadService = UploadService();
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
    Get.toNamed(Routes.recipeDetails, arguments: recipeId);
  }

  Future<void> onDeleteRecipeList() async {

    isLoading.value = true;
    try {
      await recipeListApi.delete(recipeList.value!.id);
      Get.find<RecipeListController>().loadRecipeList();
      Get.back(); 
      Get.snackbar(
        'Succès',
        'Liste supprimée avec succès',
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de supprimer la liste',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void openEditDialog() {
    final currentList = recipeList.value;
    if (currentList == null) return;

    Get.dialog(
      EditRecipeListDialog(
        recipeList: currentList,
        onConfirm: (updateData, newImage) {
          // On appelle la méthode de mise à jour avec le bon type
          onUpdateRecipeList(currentList.id, updateData, newImage);
        },
      ),
    );
  }

  Future<void> onUpdateRecipeList(
    String listId,
    RecipeListUpdateRequest updateData,
    File? newImage,
  ) async {
    try {
      isLoading.value = true;

      // Si une nouvelle image est fournie, on l'upload
      if (newImage != null) {
        final picUrl = await _uploadService.uploadImage(newImage);
        updateData.pictureUrl = picUrl;
      }

      await recipeListApi.update(listId, updateData);

      // Rechargement
      await loadRecipeListDetails(listId);
      await loadRecipeLists();

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de mettre à jour',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
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

  Future<void> removeRecipeFromList(String recipeId) async {
    try {
      // Pour éviter de flasher l'écran complet, on utilise un loader d'arrière-plan ou isRecipeListLoading
      isRecipeListLoading.value = true;
      await recipeListApi.removeFromList(recipeList.value!.id, recipeId);

      // Recharger les données pour mettre à jour l'UI sans isLoading.value = true
      if (isMyRecipes) {
        final recipes = await recipeApi.getOwned();
        recipeList.value?.recipes = recipes;
      } else if (arguments is String) {
        final details = await recipeListApi.getById(arguments);
        recipeList.value = details;
      }
      await loadRecipeLists();

      // Forcer le rafraîchissement de la vue principale
      recipeList.refresh();
      recipeLists.refresh();

      // Synchroniser avec RecipeListController s'il est actif
      if (Get.isRegistered<RecipeListController>()) {
        Get.find<RecipeListController>().loadRecipeList();
      }
    } catch (e) {
      print("Error loading recipe list details: $e");
    } finally {
      isRecipeListLoading.value = false;
    }
  }

  Future<void> removeRecipe(String recipeId) async {
    try {
      // Pour éviter de flasher l'écran complet, on utilise un loader d'arrière-plan ou isRecipeListLoading
      isRecipeListLoading.value = true;
      await recipeApi.delete(recipeId);

      // Recharger les données pour mettre à jour l'UI sans isLoading.value = true
      if (isMyRecipes) {
        final recipes = await recipeApi.getOwned();
        recipeList.value?.recipes = recipes;
      } else if (arguments is String) {
        final details = await recipeListApi.getById(arguments);
        recipeList.value = details;
      }
      await loadRecipeLists();

      // Forcer le rafraîchissement de la vue principale
      recipeList.refresh();
      recipeLists.refresh();

      // Synchroniser avec RecipeListController s'il est actif
      if (Get.isRegistered<RecipeListController>()) {
        Get.find<RecipeListController>().loadRecipeList();
      }
    } catch (e) {
      print("Error loading recipe list details: $e");
    } finally {
      isRecipeListLoading.value = false;
    }
  }

  Future<void> addRecipeToList(String recipeListId, String recipeId) async {
    try {
      isRecipeListLoading.value = true;
      await recipeListApi.addToList(recipeListId, recipeId);

      // Recharger les données pour mettre à jour l'UI
      if (isMyRecipes) {
        final recipes = await recipeApi.getOwned();
        recipeList.value?.recipes = recipes;
      } else if (arguments is String) {
        final details = await recipeListApi.getById(arguments);
        if (recipeList.value?.id == recipeListId) {
          recipeList.value = details;
        }
      }
      await loadRecipeLists();

      // Forcer le rafraîchissement de la vue et BottomSheet
      recipeList.refresh();
      recipeLists.refresh();

      // Synchroniser avec RecipeListController s'il est actif
      if (Get.isRegistered<RecipeListController>()) {
        Get.find<RecipeListController>().loadRecipeList();
      }
    } catch (e) {
      print("Error loading recipe list details: $e");
    } finally {
      isRecipeListLoading.value = false;
    }
  }

  Future<void> removeRecipeFromSpecificList(
    String recipeListId,
    String recipeId,
  ) async {
    try {
      isRecipeListLoading.value = true;
      await recipeListApi.removeFromList(recipeListId, recipeId);

      // Recharger les listes pour le BottomSheet
      await loadRecipeLists();

      // Mettre à jour la vue RecipeList actuelle si on l'a modifiée
      if (recipeList.value?.id == recipeListId && arguments is String) {
        final details = await recipeListApi.getById(arguments);
        recipeList.value = details;
        recipeList.refresh();
      }

      recipeLists.refresh();

      if (Get.isRegistered<RecipeListController>()) {
        Get.find<RecipeListController>().loadRecipeList();
      }
    } catch (e) {
      print("Error loading recipe list details: $e");
    } finally {
      isRecipeListLoading.value = false;
    }
  }

  void showAddPlaylist(String recipeId) {
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
                    subtitle: Text(
                      recipeList.recipes.length > 1
                          ? '${recipeList.recipes.length} recettes'
                          : '${recipeList.recipes.length} recette',
                    ),
                    trailing:
                        recipeList.recipes.any(
                          (recipe) => recipe.id == recipeId,
                        )
                        ? const Icon(LucideIcons.check, color: Colors.green)
                        : const Icon(
                            LucideIcons.plus,
                            color: AppColors.primaryOrange,
                          ),
                    onTap: () {
                      if (recipeList.recipes.any(
                        (recipe) => recipe.id == recipeId,
                      )) {
                        removeRecipeFromSpecificList(recipeList.id, recipeId);
                      } else {
                        addRecipeToList(recipeList.id, recipeId);
                      }
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
