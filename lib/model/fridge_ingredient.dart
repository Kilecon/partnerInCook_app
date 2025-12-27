class FridgeIngredient {
  final String id;
  final double quantity;
  final String fridgeId;
  final String ingredientId;

  FridgeIngredient({
    required this.id,
    required this.quantity,
    required this.fridgeId,
    required this.ingredientId,
  });

  factory FridgeIngredient.fromJson(Map<String, dynamic> json) {
    return FridgeIngredient(
      id: json['id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      fridgeId: json['fridge_id'] as String,
      ingredientId: json['ingredient_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'fridge_id': fridgeId,
      'ingredient_id': ingredientId,
    };
  }
}
