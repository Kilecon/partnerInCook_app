import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/data/recipe_mock.dart';
import 'package:partner_in_cook/component/widgets/add_btn.dart';
import 'package:partner_in_cook/component/widgets/custom_app_bar.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/fridge/fridge_card.dart';
import 'package:partner_in_cook/component/fridge/pantry_list.dart';
import 'package:partner_in_cook/component/widgets/title_page.dart';

import '../controllers/fridge_controller.dart';

class FridgeView extends GetView<FridgeController> {
  const FridgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showBackButton: false),
      body: Container(
        color: AppColors.background,
        child: Obx(() {

          return Column(
            children: [
              TitlePage(
                hasSearchBar: false,
                title: 'Frigos',
                subtitle: 'Que voulez-vous cuisiner aujourd\'hui ?',
                searchController: controller.searchController,
                recipes: recipes,
              ),

              Expanded(
                child: CustomLayout(
                  children: [
                    FridgeCard(fridge: controller.fridge.value, onTap: () => controller.onFridgeTap(controller.fridge.value)),

                    PantryList(
                      pantries: controller.pantries,
                      onPantryTap: () => controller.onPantryTap(controller.pantries[0]),
                    ),
                    AddBtn(onTap: () => controller.onAddPantryTap()),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
