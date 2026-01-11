import 'dart:io';

import 'package:partner_in_cook/model/api/step.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/model/api/utensil.dart';
import 'package:partner_in_cook/model/form/create_recipe_ingredient_form.dart';

class CreateRecipeForm {
  // ----------------------------
  // MAIN INFO
  // ----------------------------
  String name;
  String description;
  int portions;

  int preparationTime;
  int restTime;
  int cookTime;

  bool isPublic;

  // ----------------------------
  // CONTENT
  // ----------------------------
  List<CreateRecipeIngredient> ingredients;
  List<Step> steps;
  List<Utensil> utensils;

  // ----------------------------
  // META
  // ----------------------------
  List<Tag> tags;
  File? image; // path / url temporaire

  CreateRecipeForm({
    this.name = '',
    this.description = '',
    this.portions = 1,
    this.preparationTime = 0,
    this.restTime = 0,
    this.cookTime = 0,
    this.isPublic = true,
    List<CreateRecipeIngredient>? ingredients,
    List<Step>? steps,
    List<Utensil>? utensils,
    List<Tag>? tags,
    this.image,
  }) : ingredients = ingredients ?? [],
       steps = steps ?? [],
       utensils = utensils ?? [],
       tags = tags ?? [];
}
