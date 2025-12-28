import 'package:flutter/material.dart';

/// Gère uniquement le padding horizontal + contraintes communes
class BaseLayout extends StatelessWidget {
  final List<Widget> children;
  final double horizontalPadding;
  final Widget Function(List<Widget> children) builder;

  const BaseLayout({
    super.key,
    required this.children,
    required this.builder,
    this.horizontalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: builder(children),
    );
  }
}
