import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/light_recipe_list.dart';

import 'rating_stars.dart';

class RecipeHorizontalCard extends StatelessWidget {
  final LightRecipe recipe;
  final VoidCallback onTap;
  const RecipeHorizontalCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                child: Image.network(
                  recipe.pictureUrl ?? '',
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.hardEdge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  RatingStars(rating: recipe.averageNotation),
                  Row(
                    spacing: 5,
                    children: [
                      const Icon(Icons.schedule, size: 14),
                      Text('${recipe.globalTime ?? 0} min'),
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
