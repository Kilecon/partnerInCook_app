import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

class OwnerAvatar extends StatelessWidget {
  final LightUser user;

  const OwnerAvatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 12,
        backgroundImage:
            user.profilePictureUrl != null &&
                user.profilePictureUrl!.isNotEmpty
            ? NetworkImage(user.profilePictureUrl!)
            : null,
        child:
            (user.profilePictureUrl == null ||
                user.profilePictureUrl!.isEmpty)
            ? Text(
                user.username.isNotEmpty
                    ? user.username[0].toUpperCase()
                    : '?',
                style: const TextStyle(fontSize: 12),
              )
            : null,
      ),
    );
  }
}
