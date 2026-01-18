import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class ImageCoverCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback onTap;

  const ImageCoverCard({
    super.key,
    required this.title,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryOrange.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Image en cover (background)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: imageUrl != null
                    ? Image.asset(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.orange.withOpacity(0.15),
                            child: const Icon(
                              LucideIcons.image,
                              size: 32,
                              color: Colors.orange,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.orange.withOpacity(0.15),
                        child: const Icon(
                          LucideIcons.image,
                          size: 32,
                          color: Colors.orange,
                        ),
                      ),
              ),
            ),
            
            // Overlay sombre pour la lisibilité
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            
            // Titre centré
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                   
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}