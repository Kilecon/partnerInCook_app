import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/recipe/tag_author.dart';
import 'package:partner_in_cook/data/fridge_mock.dart';

class RecipeHeader extends StatelessWidget {  // ← Retire le underscore
  const RecipeHeader({super.key});           // ← Ajoute le constructeur

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 260,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/images/pancakes.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // gradient sombre bas
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black26],
              ),
            ),
          ),
          // App bar + author + favoris
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CircleIconButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      _CircleIconButton(
                        icon: Icons.favorite_border,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const Spacer(),
                  AuthorTag(author: userAlice),  // ← const si possible
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// _CircleIconButton reste privé (underscore conservé)
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
