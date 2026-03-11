import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';
import 'package:partner_in_cook/model/api/fridge_ingredient.dart';

class IngredientPantryCard extends StatelessWidget {
  final FridgeIngredientWOwner fridgeIngredient;
  final VoidCallback onTap;

  const IngredientPantryCard({
    super.key,
    required this.fridgeIngredient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  if (fridgeIngredient.ingredient?.iconPictureUrl != null)
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        fridgeIngredient.ingredient!.iconPictureUrl!,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      fridgeIngredient.ingredient!.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${fridgeIngredient.quantity} ${fridgeIngredient.ingredient!.unit}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryOrange,
                  ),
                ),
                const SizedBox(width: 8),
                AvatarSuperimposed(users: fridgeIngredient.owners),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
