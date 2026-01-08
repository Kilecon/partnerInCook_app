import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

class AuthorTag extends StatelessWidget {
  final LightUser author;

  const AuthorTag({
    super.key,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.50), // effet "glass"/clair
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryOrange,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar rond
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(
              author.profilePictureUrl ?? '',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          // Textes alignés verticalement
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Créé par",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.lightGray,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                author.username,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
