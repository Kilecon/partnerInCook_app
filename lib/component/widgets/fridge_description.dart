import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/avatars_superimposed.dart';
import 'package:partner_in_cook/model/light_user.dart';

class FridgeDescription extends StatelessWidget {
  final String title;
  final List<LightUser>? sharedUsers;

  const FridgeDescription({required this.title, this.sharedUsers, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
        ),
        child: Row(
          mainAxisAlignment: sharedUsers != null && sharedUsers!.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (sharedUsers != null && sharedUsers!.isNotEmpty)
              const SizedBox(width: 48), // Pour équilibrer les avatars
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            if (sharedUsers != null && sharedUsers!.isNotEmpty)
              AvatarSuperimposed(users: sharedUsers!)
            else
              const SizedBox(width: 48), // Pour garder le titre centré
          ],
        ),
      ),
    );
  }
}
