import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_input.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/model/api/utensil.dart';
import 'package:partner_in_cook/presentation/create-recipe/controllers/create_recipe_controller.dart';

class UtensilModal extends StatefulWidget {
  const UtensilModal({super.key});

  @override
  State<UtensilModal> createState() => _UtensilModalState();
}

class _UtensilModalState extends State<UtensilModal> {
  final controller = Get.find<CreateRecipeController>();
  final searchController = TextEditingController();
  List<Utensil> results = [];

  @override
  void initState() {
    super.initState();
    _loadInitialUtensils();
  }

  Future<void> _loadInitialUtensils() async {
    results = await controller.searchUtensils('');
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
      title: 'Ajouter un ustensile',

      /// FOOTER
       footer: Obx(
        () => CustomButton(
          name: 'Ajouter',
          isDisabled:
              controller.selectedUtensil.value == null,
          onClick: controller.validateUtensil,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// SEARCH
          CustomInput(
            keyboardType: TextInputType.text,
            title: 'Ustensile',
            hintText: 'Spatule, fouet...',
            controller: searchController,
            onChanged: (v) async {
              results = await controller.searchUtensils(v);
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
                      'Aucun ustensile trouvé',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      final ut = results[i];
                      final isSelected =
                          controller.selectedUtensil.value?.id == ut.id;

                      return ListTile(
                        title: Text(ut.name),
                        selected: isSelected,
                        selectedTileColor: Theme.of(
                          context,
                        ).primaryColor.withOpacity(0.1),
                        onTap: () {
                          controller.selectedUtensil.value = ut;
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),

          /// SELECTED UTENSIL (simple affichage, pas de quantité)
          Obx(() {
            final ut = controller.selectedUtensil.value;
            if (ut == null) return const SizedBox();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                  ut.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
              ],
            );
          }),
        ],
      ),
    );
  }
}
