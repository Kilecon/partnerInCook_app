import 'package:flutter/material.dart';

class RecipeSection extends StatelessWidget {
  const RecipeSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header + bouton +
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child, // le contenu précis (ingrédients, etc.)
        ],
      ),
    );
  }
}
