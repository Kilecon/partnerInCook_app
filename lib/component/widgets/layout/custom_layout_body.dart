import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/layout/base_layout.dart';

class CustomLayoutBody extends StatelessWidget {
  final List<Widget> children;
  final double horizontalPadding;
  final double verticalPadding;
  final bool useSafeArea;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final double spacing;

  const CustomLayoutBody({
    super.key,
    required this.children,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 0.0,
    this.useSafeArea = false,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.spacing = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final content = BaseLayout(
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      children: children,
      builder: (children) => Column(
        spacing: spacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

    if (useSafeArea) {
      return SafeArea(top: safeAreaTop, bottom: safeAreaBottom, child: content);
    }

    return content;
  }
}
