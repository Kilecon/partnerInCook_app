class RecipeIngredient {
  final String id;
  final double quantity;
  final String recipeId;
  final String ingredientId;

  RecipeIngredient({
    required this.id,
    required this.quantity,
    required this.recipeId,
    required this.ingredientId,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      id: json['id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      recipeId: json['recipe_id'] as String,
      ingredientId: json['ingredient_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'recipe_id': recipeId,
      'ingredient_id': ingredientId,
    };
  }
}

class RecipeIngredientCreateRequest {
  final double quantity;
  final String recipeId;
  final String ingredientId;

  RecipeIngredientCreateRequest({
    required this.quantity,
    required this.recipeId,
    required this.ingredientId,
  });

  factory RecipeIngredientCreateRequest.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientCreateRequest(
      quantity: (json['quantity'] as num).toDouble(),
      recipeId: json['recipe_id'] as String,
      ingredientId: json['ingredient_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'recipe_id': recipeId,
      'ingredient_id': ingredientId,
    };
  }
}
