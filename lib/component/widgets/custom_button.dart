import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final bool isDisabled;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.name,
    required this.onClick,
    this.isDisabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDisabled ? AppColors.primaryOrange.withOpacity(0.5) : AppColors.primaryOrange,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}