import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/presentation/profil/controllers/profil_controller.dart';
import 'package:partner_in_cook/component/widgets/custom_app_bar.dart';
import 'package:partner_in_cook/component/widgets/custom_layout.dart';
import 'package:partner_in_cook/component/widgets/title_page.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showBackButton: false),
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            TitlePage(
              hasSearchBar: false,
              title: 'Profil',
              subtitle: 'Gérez votre profil et vos préférences',
            ),

            Expanded(
              child: CustomLayout(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(controller.user?.username ?? 'No user'),
                        Text(controller.user?.email ?? 'No email'),
                        TextButton(
                          onPressed: () => controller.logout(),
                          child: const Text('Se déconnecter'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
