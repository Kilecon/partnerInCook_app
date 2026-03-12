import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/api/utensil.dart';

class UstensilContent extends StatefulWidget {
  final List<Utensil> utensils;
  const UstensilContent({super.key, required this.utensils});

  @override
  State<UstensilContent> createState() => _UstensilContentState();
}

class _UstensilContentState extends State<UstensilContent> {
  late final List<bool> _checked;

  @override
  void initState() {
    super.initState();
    _checked = List.filled(widget.utensils.length, false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.utensils.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Aucun ustensile', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < widget.utensils.length; i++) ...[
          _UstensilRow(
            utensil: widget.utensils[i],
            checked: _checked[i],
            onChanged: (v) => setState(() => _checked[i] = v ?? false),
          ),
          if (i < widget.utensils.length - 1)
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
        ],
      ],
    );
  }
}

class _UstensilRow extends StatelessWidget {
  const _UstensilRow({
    required this.utensil,
    required this.checked,
    required this.onChanged,
  });

  final Utensil utensil;
  final bool checked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Checkbox identique aux ingrédients
          SizedBox(
            width: 32,
            height: 32,
            child: Checkbox(
              value: checked,
              onChanged: onChanged,
              activeColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(color: Color(0xFFCCCCCC)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 10),
          // Nom de l'ustensile
          Expanded(
            child: Text(
              utensil.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                decoration: checked ? TextDecoration.lineThrough : null,
                color: checked ? Colors.grey : Colors.black87,
              ),
            ),
          ),
          // Image de l'ustensile (style boîte carrée)
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.lightOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: utensil.iconPictureUrl != null
                ? Image.network(
                    utensil.iconPictureUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const _PlaceholderIcon(),
                  )
                : const _PlaceholderIcon(),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.kitchen_outlined,
        size: 22,
        color: AppColors.primaryOrange,
      ),
    );
  }
}