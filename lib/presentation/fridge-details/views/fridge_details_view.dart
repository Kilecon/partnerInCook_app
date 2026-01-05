import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/fridge_details.dart/fridge_header.dart';
import 'package:partner_in_cook/component/fridge_details.dart/ingredient_list.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/data/fridge_mock.dart';
import 'package:partner_in_cook/model/fridge.dart';

import '../controllers/fridge_details_controller.dart';

class FridgeDetailsView extends GetView<FridgeDetailsController> {
  const FridgeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    Fridge fridge = fridgeMock;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          FridgeHeader(ingredientsCount: fridge.ingredients.length),
          Expanded(
            child: CustomLayout(
              spacing: 30,
              children: [
                // FridgeDescription(
                //   title: "Mon frigo",
                //   sharedUsers: null,
                // ),
                SizedBox(height: 15),
                IngredientsList(
                  ingredients: fridge.ingredients,
                  isPantry: false,
                ),
              ],
            ),
          ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: AppColors.lightOrange,
        child: const Icon(Icons.add, color: AppColors.primaryOrange),
      ),
    );
  }
}
