import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final bool isDisabled;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final bool hasBorder;
  final Color borderColor;

  const CustomButton({
    super.key,
    required this.name,
    required this.onClick,
    this.isDisabled = false,
    this.isLoading = false,
    this.backgroundColor = AppColors.primaryOrange,
    this.textColor = Colors.white,
    this.hasBorder = false,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasBorder
          ? BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(15),
            )
          : null,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isDisabled ? null : onClick,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isDisabled ? backgroundColor.withOpacity(0.5) : backgroundColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    color: textColor,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}