import 'package:partner_in_cook/model/api/ingredient.dart';

class CreateRecipeIngredient {
  final Ingredient ingredient;
  final double quantity;

  CreateRecipeIngredient({
    required this.ingredient,
    required this.quantity,
  });
}
