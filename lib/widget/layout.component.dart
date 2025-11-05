import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class BasePageLayout extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget child;
  final EdgeInsetsGeometry contentPadding;
  final double topSpacing;
  final bool scrollable; // NOUVEAU

  const BasePageLayout({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
    this.actions,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    this.topSpacing = 12.0,
    this.scrollable = true, // valeur par défaut true
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: contentPadding,
      child: child,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // CustomPageHeader(
          //   title: title,
          //   subtitle: subtitle,
          //   showBackButton: showBackButton,
          //   actions: actions,
          // ),
          SizedBox(height: topSpacing),
          Expanded(
            child: SafeArea(
              top: false,
              child: scrollable
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: content,
                    )
                  : content,
            ),
          ),
        ],
      ),
    );
  }
}