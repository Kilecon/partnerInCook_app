import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/component/explorer/tag.dart';

class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.tags,
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
          Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < tags.length; i++) ...[
                CustomTag(
                  color: color,
                  isSelect: selected.contains(tags[i]),
                  name: tags[i].name,
                  onClick: () => onChanged(tags[i]),
                ),
                if (i < tags.length - 1) const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
