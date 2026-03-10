import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/model/api/light_user.dart';

class RecipeList {
  final String id;
  final String name;
  final String? description;
  final VisibilityStateEnum visibilityState;
  final LightUser author;
  List<LightRecipe> recipes;
  final List<LightUser> members;
  final String? pictureUrl;
  final bool isFavorite;

  RecipeList({
    required this.id,
    required this.name,
    this.description,
    required this.visibilityState,
    required this.author,
    required this.recipes,
    required this.members,
    this.pictureUrl,
    required this.isFavorite,
  });

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    return RecipeList(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      visibilityState: visibilityStateFromJson(json['state'] as String), 
      author: json['author'] != null ? LightUser.fromJson(json['author']) : LightUser(id: '', username: "inconnu"),
      recipes: (json['recipes'] as List<dynamic>)
          .map((e) => LightRecipe.fromJson(e))
          .toList(),
      members: (json['members'] as List<dynamic>)
          .map((e) => LightUser.fromJson(e))
          .toList(),
      pictureUrl: json['pic_url'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'state': visibilityStateToJson(visibilityState),
      'author': author.toJson(),
      'recipes': recipes.map((e) => e.toJson()).toList(),
      'members': members.map((e) => e.toJson()).toList(),
      'pic_url': pictureUrl,
      'is_favorite': isFavorite,
    };
  }
}