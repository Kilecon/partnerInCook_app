import 'package:flutter/material.dart';

class BackHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const BackHeader({super.key, required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
