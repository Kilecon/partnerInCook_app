import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class AddBtn extends StatelessWidget {
  final VoidCallback onTap;

  const AddBtn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.background,
        
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.lightOrange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            LucideIcons.plus,
            size: 32,
            color: AppColors.primaryOrange,
          ),
        ),
      ),
    );
  }
}