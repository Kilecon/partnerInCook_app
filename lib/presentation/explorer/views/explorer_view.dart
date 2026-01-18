import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/data/light_recipe.dart';
import 'package:partner_in_cook/data/recipe_mock.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/component/widgets/custom_app_bar.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/explorer/recipe_sections.dart';
import 'package:partner_in_cook/component/widgets/title_page.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
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
                data: recipes,
                onSearchResultTap: controller.onSearch,
              ),

              Expanded(
                child: CustomLayout(
                  children: [
                    RecipeSections(
                      title: "Dernières nouveautés",
                      latestRecipes: latestLightRecipes,
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
