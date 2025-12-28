import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class IngredientTitle extends StatelessWidget {
  final int count;

  const IngredientTitle({super.key, required this.count});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/logo/logo.png', width: 125, height: 125),
          const SizedBox(height: 24),
          Text(
            '$count',
            style: TextStyle(
              color: AppColors.primaryOrange,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
