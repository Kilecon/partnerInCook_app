class Ingredient {
  final String id;
  final String name;
  final String unit;
  final double? density;
  final String? userId;
  final String? iconPictureUrl;

  Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    this.density,
    this.userId,
    this.iconPictureUrl,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      density: (json['density'] as num).toDouble(),
      userId: json['user_id'] == null ? null : json['user_id'] as String,
      iconPictureUrl: json['pic_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'density': density,
      'user_id': userId,
      'pic_url': iconPictureUrl,
    };
  }
}
