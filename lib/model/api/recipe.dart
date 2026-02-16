import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/model/api/step.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/model/api/utensil.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/recipe_ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String? description;
  final VisibilityStateEnum visibilityState;
  final int? preparationTime;
  final int? restTime;
  final int? cookTime;
  final bool isFavorite;
  final int portions;
  final String? pictureUrl;
  final LightUser author;
  final List<Tag> tags;
  final List<Step> steps;
  final List<Utensil> utensils;
  final List<RecipeIngredient> recipeIngredients;
  final int notationsCount;
  final double averageNotation;

  Recipe({
    required this.id,
    required this.name,
    this.description,
    required this.visibilityState,
    this.preparationTime,
    this.restTime,
    this.cookTime,
    required this.isFavorite,
    required this.portions,
    this.pictureUrl,
    required this.author,
    required this.tags,
    required this.steps,
    required this.utensils,
    required this.recipeIngredients,
    required this.notationsCount,
    required this.averageNotation,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      visibilityState: visibilityStateFromJson(json['state'] as String),
      preparationTime: json['preparation_time'] as int?,
      restTime: json['rest_time'] as int?,
      cookTime: json['cook_time'] as int?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      portions: json['portions'] as int,
      pictureUrl: json['pic_url'] as String?,
      author: LightUser.fromJson(json['author']),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e))
          .toList(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Step.fromJson(e))
          .toList(),
      utensils: (json['utensils'] as List<dynamic>)
          .map((e) => Utensil.fromJson(e))
          .toList(),
      recipeIngredients: (json['recipe_ingredients'] as List<dynamic>)
          .map((e) => RecipeIngredient.fromJson(e))
          .toList(),
      notationsCount: json['notation_count'] as int,
      averageNotation: (json['average_notation'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'state': visibilityStateToJson(visibilityState),
      'preparation_time': preparationTime,
      'rest_time': restTime,
      'cook_time': cookTime,
      'is_favorite': isFavorite,
      'portions': portions,
      'pic_url': pictureUrl,
      'author': author.toJson(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'steps': steps.map((e) => e.toJson()).toList(),
      'utensils': utensils.map((e) => e.toJson()).toList(),
      'recipe_ingredients': recipeIngredients.map((e) => e.toJson()).toList(),
      'notation_count': notationsCount,
      'average_notation': averageNotation,
    };
  }

  LightRecipe toLightRecipe() {
    int? globalTime;
    if (preparationTime != null || restTime != null || cookTime != null) {
      globalTime = (preparationTime ?? 0) + (restTime ?? 0) + (cookTime ?? 0);
    }

    return LightRecipe(
      id: id,
      name: name,
      globalTime: globalTime,
      isFavorite: isFavorite,
      pictureUrl: pictureUrl,
      author: author,
      notationsCount: notationsCount,
      averageNotation: averageNotation,
      tags: tags,
    );
  }
}

extension RecipeListExtension on List<Recipe> {
  List<LightRecipe> toLightRecipes() {
    return map((recipe) => recipe.toLightRecipe()).toList();
  }
}
