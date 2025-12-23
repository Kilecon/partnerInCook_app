import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final List<Widget> children;
  final double horizontalPadding;

  const CustomLayout({
    super.key,
    required this.children,
    this.horizontalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(spacing: 5, children: children),
    );
  }
}
