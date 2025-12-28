import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomTag extends StatelessWidget {
  final bool isSelect;
  final String name;
  final VoidCallback onClick;
  const CustomTag({
    super.key,
    required this.isSelect,
    required this.name,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelect ? AppColors.primaryOrange : Colors.white,
          border: Border.all(color: AppColors.primaryOrange, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelect ? Colors.white : AppColors.primaryOrange,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
