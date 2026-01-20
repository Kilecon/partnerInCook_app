import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/light_recipe_list.dart';
import 'rating_stars.dart';

class RecipeLargeCard extends StatelessWidget {
  final LightRecipe recipe;
  final VoidCallback onTap;
  const RecipeLargeCard({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            recipe.pictureUrl ?? '',
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(recipe.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                RatingStars(rating: recipe.averageNotation),
                const SizedBox(width: 8),
                const Icon(Icons.schedule, size: 14),
                const SizedBox(width: 2),
                Text('${recipe.globalTime ?? 0} min'),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Réalisé par ${recipe.author.username}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border),
            const SizedBox(height: 4),
            Text('${recipe.notationsCount}'),
          ],
        ),
      ),
    );
  }
}
