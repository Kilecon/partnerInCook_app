import 'package:flutter/material.dart';

import '../model/Recipe.dart';
import 'rating_stars.dart';

class RecipeLargeCard extends StatelessWidget {
  final Recipe recipe;
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
            recipe.imageUrl,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(recipe.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                RatingStars(rating: recipe.rating),
                const SizedBox(width: 8),
                const Icon(Icons.schedule, size: 14),
                const SizedBox(width: 2),
                Text('${recipe.minutes} min'),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Réalisé par ${recipe.author.name}',
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
            Text('${recipe.likes}'),
          ],
        ),
      ),
    );
  }
}
