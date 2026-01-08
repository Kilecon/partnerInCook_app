import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';

class RecipeListCard extends StatelessWidget {
  final RecipeList recipeList;
  final VoidCallback onTap;

  const RecipeListCard({
    super.key,
    required this.recipeList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,

        /// Image de la liste
        leading: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: recipeList.pictureUrl != null
              ? Image.network(
                  recipeList.pictureUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.orange.withOpacity(0.15),
                      child: const Icon(
                        LucideIcons.box,
                        size: 32,
                        color: Colors.orange,
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.orange.withOpacity(0.15),
                  child: const Icon(
                    LucideIcons.box,
                    size: 32,
                    color: Colors.orange,
                  ),
                ),
        ),

        /// Titre
        title: Text(
          recipeList.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        /// Infos
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            AvatarSuperimposed(users: recipeList.members),
          ],
        ),

        /// Chevron
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
