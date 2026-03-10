import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';
import 'package:partner_in_cook/model/api/pantry.dart';
import 'package:partner_in_cook/model/api/fridge.dart';

class PantryCard extends StatelessWidget {
  final Pantry pantry;
  final VoidCallback onTap;

  const PantryCard({
    super.key,
    required this.pantry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final usersShared = pantry.fridges.map((fridge) => fridge.owner).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, // Hauteur fixe demandée
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white, // Changé en blanc pour la lisibilité, remets Colors.red si voulu
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
            /// Icône Pantry (Image)
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
                  "assets/images/pantry_pic.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            const SizedBox(width: 16),

            /// Infos (Titre + Subtitle) - Expands pour prendre l'espace
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Aligne verticalement au centre
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pantry.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.kitchen_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${pantry.fridges.length} frigo${pantry.fridges.length > 1 ? 's' : ''}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  if (pantry.fridges.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    AvatarSuperimposed(users: usersShared),
                  ],
                ],
              ),
            ),

            /// Chevron
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