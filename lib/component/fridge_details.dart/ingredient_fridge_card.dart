import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/fridge_ingredient.dart';

class IngredientFridgeCard extends StatefulWidget {
  final FridgeIngredient fridgeIngredient;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const IngredientFridgeCard({
    super.key,
    required this.fridgeIngredient,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<IngredientFridgeCard> createState() => _IngredientFridgeCardState();
}

class _IngredientFridgeCardState extends State<IngredientFridgeCard> {
  double _dragExtent = 0;
  static const double _actionWidth = 140.0;

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent = (_dragExtent + details.primaryDelta!).clamp(
        -_actionWidth,
        0.0,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragExtent < -_actionWidth / 2) {
      setState(() {
        _dragExtent = -_actionWidth;
      });
    } else {
      setState(() {
        _dragExtent = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      onTap: () {
        if (_dragExtent != 0) {
          setState(() {
            _dragExtent = 0;
          });
        } else {
          widget.onTap();
        }
      },
      child: Stack(
        children: [
          // Background avec les boutons
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          _dragExtent = 0;
                        });
                        widget.onEdit?.call();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _dragExtent = 0;
                        });
                        widget.onDelete?.call();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Carte principale
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(_dragExtent, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.fridgeIngredient.ingredient?.iconPictureUrl !=
                                null
                            ? SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  widget
                                          .fridgeIngredient
                                          .ingredient!
                                          .iconPictureUrl ??
                                      '',
                                ),
                              )
                            : Container(),
                        const SizedBox(width: 10),
                        Text(
                          widget.fridgeIngredient.ingredient!.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.fridgeIngredient.quantity} ${widget.fridgeIngredient.ingredient!.unit}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
