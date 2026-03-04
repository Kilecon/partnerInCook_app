import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/recipe_ingredient.dart';

class IngredientContent extends StatefulWidget {
  final List<RecipeIngredient> ingredients;
  const IngredientContent({super.key, required this.ingredients});

  @override
  State<IngredientContent> createState() => _IngredientContentState();
}

class _IngredientContentState extends State<IngredientContent> {
  late final List<bool> _checked;

  @override
  void initState() {
    super.initState();
    _checked = List.filled(widget.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ingredients.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Aucun ingrédient', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < widget.ingredients.length; i++) ...[
          _IngredientRow(
            ingredient: widget.ingredients[i],
            checked: _checked[i],
            onChanged: (v) => setState(() => _checked[i] = v ?? false),
          ),
          if (i < widget.ingredients.length - 1)
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
        ],
      ],
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({
    required this.ingredient,
    required this.checked,
    required this.onChanged,
  });

  final RecipeIngredient ingredient;
  final bool checked;
  final ValueChanged<bool?> onChanged;

  String get _displayName =>
      ingredient.ingredient?.name ?? ingredient.ingredientId;

  String get _displayQuantity {
    final qty = ingredient.quantity;
    final unit = ingredient.ingredient?.unit ?? '';
    final qtyStr = qty == qty.truncateToDouble()
        ? qty.toInt().toString()
        : qty.toStringAsFixed(1);
    return unit.isNotEmpty ? '$qtyStr $unit' : qtyStr;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = ingredient.ingredient?.iconPictureUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Checkbox
          SizedBox(
            width: 32,
            height: 32,
            child: Checkbox(
              value: checked,
              onChanged: onChanged,
              activeColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: Color(0xFFCCCCCC)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 10),
          // Nom + quantité
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _displayName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: checked ? TextDecoration.lineThrough : null,
                    color: checked ? Colors.grey : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _displayQuantity,
                  style: TextStyle(
                    fontSize: 12,
                    color: checked ? Colors.grey : AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Image de l'ingrédient
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.lightOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const _PlaceholderIcon(),
                  )
                : const _PlaceholderIcon(),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.lunch_dining_outlined,
        size: 22,
        color: AppColors.primaryOrange,
      ),
    );
  }
}
