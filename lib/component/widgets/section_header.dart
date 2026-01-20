import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final double padding;
  const CustomTitle({
    super.key,
    required this.title,
    this.onSeeAll,
    this.padding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          if (onSeeAll != null)
            TextButton(onPressed: onSeeAll, child: const Text('Voir tout')),
        ],
      ),
    );
  }
}
