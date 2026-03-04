import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'rating_stars.dart';

class RecipeLargeCard extends StatefulWidget {
  final LightRecipe recipe;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const RecipeLargeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<RecipeLargeCard> createState() => _RecipeLargeCardState();
}

class _RecipeLargeCardState extends State<RecipeLargeCard> {
  double _dragExtent = 0;
  static const double _actionWidth = 140; // Largeur pour 2 boutons

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent = (_dragExtent + details.primaryDelta!).clamp(-_actionWidth, 0.0);
    });
  }

  void _onDragEnd(_) {
    setState(() {
      _dragExtent = _dragExtent < -_actionWidth / 2 ? -_actionWidth : 0;
    });
  }

  void _reset() => setState(() => _dragExtent = 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: () {
        if (_dragExtent != 0) {
          _reset();
        } else {
          widget.onTap();
        }
      },
      child: Stack(
        children: [
          /// ACTIONS (En dessous)
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.onEdit != null)
                    _ActionBtn(
                      color: AppColors.lightGreen,
                      icon: LucideIcons.edit3,
                      iconColor: Colors.green,
                      onTap: () {
                        _reset();
                        widget.onEdit?.call();
                      },
                    ),
                  const SizedBox(width: 10),
                  if (widget.onDelete != null)
                    _ActionBtn(
                      color: AppColors.lightRed,
                      icon: LucideIcons.trash2,
                      iconColor: Colors.red,
                      onTap: () {
                        _reset();
                        widget.onDelete?.call();
                      },
                    ),
                ],
              ),
            ),
          ),
    
          /// CARTE (Au dessus)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(_dragExtent, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.recipe.pictureUrl ?? '',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[200],
                        child: const Icon(LucideIcons.utensils, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
    
                  /// INFOS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.recipe.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        
                        // Rating + Time
                        Row(
                          children: [
                            RatingStars(rating: widget.recipe.averageNotation),
                            const SizedBox(width: 12),
                            const Icon(LucideIcons.timer, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.recipe.globalTime ?? 0} min',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        
                        // Auteur
                        Text(
                          'Par ${widget.recipe.author.username}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
    
                  /// FAVORITE / CHEVRON
                  Column(
                    children: [
                      Icon(
                        widget.recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: widget.recipe.isFavorite ? Colors.red : Colors.grey[300],
                        size: 22,
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Petit composant interne pour les boutons d'action
class _ActionBtn extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}