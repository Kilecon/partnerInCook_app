import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomFloatingBtn extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color? backgroundColor;
  const CustomFloatingBtn({super.key, required this.onTap, required this.icon, this.backgroundColor});

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
        child: Icon(
          icon,
          color: backgroundColor ?? AppColors.primaryOrange,
          size: 24,
        ),
      ),
    );
  }
}
