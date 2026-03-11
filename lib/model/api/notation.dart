class NotationCreateRequest {
  final int notation;
  final String userId;
  final String recipeId;

  NotationCreateRequest({
    required this.notation,
    required this.userId,
    required this.recipeId,
  });

  factory NotationCreateRequest.fromJson(Map<String, dynamic> json) {
    return NotationCreateRequest(
      notation: json['notation'] as int,
      userId: json['user_id'] as String,
      recipeId: json['recipe_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notation': notation,
      'user_id': userId,
      'recipe_id': recipeId,
    };
  }
}

