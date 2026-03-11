import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_search_bar.dart';
import 'package:partner_in_cook/model/api/fridge.dart';
import 'package:partner_in_cook/model/api/ingredient.dart';
import 'package:partner_in_cook/services/fridge_service.dart';
import 'package:partner_in_cook/services/ingredient_service.dart';

class FridgeDetailsController extends GetxController {
  var fridge = Rxn<Fridge>();
  var ingredientsLibrary = <Ingredient>[].obs;
  var isLoading = true.obs;

  final fridgeApi = FridgeService();
  final ingredientApi = IngredientService();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        fridgeApi.getOwned(),
        ingredientApi.getAll(),
      ]);

      fridge.value = results[0] as Fridge;
      ingredientsLibrary.value = results[1] as List<Ingredient>;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOrUpdateIngredient(
    String ingredientId,
    double quantity,
  ) async {
    if (fridge.value == null) return;

    try {
      // On prépare la liste avec les noms de clés attendus par l'API (snake_case)
      final List<Map<String, dynamic>> ingredientsDto =
          List<Map<String, dynamic>>.from(
            fridge.value!.ingredients.map(
              (i) => <String, dynamic>{
                'quantity': i.quantity.toDouble(),
                'fridge_id':
                    fridge.value!.id, // Ajout du fridge_id comme dans Swagger
                'ingredient_id':
                    i.ingredientId, // "ingredient_id" au lieu de "ingredientId"
              },
            ),
          );

      int index = ingredientsDto.indexWhere(
        (i) => i['ingredient_id'] == ingredientId,
      );

      if (index != -1) {
        double currentQty = (ingredientsDto[index]['quantity'] as num)
            .toDouble();
        ingredientsDto[index]['quantity'] = currentQty + quantity;
      } else {
        ingredientsDto.add(<String, dynamic>{
          'quantity': quantity,
          'fridge_id': fridge.value!.id,
          'ingredient_id': ingredientId,
        });
      }

      final Map<String, dynamic> data = {'ingredients': ingredientsDto};

      // Log pour vérifier avant l'envoi
      print("🔵 [DEBUG] Sending to API: $data");

      final updatedFridge = await fridgeApi.patch(fridge.value!.id, data);

      fridge.value = updatedFridge;
      Get.back();
      Get.snackbar("Succès", "Frigo mis à jour");
    } catch (e) {
      print("🔴 [ERROR] $e");
      Get.snackbar("Erreur", "Impossible d'ajouter l'ingrédient");
    }
  }

  // --- LOGIQUE DE SUPPRESSION ---
  Future<void> deleteIngredient(String ingredientId) async {
    if (fridge.value == null) return;

    try {
      // On garde tous les ingrédients SAUF celui qu'on veut supprimer
      final List<Map<String, dynamic>> ingredientsDto = fridge
          .value!
          .ingredients
          .where((i) => i.ingredientId != ingredientId)
          .map(
            (i) => <String, dynamic>{
              'quantity': i.quantity.toDouble(),
              'fridge_id': fridge.value!.id,
              'ingredient_id': i.ingredientId,
            },
          )
          .toList();

      final updatedFridge = await fridgeApi.patch(fridge.value!.id, {
        'ingredients': ingredientsDto,
      });

      fridge.value = updatedFridge;
      Get.snackbar("Supprimé", "L'ingrédient a été retiré");
    } catch (e) {
      Get.snackbar("Erreur", "Impossible de supprimer");
    }
  }

  // --- LOGIQUE DE MODIFICATION (Quantité) ---
  Future<void> updateIngredientQuantity(
    String ingredientId,
    double newQuantity,
  ) async {
    if (fridge.value == null) return;

    try {
      final List<Map<String, dynamic>> ingredientsDto = fridge
          .value!
          .ingredients
          .map(
            (i) => <String, dynamic>{
              'quantity': i.ingredientId == ingredientId
                  ? newQuantity
                  : i.quantity.toDouble(),
              'fridge_id': fridge.value!.id,
              'ingredient_id': i.ingredientId,
            },
          )
          .toList();

      final updatedFridge = await fridgeApi.patch(fridge.value!.id, {
        'ingredients': ingredientsDto,
      });

      fridge.value = updatedFridge;
      // On ne fait pas de Get.back() ici car on peut l'appeler depuis une petite modal d'édition rapide
    } catch (e) {
      Get.snackbar("Erreur", "Modification impossible");
    }
  }

  // --- LA MODAL DANS LE CONTROLLER ---
  void showAddIngredientDialog(BuildContext context) {
    final searchController = TextEditingController();
    final qtyController = TextEditingController(text: "1");
    Ingredient? selectedIngredient;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return AppDialog(
              title: 'Ajouter au frigo',
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text(
                      'Annuler',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryOrange,
                    ),
                    onPressed: () {
                      if (selectedIngredient != null) {
                        final qty = double.tryParse(qtyController.text) ?? 1.0;
                        addOrUpdateIngredient(selectedIngredient!.id, qty);
                      }
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quel ingrédient souhaitez-vous ajouter ?"),
                  const SizedBox(height: 12),
                  CustomSearchBar(
                    searchController: searchController,
                    data:
                        ingredientsLibrary, // Accès direct à la variable de la classe
                    hintText: 'Rechercher un ingrédient...',
                    onSearchResultTap: () {
                      final found = ingredientsLibrary.firstWhere(
                        (ing) => ing.name == searchController.text,
                      );
                      setStateModal(() {
                        selectedIngredient = found;
                      });
                    },
                  ),
                  if (selectedIngredient != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      "Quantité (${selectedIngredient!.unit})",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: qtyController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Ex: 500',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showEditQuantityDialog(BuildContext context, dynamic ingredient) {
    final qtyController = TextEditingController(
      text: ingredient.quantity.toString(),
    );

    showDialog(
      context: context,
      builder: (ctx) => AppDialog(
        title: 'Modifier la quantité',
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                'Annuler',
                style: TextStyle(color: AppColors.black),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final newQty = double.tryParse(qtyController.text) ?? 0.0;
                updateIngredientQuantity(ingredient.ingredientId, newQty);
                Get.back();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Combien de ${ingredient.ingredient!.name} avez-vous ?",
              style: const TextStyle(fontSize: 14, color: AppColors.lightGray),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: qtyController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              autofocus: true,
              decoration: InputDecoration(
                suffixText: ingredient.ingredient!.unit,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primaryOrange,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
