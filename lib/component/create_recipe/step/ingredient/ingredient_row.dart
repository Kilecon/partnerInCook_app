import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class IngredientRow extends StatelessWidget {
  final String name;
  final String quantity;
  final VoidCallback onDelete;

  const IngredientRow({
    super.key,
    required this.name,
    required this.quantity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            LucideIcons.leaf,
            size: 18,
            color: AppColors.primaryOrange,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            quantity,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.primaryOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              LucideIcons.x,
              size: 16,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
