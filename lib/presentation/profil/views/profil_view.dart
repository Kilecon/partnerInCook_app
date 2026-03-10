import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/recipe-list/image_cover_card.dart';
import 'package:partner_in_cook/component/widgets/back_header.dart';
import 'package:partner_in_cook/component/widgets/circle_avatar.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/component/widgets/section_header.dart';
import 'package:partner_in_cook/presentation/profil/controllers/profil_controller.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            BackHeader(title: 'Profil', onBack: Get.back),

            Expanded(
              child: CustomLayout(
                spacing: 8,
                children: [
                  // Header utilisateur (séparé en petits Obx pour éviter les erreurs de type)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatarCustom(
                                  name: controller.user.value?.username ?? 'U',
                                  url: controller.user.value?.profilePicture,
                                  radius: 30,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.user.value?.username ??
                                              'Utilisateur',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Obx(
                                        () => Text(
                                          controller.user.value?.email ?? '',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(LucideIcons.pencil),
                                  onPressed: () => (),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Stats
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.book,
                                      size: 20,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(
                                      () => Text(
                                        controller
                                            .userStats
                                            .value
                                            .createdRecipesCount
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Recettes',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.list_alt,
                                      size: 20,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(
                                      () => Text(
                                        controller
                                            .userStats
                                            .value
                                            .linkedRecipelists
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Listes',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      size: 20,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(
                                      () => Text(
                                        controller
                                            .userStats
                                            .value
                                            .favoritesRecipesCount
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Favoris',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  CustomTitle(title: 'Accès rapide', padding: 0),
                  Column(
                    spacing: 12,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: ImageCoverCard(
                              title: 'Mes recettes',
                              imageUrl: "assets/images/my_recipes_banner.png",
                              onTap: controller.onMyRecipesTap,
                            ),
                          ),
                          Expanded(
                            child: ImageCoverCard(
                              title: 'Mes favoris',
                              imageUrl: "assets/images/favorites_banner.png",
                              onTap: controller.onRecipeListTap,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ImageCoverCard(
                              title: 'Mon frigo',
                              imageUrl: "assets/images/my_fridge_banner.png",
                              onTap: controller.onFridgeTap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      name: 'Deconnexion',
                      onClick: controller.logout,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
