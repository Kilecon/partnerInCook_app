import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/data/recipe_mock.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/widget/custom_app_bar.dart';
import 'package:partner_in_cook/widget/custom_layout.dart';
import 'package:partner_in_cook/widget/recipe_list.dart';
import 'package:partner_in_cook/widget/recipe_sections.dart';
import 'package:partner_in_cook/widget/tag_list.dart';
import 'package:partner_in_cook/widget/title_section.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showBackButton: false),
      body: Container(
        color: AppColors.background,
        child: Obx(() {
          final filtered = controller.filteredRecipes;

          return CustomLayout(
            children: [
              TitleSection(
                title: 'Explorer',
                subtitle: 'Découvrez des milliers de recettes',
                searchController: controller.searchController,
                recipes: recipes,
                onSearchResultTap: controller.onSearch,
              ),

              RecipeSections(
                title: "Dernières nouveautés",
                latestRecipes: latestRecipes,
                filteredRecipes: filtered,
                onRecipeTap: () {},
              ),

              Expanded(
                child: RecipeSections(
                  title: "Toutes les recettes",
                  latestRecipes: [],
                  filteredRecipes: filtered,
                  tags: tagsMock,
                  selectedTag: controller.selectedTag.value,
                  onTagChanged: controller.onTagChanged,
                  onRecipeTap: () {},
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
