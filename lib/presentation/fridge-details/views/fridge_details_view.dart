import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/fridge_details.dart/fridge_header.dart';
import 'package:partner_in_cook/model/fridge.dart';

import '../controllers/fridge_details_controller.dart';

class FridgeDetailsView extends GetView<FridgeDetailsController> {
  const FridgeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {

    final dynamic args = Get.arguments;
    Fridge? fridge;
    String? fallbackId;

    if (args is Fridge) {
      fridge = args;
    } else if (args is Map<String, dynamic>) {
      try {
        fridge = Fridge.fromJson(args);
      } catch (_) {
        fridge = null;
      }
    } else if (args is String) {
      // parfois on envoie seulement l'id
      fallbackId = args;
    }
    return Scaffold(
      backgroundColor: AppColors.background,
        body: Column(
        children: [
          FridgeHeader(ingredientsCount: 10,), // image + appbar + auteur (sliver)
        ],
      ),
    );
  }
}
