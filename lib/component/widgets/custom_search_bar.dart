import 'package:flutter/material.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.data,
    required this.onSearchResultTap,
    this.prefixIcon = Icons.search,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.hintText = 'Rechercher…',
  });

  final TextEditingController searchController;
  final List<dynamic> data;
  final VoidCallback onSearchResultTap;
  final IconData prefixIcon;
  final Color backgroundColor;
  final String hintText;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late FocusNode _focusNode;
  List<dynamic> _suggestions = [];
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
        _suggestions = widget.data
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
                final item =
                    _suggestions[index]; // 'item' est plus juste que 'recipe' ici

                // On vérifie si l'objet possède une propriété 'unit' (cas des Ingrédients)
                // Sinon on ne met rien ou une chaîne vide.
                String? subtitleText;
                try {
                  // On tente de lire l'unité, si ça n'existe pas, on catch l'erreur
                  subtitleText = item.unit;
                } catch (e) {
                  subtitleText = null;
                }

                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryOrange.withOpacity(0.1),
                    ),
                    child:
                        item.iconPictureUrl != null &&
                            item.iconPictureUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.iconPictureUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.restaurant,
                                    color: AppColors.primaryOrange,
                                  ),
                            ),
                          )
                        : Icon(
                            Icons.restaurant,
                            color: AppColors.primaryOrange,
                          ),
                  ),
                  title: Text(item.name),
                  // ON N'AFFICHE LE SUBTITLE QUE S'IL Y A UNE UNITÉ
                  subtitle: subtitleText != null ? Text(subtitleText) : null,
                  onTap: () {
                    widget.searchController.text = item.name;
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
