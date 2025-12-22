import 'package:flutter/material.dart';

class ExplorerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExplorerAppBar({
    super.key,
    this.onBackPressed,
    this.showBackButton = false,
  });

  final VoidCallback? onBackPressed;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      automaticallyImplyLeading: showBackButton,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 14,
          backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
