import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_search_bar.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class RecipeIngredientModal extends GetView<CreateRecipeController> {
  const RecipeIngredientModal({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    
    // Si on est en édition, on pré-remplit le nom pour la recherche
    if (controller.selectedIngredient.value != null) {
      searchController.text = controller.selectedIngredient.value!.name;
    }

    return StatefulBuilder(
      builder: (context, setStateModal) {
        final isEdit = controller.editingIngredientIndex != null;
        final selected = controller.selectedIngredient.value;

        return AppDialog(
          title: isEdit ? 'Modifier l\'ingrédient' : 'Ajouter un ingrédient',
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Annuler', style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryOrange),
                onPressed: selected != null ? () => controller.validateIngredient() : null,
                child: Text(isEdit ? 'Enregistrer' : 'Ajouter', style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                searchController: searchController,
                data: controller.ingredientsLibrary,
                hintText: 'Rechercher un ingrédient...',
                onSearchResultTap: () {
                  final found = controller.ingredientsLibrary.firstWhere(
                    (ing) => ing.name == searchController.text,
                  );
                  setStateModal(() {
                    controller.selectedIngredient.value = found;
                  });
                },
              ),
              if (selected != null) ...[
                const SizedBox(height: 20),
                Text(
                  "Quantité (${selected.unit})",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.quantityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Ex: 250',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryOrange),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}