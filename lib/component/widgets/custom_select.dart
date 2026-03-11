import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomSelect<T> extends StatelessWidget {
  const CustomSelect({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = '',
    this.prefixIcon = Icons.arrow_drop_down,
    this.validator,
    this.enabled = true,
    this.labelBuilder,
  });

  final String title;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator<T>? validator;
  final bool enabled;
  final String Function(T)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 6),

        /// SELECT
        DropdownButtonFormField<T>(
          value: value,
          validator: validator,
          onChanged: enabled ? onChanged : null,
          items: items.map((item) {
            final label = labelBuilder != null
                ? labelBuilder!(item)
                : _labelFromValue(item);
            return DropdownMenuItem<T>(
              value: item,
              child: Text(label, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.lightGray,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.yellowPrimary,
              size: 20,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.yellowPrimary.withOpacity(0.7),
                width: 1.2,
              ),
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.lightGray,
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
      ],
    );
  }

  /// Support enum proprement (State.publicState → publicState) si pas de labelBuilder fourni
  String _labelFromValue(T value) {
    final raw = value.toString();
    if (raw.contains('.')) {
      return raw.split('.').last;
    }
    return raw;
  }
}
