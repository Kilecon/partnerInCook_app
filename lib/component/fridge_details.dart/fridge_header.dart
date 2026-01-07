import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/circle_btn.dart';

class FridgeHeader extends StatelessWidget {
  final int ingredientsCount;

  const FridgeHeader({super.key, required this.ingredientsCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellowPrimary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              child: Container(
                height: 200,
                child: Stack(
                  children: [
                    /// Image de fond
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/fridge_banner.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    /// Contenu
                    Padding(
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
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Centre
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$ingredientsCount',
                                    style: const TextStyle(
                                      color: AppColors.primaryOrange,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    ingredientsCount > 1 ? 'Ingredients' : 'Ingredient',
                                    style: const TextStyle(
                                      color: AppColors.primaryOrange,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Zone de prolongation en dessous de l'image
            const SizedBox(
              height: 10,
            ), // Ajuste cette valeur pour agrandir la zone
          ],
        ),
      ),
    );
  }
}
