import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

import '../controllers/pantry_join_controller.dart';

class PantryJoinView extends GetView<PantryJoinController> {
  const PantryJoinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator( color: AppColors.primaryOrange,);
          }

          if (controller.error.value != null) {
            return Text(controller.error.value!);
          }

          return const SizedBox.shrink();
        }),
      ),
    );
  }
}