import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/fridge/pantry_card.dart';
import 'package:partner_in_cook/data/recipe_mock.dart';
import 'package:partner_in_cook/component/widgets/add_btn.dart';
import 'package:partner_in_cook/component/widgets/custom_app_bar.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/fridge/fridge_card.dart';
import 'package:partner_in_cook/component/fridge/card_list.dart';
import 'package:partner_in_cook/component/widgets/title_page.dart';

import '../controllers/fridge_controller.dart';

class FridgeView extends GetView<FridgeController> {
  const FridgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: AppColors.background,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Générer la liste des cards pantry depuis l'observable
          List<Widget> cards = controller.pantries.map((pantry) {
            return PantryCard(
              pantry: pantry!,
              onTap: () => controller.onPantryTap(pantry.id),
            );
          }).toList();

          return Column(
            children: [
              TitlePage(
                hasSearchBar: false,
                title: 'Frigos',
                subtitle: 'Que voulez-vous cuisiner aujourd\'hui ?',
                searchController: controller.searchController,
                data: recipes,
              ),

              Expanded(
                child: CustomLayout(
                  verticalPadding: 20,
                  children: [
                    if (controller.fridge.value != null)
                      FridgeCard(
                        fridge: controller.fridge.value!,
                        onTap: () =>
                            controller.onFridgeTap(controller.fridge.value!.id),
                      ),
                    CardList(
                      cards: cards,
                      icon: LucideIcons.refrigerator,
                      emptyString: "Aucun garde-manger disponible",
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: AddBtn(
        onTap: () => controller.showCreatePantryDialog(context),
      ),
    );
  }
}
