import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/component/widgets/step_indicator.dart';

class CreateRecipeFooter extends StatelessWidget {
  final VoidCallback onNext;
  final int currentStep;
  final int totalSteps;

  const CreateRecipeFooter({
    super.key,
    required this.onNext,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StepIndicator(current: currentStep, total: totalSteps),
            const SizedBox(height: 12),
            CustomButton(name: 'Suivant', onClick: onNext),
          ],
        ),
      ),
    );
  }
}
