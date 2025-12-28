import 'package:flutter/material.dart';
import 'package:partner_in_cook/component/explorer/tag_list.dart';
import 'package:partner_in_cook/data/tag_mock.dart';

class RecipeDescriptionSection extends StatelessWidget {
  const RecipeDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // titre + nb pers
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Pancakes moelleux au sirop d\'érable',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: const [
                  Icon(Icons.person_outline, size: 18, color: Colors.orange),
                  SizedBox(width: 4),
                  Text('4'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // temps / difficulté etc.
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              _InfoChip(icon: Icons.schedule, label: '20 min'),
              SizedBox(width: 8),
              _InfoChip(icon: Icons.access_time, label: '10 min'),
              SizedBox(width: 8),
              _InfoChip(icon: Icons.local_fire_department_outlined, label: '5 min'),
            ],
          ),
          const SizedBox(height: 12),
          // tags (avec ton TagList)
          TagList(
            selected: tagsMock[0],
            tags: tagsMock,
            onChanged: (_) {},
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.orange),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
