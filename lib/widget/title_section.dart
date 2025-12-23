import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/recipe.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.searchController,
    required this.recipes,
    required this.onSearchResultTap,
  });

  final String title;
  final String subtitle;
  final SearchController searchController;
  final List<Recipe> recipes;
  final VoidCallback onSearchResultTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryOrange,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor.bar(
              searchController: searchController,
              barHintText: 'Rechercher une recette…',
              suggestionsBuilder: (context, controller) {
                final q = controller.text.toLowerCase();
                final items = recipes
                    .where((e) => q.isEmpty || e.name.toLowerCase().contains(q))
                    .take(5)
                    .toList();
                return items.map(
                  (e) => ListTile(
                    title: Text(e.name),
                    onTap: () {
                      controller.closeView(e.name);
                      onSearchResultTap();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
