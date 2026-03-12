class Step {
  final String id;
  final String description;
  final int order;
  final String recipeId;

  Step({
    required this.id,
    required this.description,
    required this.order,
    required this.recipeId,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      id: json['id'] as String,
      description: json['description'] as String,
      order: json['order'] as int,
      recipeId: json['recipe_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'order': order,
      'recipe_id': recipeId,
    };
  }
}

class StepCreateRequest {
  String? id; // ID de l'étape (peut être null pour les nouvelles étapes)
  final String description;
  final int order;
  final String recipeId;

  StepCreateRequest({
    this.id,
    required this.description,
    required this.order,
    required this.recipeId,
  });

  factory StepCreateRequest.fromJson(Map<String, dynamic> json) {
    return StepCreateRequest(
      description: json['description'] as String,
      order: json['order'] as int,
      recipeId: json['recipe_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'order': order, 'recipe_id': recipeId};
  }
}
