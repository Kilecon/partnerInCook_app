import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/circle_avatar.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

class AvatarSuperimposed extends StatelessWidget {
  final List<LightUser> users;

  const AvatarSuperimposed({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      width: users.length > 5 ? 5 * 18 + 28 : users.length * 18 + 28,
      child: Stack(
        children: [
          for (int i = 0; i < users.take(5).length; i++)
            Positioned(
              left: i * 18,
              child: CircleAvatarCustom(name: users[i].username, url: users[i].profilePictureUrl),
            ),
          if (users.length > 5)
            Positioned(
              left: 5 * 18,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey.shade300,
                child: Text(
                  '+${users.length - 5}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
