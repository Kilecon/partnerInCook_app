import 'package:flutter/material.dart';
import 'package:partner_in_cook/widget/chip/chip.dart';

import '../model/Category.dart';

class CategoryChips extends StatelessWidget {
  final Category selected;
  final ValueChanged<Category> onChanged;
  const CategoryChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cats = Category.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        children: cats.map((c) {
          return CustomChip(
            name: c.name,
            isSelect: c == selected,
            onClick: () => onChanged(c),
          );
        }).toList(),
      ),
    );
  }
}
