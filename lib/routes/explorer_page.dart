import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/Category.dart';
import 'package:partner_in_cook/model/Recipe.dart';
import 'package:partner_in_cook/model/mocks.dart';
import 'package:partner_in_cook/widget/category_chips.dart';
import 'package:partner_in_cook/widget/header.dart';
import 'package:partner_in_cook/widget/recipes/recipe_list.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});
  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  final SearchController _searchCtrl = SearchController();
  Category _selected = Category.tout;

  List<Recipe> get _filtered {
    var r = recipes;
    if (_selected != Category.tout) {
      r = r.where((e) => e.category == _selected).toList();
    }
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isNotEmpty) {
      r = r.where((e) => e.title.toLowerCase().contains(q)).toList();
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final hasLatest = latestRecipes.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Container(
        color: AppColors.background,
        child: Column(
          spacing: 5,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explorer', style: TextStyle(fontSize: 24)),
                  const Text(
                    "Découvrez des milliers de recettes",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryOrange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchAnchor.bar(
                      searchController: _searchCtrl,
                      barHintText: 'Rechercher une recette…',
                      suggestionsBuilder: (context, controller) {
                        final q = controller.text.toLowerCase();
                        final items = recipes
                            .where(
                              (e) =>
                                  q.isEmpty ||
                                  e.title.toLowerCase().contains(q),
                            )
                            .take(5)
                            .toList();
                        return items.map(
                          (e) => ListTile(
                            title: Text(e.title),
                            onTap: () {
                              controller.closeView(e.title);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (hasLatest) ...[
              Column(
                spacing: 5,
                children: [
                  const SectionHeader(title: 'Dernières nouveautés'),
                  SizedBox(
                    height: 200,
                    child: RecipeList(
                      recipes: latestRecipes,
                      axis: Axis.horizontal,
                      onRecipeTap: () {},
                    ),
                  ),
                ],
              ),
            ],
            const SectionHeader(title: 'Liste des recettes', onSeeAll: null),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CategoryChips(
                selected: _selected,
                onChanged: (c) => setState(() => _selected = c),
              ),
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
