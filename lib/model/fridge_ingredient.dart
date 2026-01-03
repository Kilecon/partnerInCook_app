import 'package:partner_in_cook/model/ingredient.dart';

class FridgeIngredient {
  final String id;
  final double quantity;
  final String fridgeId;
  final String ingredientId;
  final Ingredient? ingredient;

  FridgeIngredient({
    required this.id,
    required this.quantity,
    required this.fridgeId,
    required this.ingredientId,
    this.ingredient,
  });

  factory FridgeIngredient.fromJson(Map<String, dynamic> json) {
    return FridgeIngredient(
      id: json['id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      fridgeId: json['fridge_id'] as String,
      ingredientId: json['ingredient_id'] as String,
      ingredient: json['ingredient'] != null
          ? Ingredient.fromJson(json['ingredient'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'fridge_id': fridgeId,
      'ingredient_id': ingredientId,
      'ingredient': ingredient?.toJson(),
    };
  }
}
