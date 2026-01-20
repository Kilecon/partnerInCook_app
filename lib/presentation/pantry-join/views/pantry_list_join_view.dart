import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pantry_join_controller.dart';

class PantryJoinView extends GetView<PantryJoinController> {
  const PantryJoinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
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