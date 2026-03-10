import 'dart:io';

import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';

class CreateRecipeListForm {
  // ----------------------------
  // MAIN INFO
  // ----------------------------
  String name;
  String description;

  VisibilityStateEnum visibilityState;

  File? image; // Fichier local temporaire
  String? imageUrl; // URL de l'image uploadée

  CreateRecipeListForm({
    this.name = '',
    this.description = '',
    this.visibilityState = VisibilityStateEnum.privateState,
    this.image,
    this.imageUrl,
  });
}
