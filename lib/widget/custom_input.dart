import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.title,
    this.prefixIcon = Icons.search,
    this.backgroundColor = AppColors.background,
    this.borderColor = AppColors.yellowPrimary,
    this.hintText = '',
    this.isPassword = false,
    this.onSaved,
    this.validator,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.enabled = true,
  });

  final String title;
  final IconData prefixIcon;
  final Color backgroundColor;
  final Color borderColor;
  final String hintText;
  final bool isPassword;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final bool enabled;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late FocusNode _focusNode;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    if (!widget.isPassword) _obscure = false;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          enabled: widget.enabled,
          obscureText: widget.isPassword ? _obscure : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onChanged: widget.onChanged,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.lightGray,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: AppColors.yellowPrimary,
              size: 20,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.lightGray,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: widget.backgroundColor,
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
        ),
      ],
    );
  }
}