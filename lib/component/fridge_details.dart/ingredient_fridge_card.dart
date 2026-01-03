import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/fridge_ingredient.dart';

class IngredientFridgeCard extends StatelessWidget {
  final FridgeIngredient fridgeIngredient;
  final VoidCallback onTap;
  const IngredientFridgeCard({super.key, required this.fridgeIngredient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(fridgeIngredient.ingredient?.name ?? "Ingrédient inconnu"),
        subtitle: Text("Quantité: ${fridgeIngredient.quantity}"),
      ),
    );
  }
}
