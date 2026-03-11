import 'package:partner_in_cook/model/api/fridge_ingredient.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

class Fridge {
  final String id;
  final LightUser owner;
  final List<FridgeIngredient> ingredients;

  Fridge({
    required this.id,
    required this.owner,
    required this.ingredients,
  });

  factory Fridge.fromJson(Map<String, dynamic> json) {
    return Fridge(
      id: json['id'] as String,
      owner: LightUser.fromJson(json['owner']),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => FridgeIngredient.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner.toJson(),
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
    };
  }
}
