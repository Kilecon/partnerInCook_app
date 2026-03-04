import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/explorer/tag_list.dart';
import 'package:partner_in_cook/model/api/recipe.dart';

class RecipeDescriptionSection extends StatelessWidget {
  final Recipe recipe;
  const RecipeDescriptionSection({super.key, required this.recipe});

  String _formatTime(int? minutes, String label) {
    if (minutes == null || minutes == 0) return '';
    return minutes >= 60
        ? '${minutes ~/ 60}h${minutes % 60 > 0 ? "${minutes % 60}min" : ""} $label'
        : '${minutes}min $label';
  }

  @override
  Widget build(BuildContext context) {
    final timeChips = <_InfoChip>[
      if (recipe.preparationTime != null && recipe.preparationTime! > 0)
        _InfoChip(
          icon: Icons.schedule_outlined,
          label: _formatTime(recipe.preparationTime, 'prép.'),
        ),
      if (recipe.restTime != null && recipe.restTime! > 0)
        _InfoChip(
          icon: Icons.pause_circle_outline,
          label: _formatTime(recipe.restTime, 'repos'),
        ),
      if (recipe.cookTime != null && recipe.cookTime! > 0)
        _InfoChip(
          icon: Icons.local_fire_department_outlined,
          label: _formatTime(recipe.cookTime, 'cuisson'),
        ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre + portions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 16,
                      color: AppColors.primaryOrange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${recipe.portions}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (recipe.description != null && recipe.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              recipe.description!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.lightGray,
                height: 1.4,
              ),
            ),
          ],
          if (timeChips.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 6, children: timeChips),
          ],
          if (recipe.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            TagList(
              selected: recipe.tags,
              tags: recipe.tags,
              onChanged: (_) {},
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.lightOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryOrange),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryOrange,
            ),
          ),
        ],
      ),
    );
  }
}
