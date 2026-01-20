import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? footer;
  final double maxWidth;
  final Color backgroundColor;

  // Nouveaux paramètres
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry padding;

  const AppDialog({
    super.key,
    required this.title,
    required this.child,
    this.footer,
    this.maxWidth = 0.95,
    this.backgroundColor = AppColors.background,
    this.showBorder = false,
    this.borderColor = Colors.black12,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.titleStyle,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * maxWidth;
    final _radius = borderRadius ?? BorderRadius.circular(24);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width, minWidth: width),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: _radius,
              border: showBorder
                  ? Border.all(color: borderColor, width: borderWidth)
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Center(
                  child: Text(
                    title,
                    style:
                        titleStyle ??
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),

                const SizedBox(height: 24),

                /// BODY
                child,

                /// FOOTER
                if (footer != null) ...[
                  const SizedBox(height: 24),
                  Align(alignment: Alignment.centerRight, child: footer!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
