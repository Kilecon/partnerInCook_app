import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';

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
    // Détermination de l'icône et du texte de visibilité
    debugPrint("RecipeListCard - recipeList: ${recipeList.name}, visibilityState: ${recipeList.visibilityState}");
    final bool isPublic = recipeList.visibilityState == VisibilityStateEnum.publicState;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Image de la liste
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              clipBehavior: Clip.antiAlias,
              child: recipeList.pictureUrl != null
                  ? Image.network(
                      recipeList.pictureUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
                    )
                  : _buildFallbackImage(),
            ),

            const SizedBox(width: 16),

            /// Infos (Titre + Stats + Membres)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeList.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  /// Ligne d'infos : Recettes + Visibilité
                  Row(
                    children: [
                      // Nombre de recettes
                      const Icon(LucideIcons.bookOpen, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${recipeList.recipes.length} recette${recipeList.recipes.length > 1 ? 's' : ''}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                      ),
                      
                      const SizedBox(width: 12),
                      const Text("•", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 12),

                      // État de visibilité
                      Icon(
                        isPublic ? LucideIcons.globe : LucideIcons.lock,
                        size: 14,
                        color: isPublic ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isPublic ? 'Public' : 'Privé',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isPublic ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 6),
                  
                  /// Avatars des membres
                  if (recipeList.members.isNotEmpty)
                    AvatarSuperimposed(users: recipeList.members),
                ],
              ),
            ),

            /// Chevron
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Image.asset(
      "assets/images/recipe_list_pic.png",
      fit: BoxFit.cover,
    );
  }
}