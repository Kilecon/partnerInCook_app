import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onBackPressed});

  final VoidCallback? onBackPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Get.find<AuthService>();

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Obx(() {
            final user = authService.user.value;
            final imageUrl =
                user?.profilePicture ??
                'https://s3.mizury.fr/partnerincook/chef.png';

            return GestureDetector(
              onTap: () => Get.toNamed(Routes.profile),
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.lightGray, width: 2),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
