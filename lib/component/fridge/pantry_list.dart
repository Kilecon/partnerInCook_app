import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/model/pantry.dart';
import 'package:partner_in_cook/component/widgets/empty_state.dart';
import 'package:partner_in_cook/component/fridge/pantry_card.dart';

class PantryList extends StatelessWidget {
  final List<Pantry> pantries;
  final VoidCallback onPantryTap;
  final Axis axis;
  const PantryList({
    super.key,
    required this.pantries,
    this.axis = Axis.vertical,
    required this.onPantryTap,
  });

  @override
  Widget build(BuildContext context) {
    return pantries.isEmpty
        ? EmptyState(
            icon: LucideIcons.refrigerator,
            message: "Aucun garde mangé disponibles",
          )
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10, width: 10),
            scrollDirection: axis,
            shrinkWrap: axis == Axis.vertical,
            physics: axis == Axis.vertical
                ? const NeverScrollableScrollPhysics()
                : null,
            itemBuilder: (BuildContext context, int index) =>
                PantryCard(pantry: pantries[index], onTap: onPantryTap),
            itemCount: pantries.length,
          );
  }
}
