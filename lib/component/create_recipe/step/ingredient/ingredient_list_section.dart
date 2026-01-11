import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/add_btn.dart';

class IngredientListSection extends StatelessWidget {
  final List<Widget> items;
  final VoidCallback onAddTap;

  const IngredientListSection({
    super.key,
    required this.items,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: e,
          ),
        ),
        AddBtn(onTap: onAddTap),
      ],
    );
  }
}
