import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_search_bar.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';
// recipe_utensil_modal.dart
class RecipeUtensilModal extends GetView<CreateRecipeController> {
  const RecipeUtensilModal({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    
    return StatefulBuilder(
      builder: (context, setStateModal) {
        final selected = controller.selectedUtensil.value;

        return AppDialog(
          title: 'Ajouter un ustensile',
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
                // On n'active le bouton que si un ustensile est sélectionné
                onPressed: selected != null ? () => controller.validateUtensil() : null,
                child: const Text('Ajouter', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Quel ustensile faut-il ?"),
              const SizedBox(height: 12),
              CustomSearchBar(
                searchController: searchController,
                data: controller.utensilsLibrary,
                hintText: 'Rechercher (ex: Poêle, Mixeur...)',
                onSearchResultTap: () {
                  // On trouve l'objet complet dans la bibliothèque
                  final found = controller.utensilsLibrary.firstWhere(
                    (u) => u.name == searchController.text,
                  );
                  setStateModal(() {
                    controller.selectedUtensil.value = found;
                  });
                },
              ),
              if (selected != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.primaryOrange),
                      const SizedBox(width: 10),
                      Text(
                        selected.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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