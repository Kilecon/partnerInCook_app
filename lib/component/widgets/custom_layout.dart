import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final List<Widget> children;
  final double horizontalPadding;
  final double verticalPadding;
  final double spacing;
  final bool useSafeArea;
  final bool safeAreaTop;
  final bool safeAreaBottom;

  const CustomLayout({
    super.key,
    required this.children,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 0,
    this.spacing = 16.0,
    this.useSafeArea = false,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: children.length,
        separatorBuilder: (context, index) => SizedBox(height: spacing),
        itemBuilder: (context, index) => children[index],
      ),
    );

    if (useSafeArea) {
      return SafeArea(top: safeAreaTop, bottom: safeAreaBottom, child: content);
    }

    return content;
  }
}
