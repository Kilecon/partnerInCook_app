import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/model/pantry.dart';
import 'package:partner_in_cook/model/fridge.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,

        /// Icône Pantry
        leading: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            LucideIcons.box,
            size: 32,
            color: Colors.orange,
          ),
        ),

        /// Titre
        title: Text(
          pantry.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        /// Infos
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),

            /// Nombre de frigos
            Row(
              children: [
                const Icon(Icons.kitchen_outlined, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${pantry.fridges.length} frigo${pantry.fridges.length > 1 ? 's' : ''}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Avatars superposés
            if (pantry.fridges.isNotEmpty)
              SizedBox(
                height: 28,
                child: Stack(
                  children: [
                    for (int i = 0;
                        i < pantry.fridges.take(5).length;
                        i++)
                      Positioned(
                        left: i * 18,
                        child: _OwnerAvatar(fridge: pantry.fridges[i]),
                      ),

                    /// +X si plus
                    if (pantry.fridges.length > 5)
                      Positioned(
                        left: 5 * 18,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            '+${pantry.fridges.length - 5}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),

        /// Chevron
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
      ),
    );
  }
}

/// Avatar propriétaire
class _OwnerAvatar extends StatelessWidget {
  final Fridge fridge;

  const _OwnerAvatar({required this.fridge});

  @override
  Widget build(BuildContext context) {
    final owner = fridge.owner;

    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 12,
        backgroundImage:
            owner.profilePictureUrl != null &&
                    owner.profilePictureUrl!.isNotEmpty
                ? NetworkImage(owner.profilePictureUrl!)
                : null,
        child: (owner.profilePictureUrl == null ||
                owner.profilePictureUrl!.isEmpty)
            ? Text(
                owner.username.isNotEmpty
                    ? owner.username[0].toUpperCase()
                    : '?',
                style: const TextStyle(fontSize: 12),
              )
            : null,
      ),
    );
  }
}
