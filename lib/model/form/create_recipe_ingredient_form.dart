import 'package:partner_in_cook/model/api/ingredient.dart';

class CreateRecipeIngredient {
  String? id;
  final Ingredient ingredient;
  final double quantity;

  CreateRecipeIngredient({
    this.id,
    required this.ingredient,
    required this.quantity,
  });
}
