import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CircleAvatarCustom extends StatelessWidget {
  final String name;
  final String? url;
  final double radius;

  const CircleAvatarCustom({super.key, required this.name, this.url, this.radius = 12});

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      backgroundColor: AppColors.lightOrange,
      foregroundColor: AppColors.primaryOrange,
      radius: radius,
      backgroundImage:
          url != null &&
              url!.isNotEmpty
          ? NetworkImage(url!)
          : null,
      child:
          (url == null ||
              url!.isEmpty)
          ? Text(
              name.isNotEmpty
                  ? name[0].toUpperCase()
                  : '?',
              style: TextStyle(fontSize: radius),
            )
          : null,
    );
  }
}
