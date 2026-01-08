import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class AddBtn extends StatelessWidget {
  final VoidCallback onTap;

  const AddBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          color: AppColors.lightOrange,
          shape: BoxShape.circle,
        ),
        child: const Icon(LucideIcons.plus, color: AppColors.primaryOrange, size: 24),
      ),
    );
  }
}
