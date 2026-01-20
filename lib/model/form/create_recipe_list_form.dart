import 'dart:io';

import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/model/api/step.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/model/api/utensil.dart';
import 'package:partner_in_cook/model/form/create_recipe_ingredient_form.dart';

class CreateRecipeListForm {
  // ----------------------------
  // MAIN INFO
  // ----------------------------
  String name;
  String description;

  VisibilityStateEnum visibilityState;

  File? image; // path / url temporaire

  CreateRecipeListForm({
    this.name = '',
    this.description = '',
    this.visibilityState = VisibilityStateEnum.privateState,
    List<CreateRecipeIngredient>? ingredients,
    List<Step>? steps,
    List<Utensil>? utensils,
    List<Tag>? tags,
    this.image,
  }) ;
}
