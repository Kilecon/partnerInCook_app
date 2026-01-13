import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';

class DurationsSelector extends StatelessWidget {
  final int preparation;
  final int cook;
  final int rest;

  // Changed callbacks to ValueChanged<int>
  final ValueChanged<int> onPrepTap;
  final ValueChanged<int> onCookTap;
  final ValueChanged<int> onRestTap;
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
                onChanged: onPrepTap,
              ),
              _DurationChip(
                color: AppColors.yellowPrimary,
                icon: LucideIcons.flame,
                label: 'Cuisson',
                value: cook,
                onChanged: onCookTap,
              ),
              _DurationChip(
                color: AppColors.yellowPrimary,
                icon: LucideIcons.clock,
                label: 'Repos',
                value: rest,
                onChanged: onRestTap,
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
  // Changed to ValueChanged<int>
  final ValueChanged<int> onChanged;
  final Color color;

  const _DurationChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final controller = TextEditingController(text: value.toString());
        final result = await showDialog<int>(
          context: context,
          builder: (ctx) {
            return AppDialog(
              title: 'Modifier $label',
              footer: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.black,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Annuler'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryOrange,
                    ),
                    onPressed: () {
                      final parsed = int.tryParse(controller.text);
                      if (parsed != null) {
                        Navigator.of(ctx).pop(parsed);
                      } else {
                        // Ne ferme pas si invalide
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Theme(
                    data: Theme.of(ctx).copyWith(
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: AppColors.primaryOrange,
                        selectionColor: AppColors.primaryOrange.withOpacity(
                          0.25,
                        ),
                        selectionHandleColor: AppColors.primaryOrange,
                      ),
                    ),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.black),
                      decoration: InputDecoration(
                        hintText: 'Durée en minutes',
                        hintStyle: TextStyle(
                          color: AppColors.black.withOpacity(0.45),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryOrange.withOpacity(0.18),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryOrange,
                            width: 1.5,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                      autofocus: true,
                    ),
                  ),
                ],
              ),
            );
          },
        );

        if (result != null) {
          onChanged(result);
        }
      },
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
