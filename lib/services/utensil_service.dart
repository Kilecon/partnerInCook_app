import 'package:partner_in_cook/model/api/utensil.dart';

class UtensilService {
  /// Recherche des ingrédients par nom
  /// TODO: Remplacer par un vrai appel API
  Future<List<Utensil>> searchUtensils(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock data - à remplacer par un vrai appel API
    final allUtensils = [
      Utensil(id: '1', name: 'Couteau'),
      Utensil(id: '2', name: 'Fourchette'),
      Utensil(id: '3', name: 'Cuillère'),
      Utensil(id: '4', name: 'Poêle'),
      Utensil(id: '5', name: 'Casserole'),
      Utensil(id: '6', name: 'Mixeur'),
      Utensil(id: '7', name: 'Planche à découper'),
    ];

    if (query.isEmpty) return allUtensils;

    return allUtensils
        .where((ing) => ing.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
