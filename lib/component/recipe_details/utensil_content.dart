import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/utensil.dart';

class UstensilContent extends StatelessWidget {
  final List<Utensil> utensils;
  const UstensilContent({super.key, required this.utensils});

  @override
  Widget build(BuildContext context) {
    if (utensils.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Aucun ustensile', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: [
        for (final u in utensils) ...[
          Row(
            children: [
              const Icon(Icons.check_box_outline_blank, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(u.name)),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ],
    );
  }
}
