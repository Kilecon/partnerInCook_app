import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/circle_avatar.dart';

class SwipeCard extends StatefulWidget {
  final String name;
  final String? unit;
  final double? quantity;
  final String? iconUrl;
  final bool isCentered = false;

  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  final Color backgroundColor;

  const SwipeCard({
    super.key,
    required this.name,
    this.unit,
    this.quantity,
    this.iconUrl,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.backgroundColor = Colors.white,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  double _dragExtent = 0;
  static const double _actionWidth = 140;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent = (_dragExtent + details.primaryDelta!).clamp(
        -_actionWidth,
        0.0,
      );
    });
  }

  void _onDragEnd(_) {
    setState(() {
      _dragExtent = _dragExtent < -_actionWidth / 2 ? -_actionWidth : 0;
    });
  }

  void _reset() {
    setState(() => _dragExtent = 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: () {
        if (_dragExtent != 0) {
          _reset();
        } else {
          widget.onTap?.call();
        }
      },
      child: Stack(
        children: [
          /// BACKGROUND ACTIONS
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
                      icon: Icons.edit,
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
                      icon: Icons.delete,
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

          /// CARD
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(_dragExtent, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.iconUrl != null && widget.iconUrl!.isNotEmpty
                          ? Image.network(
                              widget.iconUrl!,
                              width: 40,
                              height: 40,
                            )
                          : CircleAvatarCustom(name: widget.name, url: widget.iconUrl),
                      const SizedBox(width: 10),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (widget.quantity != null || widget.unit != null)
                  Text(
                    '${widget.quantity ?? ''} ${widget.unit ?? ''}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryOrange,
                    ),
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
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onTap,
      ),
    );
  }
}
