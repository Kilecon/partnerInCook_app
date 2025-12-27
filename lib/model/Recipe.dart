import 'package:partner_in_cook/common/config/constants/state_enum.dart';
import 'package:partner_in_cook/model/step.dart';
import 'package:partner_in_cook/model/tag.dart';
import 'package:partner_in_cook/model/utensil.dart';
import 'package:partner_in_cook/model/light_user.dart';
import 'package:partner_in_cook/model/recipe_ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String? description;
  final State state;
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
    required this.state,
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
      state: stateFromJson(json['state'] as String),
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
      'state': stateToJson(state),
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
      'recipe_ingredients':
          recipeIngredients.map((e) => e.toJson()).toList(),
      'notation_count': notationsCount,
      'average_notation': averageNotation,
    };
  }
}
