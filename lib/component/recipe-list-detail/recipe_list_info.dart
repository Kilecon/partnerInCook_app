import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';
import 'package:partner_in_cook/component/widgets/info_chip.dart';
import 'package:partner_in_cook/model/recipe_list.dart';

class RecipeListInfo extends StatelessWidget {
  final RecipeList recipeList;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const RecipeListInfo({
    super.key,
    required this.recipeList,
    this.onDelete,
    this.onEdit,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onEdit != null)
                ListTile(
                  leading: const Icon(
                    Icons.edit,
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
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Supprimer'),
                  onTap: () {
                    Navigator.pop(context);
                    onDelete?.call();
                  },
                ),
            ],
          ),
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
                  const SizedBox(height: 4),
                  AvatarSuperimposed(users: recipeList.members),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showOptions(context),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (recipeList.description != null &&
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
