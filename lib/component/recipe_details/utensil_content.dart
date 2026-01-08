import 'package:flutter/material.dart';

class UstensilContent extends StatelessWidget {
  const UstensilContent({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ['Bol', 'Fouet', 'Poêle antiadhésive'];

    return Column(
      children: [
        for (final u in items) ...[
          Row(
            children: [
              const Icon(Icons.check_box_outline_blank, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(u)),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ],
    );
  }
}

class StepContent extends StatelessWidget {
  const StepContent({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Dans un grand bol, mélangez la farine, le sucre et la levure chimique.',
      'Dans un autre bol, battez les œufs avec le lait et le beurre fondu.',
      'Incorporez les ingrédients liquides aux ingrédients secs.',
      // ...
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${i + 1}. ',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Expanded(child: Text(steps[i])),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
