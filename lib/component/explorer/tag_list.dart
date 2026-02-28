import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/component/explorer/tag.dart';
class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.selected, // Liste des tags sélectionnés
    required this.onChanged,
    required this.tags, // Tous les tags dispos
    this.color = AppColors.primaryOrange,
    this.title,
  });

  final List<Tag> selected;
  final List<Tag> tags;
  final ValueChanged<Tag> onChanged;
  final String? title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
        ],
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tags.map((tag) {
              // Vérification par ID
              final isSelected = selected.any((t) => t.id == tag.id);
              
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomTag(
                  color: color,
                  isSelect: isSelected,
                  name: tag.name,
                  onClick: () => onChanged(tag),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}