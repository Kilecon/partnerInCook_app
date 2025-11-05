import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/presentation/home/controllers/home_manager_controller.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.controller,
  });

  final HomeManagerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          controller.listIcon.length,
          (index) => InkWell(
            onTap: () {
              controller.changePage(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: controller.currentPageIndex.value == index
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.black,
                        )
                      : null,
                  child: Icon(
                    controller.currentPageIndex.value == index
                        ? controller.listIconSelected[index]
                        : controller.listIcon[index],
                    size: 28,
                    color:AppColors.white
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  controller.listLabels[index],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.black,
                    fontWeight: controller.currentPageIndex.value == index
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}