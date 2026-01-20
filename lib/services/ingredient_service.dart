import 'package:partner_in_cook/model/api/ingredient.dart';

class IngredientService {
  /// Recherche des ingrédients par nom
  /// TODO: Remplacer par un vrai appel API
  Future<List<Ingredient>> searchIngredients(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock data - à remplacer par un vrai appel API
    final allIngredients = [
      Ingredient(id: '1', name: 'Tomate', unit: 'g'),
      Ingredient(id: '2', name: 'Farine', unit: 'g'),
      Ingredient(id: '3', name: 'Lait', unit: 'ml'),
      Ingredient(id: '4', name: 'Œuf', unit: 'pièce'),
      Ingredient(id: '5', name: 'Sucre', unit: 'g'),
      Ingredient(id: '6', name: 'Beurre', unit: 'g'),
      Ingredient(id: '7', name: 'Sel', unit: 'g'),
      Ingredient(id: '8', name: 'Poivre', unit: 'g'),
      Ingredient(id: '9', name: 'Oignon', unit: 'pièce'),
      Ingredient(id: '10', name: 'Ail', unit: 'gousse'),
    ];

    if (query.isEmpty) return allIngredients;

    return allIngredients
        .where((ing) => ing.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
