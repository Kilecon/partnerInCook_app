import 'package:partner_in_cook/model/api/ingredient.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

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

class FridgeIngredientWOwner {
  final String id;
  final double quantity;
  final String fridgeId;
  final String ingredientId;
  final Ingredient? ingredient;
  final List<LightUser> owners;

  FridgeIngredientWOwner({
    required this.id,
    required this.quantity,
    required this.fridgeId,
    required this.ingredientId,
    this.ingredient,
    required this.owners,
  });

  factory FridgeIngredientWOwner.fromJson(Map<String, dynamic> json) {
    return FridgeIngredientWOwner(
      id: json['id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      fridgeId: json['fridge_id'] as String,
      ingredientId: json['ingredient_id'] as String,
      owners: (json['owners'] as List<dynamic>)
          .map((e) => LightUser.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'owners': owners.map((e) => e.toJson()).toList(),
      'ingredient': ingredient?.toJson(),
    };
  }
}
