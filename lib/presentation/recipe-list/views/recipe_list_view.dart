import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/fridge/card_list.dart';
import 'package:partner_in_cook/component/recipe-list/recipe_list_card.dart';
import 'package:partner_in_cook/component/widgets/add_btn.dart';
import 'package:partner_in_cook/component/widgets/custom_app_bar.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/widgets/title_page.dart';

import '../controllers/recipe_list_controller.dart';

class RecipeListView extends GetView<RecipeListController> {
  const RecipeListView({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];

    for (var recipeList in controller.recipeList) {
      cards.add(
        RecipeListCard(
          recipeList: recipeList,
          onTap: () => controller.onRecipeListTap(recipeList.id),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(showBackButton: false),
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            TitlePage(
              hasSearchBar: false,
              title: 'Listes de recettes',
              subtitle: 'Vos listes de recettes personnalisées',
              searchController: controller.searchController,
              data: controller.recipeList,
            ),

            Expanded(
              child: CustomLayout(
                verticalPadding: 20,
                children: [
                  CardList(
                    icon: Icons.list_alt,
                    cards: cards,
                    emptyString: "Aucune liste de recettes disponible",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddBtn(
        onTap: () => controller.onAddRecipeListTap(),
      ),
    );
  }
}
