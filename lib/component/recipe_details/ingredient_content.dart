import 'package:flutter/material.dart';

class IngredientContent extends StatelessWidget {
  const IngredientContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = [
      Ingredient(name: 'Farine', quantity: '250g'),
      Ingredient(name: 'Sucre', quantity: '250g'),
      Ingredient(name: 'Oeufs', quantity: '1 pièce'),
    ];

    return Column(
      children: [
        for (final ing in ingredients) ...[
          Row(
            children: [
              Checkbox(
                value: ing.checked,
                onChanged: (v) {},
              ),
              Expanded(child: Text(ing.name)),
              Text(
                ing.quantity,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Divider(height: 12),
        ],
      ],
    );
  }
}

class Ingredient {
  Ingredient({
    required this.name,
    required this.quantity,
    this.checked = false,
  });

  final String name;
  final String quantity;
  final bool checked;
}
