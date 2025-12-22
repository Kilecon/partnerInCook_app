import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/data/tag_mock.dart';
import 'package:partner_in_cook/model/tag.dart';
import 'package:partner_in_cook/model/recipe.dart';
import 'package:partner_in_cook/data/recipe_mock.dart';
import 'package:partner_in_cook/widget/explorer/explorer_app_bar.dart';
import 'package:partner_in_cook/widget/explorer/explorer_title_section.dart';
import 'package:partner_in_cook/widget/explorer/recipe_sections.dart';
import 'package:partner_in_cook/widget/explorer/tag_list.dart';
import 'package:partner_in_cook/widget/recipes/recipe_list.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});
  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  final SearchController _searchCtrl = SearchController();
  Tag _selected = tagsMock.first;

  List<Recipe> get _filtered {
    var r = recipes;
    // if (_selected != Category.tout) {
    //   r = r.where((e) => e.category == _selected).toList();
    // }
    // final q = _searchCtrl.text.trim().toLowerCase();
    // if (q.isNotEmpty) {
    //   r = r.where((e) => e.title.toLowerCase().contains(q)).toList();
    // }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      appBar: const ExplorerAppBar(showBackButton: false),
      body: Container(
        color: AppColors.background,
        child: Column(
          spacing: 5,
          children: [
            ExplorerTitleSection(
              title: 'Explorer',
              subtitle: 'Découvrez des milliers de recettes',
              searchController: _searchCtrl,
              recipes: recipes,
              onSearchResultTap: () => setState(() {}),
            ),
            RecipeSections(
              latestRecipes: latestRecipes,
              filteredRecipes: filtered,
              onRecipeTap: () {},
            ),
            TagList(
              selected: _selected,
              onChanged: (c) => setState(() => _selected = c),
              tags: tagsMock,
            ),
            Expanded(
              child: RecipeList(recipes: filtered, onRecipeTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
