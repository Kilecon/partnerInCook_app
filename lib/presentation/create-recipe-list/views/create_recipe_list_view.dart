import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/create_recipe_list/create_recipe_list_form.dart';
import 'package:partner_in_cook/component/widgets/back_header.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/component/widgets/layout/custom_layout_body.dart';
import 'package:partner_in_cook/presentation/create-recipe-list/controllers/create_recipe_list_controller.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class CreateRecipeListView extends GetView<CreateRecipeListController> {
  const CreateRecipeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CreateRecipeHeader(
            title: 'Créer une liste de recettes',
            onBack: () => Get.toNamed(Routes.recipeList),
          ),

          Expanded(child: CustomLayoutBody(children: [CreateRecipeListForm()])),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    name: 'Valider',
                    onClick: controller.createRecipeList,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
