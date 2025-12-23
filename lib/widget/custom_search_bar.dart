import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/model/recipe.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.recipes,
    required this.onSearchResultTap,
    this.prefixIcon = Icons.search,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.hintText = 'Rechercher…',
  });

  final TextEditingController searchController;
  final List<Recipe> recipes;
  final VoidCallback onSearchResultTap;
  final IconData prefixIcon;
  final Color backgroundColor;
  final String hintText;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late FocusNode _focusNode;
  List<Recipe> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.searchController.addListener(_updateSuggestions);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.searchController.removeListener(_updateSuggestions);
    super.dispose();
  }

  void _updateSuggestions() {
    final q = widget.searchController.text.toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _suggestions = [];
        _showSuggestions = false;
      } else {
        _suggestions = widget.recipes
            .where((e) => e.name.toLowerCase().contains(q))
            .take(5)
            .toList();
        _showSuggestions = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon, color: AppColors.yellowPrimary),
            hintStyle: TextStyle(color: AppColors.lightGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: widget.backgroundColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        if (_showSuggestions && _suggestions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border(
                left: BorderSide(color: Colors.grey.shade300),
                right: BorderSide(color: Colors.grey.shade300),
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final recipe = _suggestions[index];
                return ListTile(
                  title: Text(recipe.name),
                  onTap: () {
                    widget.searchController.text = recipe.name;
                    _focusNode.unfocus();
                    setState(() => _showSuggestions = false);
                    widget.onSearchResultTap();
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
