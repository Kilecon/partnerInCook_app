import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/light_recipe_list.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/component/widgets/section_header.dart';
import 'package:partner_in_cook/component/explorer/recipe_list.dart';
import 'package:partner_in_cook/component/explorer/tag_list.dart';

class RecipeSections extends StatelessWidget {
  const RecipeSections({
    super.key,
    required this.title,
    required this.latestRecipes,
    required this.filteredRecipes,
    required this.onRecipeTap,
    this.tags,
    this.selectedTag,
    this.onTagChanged,
  });

  final String title;
  final List<LightRecipe> latestRecipes;
  final List<LightRecipe> filteredRecipes;
  final VoidCallback onRecipeTap;
  final List<Tag>? tags;
  final Tag? selectedTag;
  final ValueChanged<Tag>? onTagChanged;

  @override
  Widget build(BuildContext context) {
    final hasLatest = latestRecipes.isNotEmpty;

    if (hasLatest && tags == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionHeader(title: title, onSeeAll: () {}),
          SizedBox(
            height: 200,
            child: RecipeList(
              recipes: latestRecipes,
              axis: Axis.horizontal,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(title: title),
        if (tags != null && onTagChanged != null)
          TagList(
            selected: selectedTag ?? tags!.first,
            tags: tags!,
            onChanged: onTagChanged!,
          ),
        RecipeList(recipes: filteredRecipes),
      ],
    );
  }
}
