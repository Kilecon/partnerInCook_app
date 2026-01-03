import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/fridge.dart';

class FridgeCard extends StatelessWidget {
  final Fridge fridge;
  final VoidCallback onTap;

  const FridgeCard({
    super.key,
    required this.fridge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,
        /// Icône / illustration
        leading: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.kitchen_rounded,
            size: 36,
            color: Colors.orange,
          ),
        ),

        /// Titre
        title: const Text(
          'Mon frigo',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        /// Infos principales
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Propriétaire : ${fridge.owner.username}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),

        /// Action / indicateur
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
