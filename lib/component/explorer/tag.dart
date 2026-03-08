import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final bool isSelect;
  final String name;
  final VoidCallback onClick;
  final Color color;
  const CustomTag({
    super.key,
    required this.isSelect,
    required this.name,
    required this.onClick,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelect ? color : Colors.white,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelect ? Colors.white : color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
