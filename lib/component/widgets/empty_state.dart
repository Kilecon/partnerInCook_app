import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;
  const EmptyState({super.key, required this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? LucideIcons.chefHat, size: 50, color: AppColors.primaryOrange),
          const SizedBox(height: 12),
          SizedBox(
            height: 48, // ≈ 2 lignes à 16px
            width: 150,
            child: Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
