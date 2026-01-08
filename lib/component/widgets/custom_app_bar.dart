import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.onBackPressed,
    this.showBackButton = false,
  });

  final VoidCallback? onBackPressed;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: showBackButton
            ? IconButton(
                onPressed: onBackPressed ?? () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        automaticallyImplyLeading: showBackButton,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.profile),
            child: Container(
              padding: const EdgeInsets.all(1), // épaisseur de la bordure
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.lightGray,
                  width: 2,
                ), // couleur et largeur de la bordure
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://s3.mizury.fr/partnerincook/chef.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
