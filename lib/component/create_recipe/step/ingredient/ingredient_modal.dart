import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_input.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/model/api/ingredient.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class IngredientModal extends StatefulWidget {
  const IngredientModal({super.key});

  @override
  State<IngredientModal> createState() => _IngredientModalState();
}

class _IngredientModalState extends State<IngredientModal> {
  final controller = Get.find<CreateRecipeController>();
  final searchController = TextEditingController();
  List<Ingredient> results = [];

  @override
  void initState() {
    super.initState();
    _loadInitialIngredients();
  }

  Future<void> _loadInitialIngredients() async {
    results = await controller.searchIngredients('');
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Ajouter un ingrédient',

      /// FOOTER
      footer: Obx(
        () => CustomButton(
          name: 'Ajouter',
          isDisabled:
              controller.selectedIngredient.value == null ||
              controller.quantityController.text.isEmpty,
          onClick: controller.validateIngredient,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// SEARCH
          CustomInput(
            keyboardType: TextInputType.text,
            title: 'Ingrédient',
            hintText: 'Tomate, farine...',
            controller: searchController,
            onChanged: (v) async {
              results = await controller.searchIngredients(v);
              if (mounted) setState(() {});
            },
          ),

          const SizedBox(height: 12),

          /// RESULTS
          SizedBox(
            height: 180,
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun ingrédient trouvé',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      final ing = results[i];
                      final isSelected =
                          controller.selectedIngredient.value?.id == ing.id;

                      return ListTile(
                        title: Text(ing.name),
                        subtitle: Text('Unité : ${ing.unit}'),
                        selected: isSelected,
                        selectedTileColor: Theme.of(
                          context,
                        ).primaryColor.withOpacity(0.1),
                        onTap: () {
                          controller.selectedIngredient.value = ing;
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),

          /// SELECTED INGREDIENT + QUANTITY
          Obx(() {
            final ing = controller.selectedIngredient.value;
            if (ing == null) return const SizedBox();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                  ing.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        title: 'Quantité',
                        hintText: '100',
                        controller: controller.quantityController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        ing.unit,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
