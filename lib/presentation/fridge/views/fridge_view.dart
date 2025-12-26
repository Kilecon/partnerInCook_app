import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/data/recipe_mock.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/widget/custom_app_bar.dart';
import 'package:partner_in_cook/widget/custom_layout.dart';
import 'package:partner_in_cook/widget/recipe_sections.dart';
import 'package:partner_in_cook/widget/title_page.dart';

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
          final filtered = controller.filteredRecipes;

          return Column(
            children: [
              TitlePage(
                hasSearchBar: true,
                title: 'Explorer',
                subtitle: 'Découvrez des milliers de recettes',
                searchController: controller.searchController,
                recipes: recipes,
                onSearchResultTap: controller.onSearch,
              ),

              Expanded(
                child: CustomLayout(
                  children: [
                    RecipeSections(
                      title: "Dernières nouveautés",
                      latestRecipes: latestRecipes,
                      filteredRecipes: filtered,
                      onRecipeTap: () {},
                    ),

                    RecipeSections(
                      title: "Toutes les recettes",
                      latestRecipes: [],
                      filteredRecipes: filtered,
                      tags: tagsMock,
                      selectedTag: controller.selectedTag.value,
                      onTagChanged: controller.onTagChanged,
                      onRecipeTap: () {},
                    ),
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
