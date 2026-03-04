import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';
import 'package:partner_in_cook/component/widgets/info_chip.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';

class RecipeListInfo extends StatelessWidget {
  final RecipeList recipeList;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final bool isMyRecipes;
  final bool isFavorite;
  final bool isMyPlaylist;

  const RecipeListInfo({
    super.key,
    required this.recipeList,
    this.onDelete,
    this.onEdit,
    this.isMyRecipes = false,
    this.isFavorite = false,
    this.isMyPlaylist = false,
  });

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),

          child: !isMyRecipes && !isFavorite
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onEdit != null)
                      ListTile(
                        leading: const Icon(
                          LucideIcons.pencil,
                          color: AppColors.primaryOrange,
                        ),
                        title: const Text('Modifier'),
                        onTap: () {
                          Navigator.pop(context);
                          onEdit?.call();
                        },
                      ),
                    if (onDelete != null)
                      ListTile(
                        leading: const Icon(LucideIcons.trash2, color: Colors.red),
                        title: const Text('Supprimer'),
                        onTap: () {
                          Navigator.pop(context);
                          onDelete?.call();
                        },
                      ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeList.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (recipeList.members.isNotEmpty)
                    ...[
                      const SizedBox(height: 8),
                      AvatarSuperimposed(users: recipeList.members),
                    ],
                ],
              ),
            ),
            if (!isMyRecipes || !isFavorite || isMyPlaylist)
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showOptions(context),
              ),
          ],
        ),
        if (isMyRecipes)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              "C'est vous le chef ! Cette liste regroupe toutes les recettes que vous avez créées.",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          )
        else if (recipeList.description != null &&
            recipeList.description!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              recipeList.description!,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        Row(
          children: [
            InfoChip(
              icon: Icons.restaurant_menu,
              label:
                  '${recipeList.recipes.length} recette${recipeList.recipes.length > 1 ? 's' : ''}',
            ),
            const SizedBox(width: 8),
            if (recipeList.members.isNotEmpty)
              InfoChip(
                icon: Icons.people,
                label:
                    '${recipeList.members.length} membre${recipeList.members.length > 1 ? 's' : ''}',
              ),
          ],
        ),
      ],
    );
  }
}
