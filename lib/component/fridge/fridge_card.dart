import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/fridge.dart';

class FridgeCard extends StatelessWidget {
  final Fridge fridge;
  final VoidCallback onTap;

  const FridgeCard({super.key, required this.fridge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, // Hauteur fixe
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white, // Modifié pour la lisibilité (remets Colors.red si besoin)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Icône / illustration
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/fridge_pic.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// Infos principales (Titre + Sous-titre)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centrage vertical parfait
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mon frigo',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_basket_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${fridge.ingredients.length} ingrédients',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Action / indicateur
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}