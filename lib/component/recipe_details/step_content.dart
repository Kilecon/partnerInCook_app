import 'package:flutter/material.dart' hide Step;
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/step.dart';

class StepContent extends StatelessWidget {
  final List<Step> steps;
  const StepContent({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Aucune étape', style: TextStyle(color: Colors.grey)),
      );
    }

    final sorted = [...steps]..sort((a, b) => a.order.compareTo(b.order));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < sorted.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: AppColors.primaryOrange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  sorted[i].description,
                  style: const TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
          if (i < sorted.length - 1)
            const Padding(
              padding: EdgeInsets.only(left: 36, top: 8, bottom: 8),
              child: Divider(height: 1, color: Color(0xFFEEEEEE)),
            ),
          if (i == sorted.length - 1) const SizedBox(height: 4),
        ],
      ],
    );
  }
}
