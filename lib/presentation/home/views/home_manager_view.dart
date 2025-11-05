import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/widget/customNavBar.component.dart';
import '../controllers/home_manager_controller.dart';

class HomeManagerView extends GetView<HomeManagerController> {
  const HomeManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              // IndexedStack prend tout l'espace disponible
              Expanded(
                child: IndexedStack(
                  index: controller.currentPageIndex.value,
                  children: [
                    
                  ],
                ),
              ),
              // Navbar en bas
              CustomNavBar(controller: controller),
            ],
          );
        }),
      ),
    );
  }
}