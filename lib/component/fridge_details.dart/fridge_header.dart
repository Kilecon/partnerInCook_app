import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/circle_btn.dart';

class FridgeHeader extends StatelessWidget {
  final int ingredientsCount;

  const FridgeHeader({
    super.key,
    required this.ingredientsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260, // ⬅️ hauteur augmentée
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Image de fond
          Image.asset(
            'assets/images/fridge_banner.png',
            fit: BoxFit.cover,
          ),
   
          /// Contenu
          SafeArea(
            top: true, // ✅ safe area en haut
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top bar
                  Row(
                    children: [
                      CircleIconButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  /// Centre
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '$ingredientsCount',
                          style: const TextStyle(
                            color: AppColors.primaryOrange,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                            color: AppColors.primaryOrange,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
    
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
