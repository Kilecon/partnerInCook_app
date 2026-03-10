import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/recipe_details/tag_author.dart';
import 'package:partner_in_cook/component/widgets/circle_btn.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

class RecipeHeader extends StatelessWidget {
  final LightUser user;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTapAction;
  final String? imageUrl;
  final bool canShare;

  const RecipeHeader({
    super.key,
    required this.user,
    required this.icon,
    required this.onTapAction,
    this.iconColor,
    this.imageUrl,
    this.canShare = true,
  });

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      pinned: true,
      expandedHeight: 260,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,

      // Boutons back et favoris qui restent visibles
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.of(context).pop(),
                  color: Colors.white,
                ),
                if (canShare)
                  CircleIconButton(
                    icon: icon,
                    onTap: onTapAction,
                    color: iconColor ?? Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calcul du ratio de scroll (0 = expanded, 1 = collapsed)
          final double top = constraints.biggest.height;
          final double collapsedHeight =
              MediaQuery.of(context).padding.top + kToolbarHeight;
          final double expandedHeight = 260;
          final double scrollRatio =
              ((expandedHeight - top) / (expandedHeight - collapsedHeight))
                  .clamp(0.0, 1.0);

          return Stack(
            fit: StackFit.expand,
            children: [
              // Image (toujours visible)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24 * (1 - scrollRatio)),
                  bottomRight: Radius.circular(24 * (1 - scrollRatio)),
                ),
                child: imageUrl != null
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/my_recipes_banner.png',
                        fit: BoxFit.cover,
                      ),
              ),
              // Gradient sombre (disparaît progressivement)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24 * (1 - scrollRatio)),
                    bottomRight: Radius.circular(24 * (1 - scrollRatio)),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black38],
                  ),
                ),
              ),
              // Author tag qui disparaît progressivement
              Positioned(
                left: 16,
                bottom: 12,
                child: Opacity(
                  opacity: 1 - scrollRatio,
                  child: AuthorTag(author: user),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
