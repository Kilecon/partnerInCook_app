import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/layout/base_layout.dart';

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
    return BaseLayout(
      horizontalPadding: horizontalPadding,
      children: children,
      builder: (children) => ListView(
        padding: EdgeInsets.zero,
        children: children,
      ),
    );
  }
}
