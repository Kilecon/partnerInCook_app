import 'package:flutter/material.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/component/explorer/tag.dart';

class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.tags,
  });

  final Tag selected;
  final List<Tag> tags;
  final ValueChanged<Tag> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < tags.length; i++) ...[
              CustomTag(
                isSelect: tags[i] == selected,
                name: tags[i].name,
                onClick: () => onChanged(tags[i]),
              ),
              if (i < tags.length - 1) const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }
}
