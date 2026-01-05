import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/custom_search_bar.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({
    super.key,
    required this.hasSearchBar,
    required this.title,
    required this.subtitle,
    this.searchController,
    this.data,
    this.onSearchResultTap,
  });

  final bool hasSearchBar;
  final String title;
  final String subtitle;
  final TextEditingController? searchController;
  final List<dynamic>? data;
  final VoidCallback? onSearchResultTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryOrange,
                ),
              ),
              if (hasSearchBar)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CustomSearchBar(
                    backgroundColor: Colors.transparent,
                    searchController: searchController!,
                    hintText: 'Rechercher une recette...',
                    prefixIcon: LucideIcons.search,
                    data: data!,
                    onSearchResultTap: onSearchResultTap!,
                  ),
                )
              else
                const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
