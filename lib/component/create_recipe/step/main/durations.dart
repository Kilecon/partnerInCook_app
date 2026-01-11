import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class DurationsSelector extends StatelessWidget {
  final int preparation;
  final int cook;
  final int rest;

  final VoidCallback onPrepTap;
  final VoidCallback onCookTap;
  final VoidCallback onRestTap;
  final String? title;

  const DurationsSelector({
    super.key,
    required this.preparation,
    required this.cook,
    required this.rest,
    required this.onPrepTap,
    required this.onCookTap,
    required this.onRestTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        const SizedBox(height: 6),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DurationChip(
                color: AppColors.yellowPrimary,
                icon: LucideIcons.timer,
                label: 'Prépa',
                value: preparation,
                onTap: onPrepTap,
              ),
              _DurationChip(
                color: AppColors.yellowPrimary,
                icon: LucideIcons.flame,
                label: 'Cuisson',
                value: cook,
                onTap: onCookTap,
              ),
              _DurationChip(
                color: AppColors.yellowPrimary,
                icon: LucideIcons.clock,
                label: 'Repos',
                value: rest,
                onTap: onRestTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DurationChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final VoidCallback onTap;
  final Color color;

  const _DurationChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              '$label • ${value} min',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
