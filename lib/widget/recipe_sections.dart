import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/recipe.dart';
import 'package:partner_in_cook/model/tag.dart';
import 'package:partner_in_cook/widget/header.dart';
import 'package:partner_in_cook/widget/recipe_list.dart';
import 'package:partner_in_cook/widget/tag_list.dart';

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
  final List<Recipe> latestRecipes;
  final List<Recipe> filteredRecipes;
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
              onRecipeTap: onRecipeTap,
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
        RecipeList(recipes: filteredRecipes, onRecipeTap: onRecipeTap),
      ],
    );
  }
}
