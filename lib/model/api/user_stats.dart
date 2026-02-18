class UserStats {
  int createdRecipesCount;
  int linkedRecipelists;
  int favoritesRecipesCount;
  String idFavorite;

  UserStats({
    required this.createdRecipesCount,
    required this.linkedRecipelists,
    required this.favoritesRecipesCount,
    required this.idFavorite,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      createdRecipesCount: json['created_recipes_count'] as int? ?? 0,
      linkedRecipelists: json['linked_recipelists'] as int? ?? 0,
      favoritesRecipesCount: json['favorites_recipes_count'] as int? ?? 0,
      idFavorite: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_recipes_count': createdRecipesCount,
      'linked_recipelists': linkedRecipelists,
      'favorites_recipes_count': favoritesRecipesCount,
      'id_favorite': idFavorite,
    };
  }
}
