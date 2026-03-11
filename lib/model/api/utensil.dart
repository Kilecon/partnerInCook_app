class Utensil {
  final String id;
  final String name;
  final String? iconPictureUrl;

  Utensil({
    required this.id,
    required this.name,
    this.iconPictureUrl,
  });

  factory Utensil.fromJson(Map<String, dynamic> json) {
    return Utensil(
      id: json['id'] as String,
      name: json['name'] as String,
      iconPictureUrl: json['pic_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic_url': iconPictureUrl,
    };
  }
}

class UtensilCreateRequest {
  final String name;
  final String? iconPictureUrl;

  UtensilCreateRequest({
    required this.name,
    this.iconPictureUrl,
  });

  factory UtensilCreateRequest.fromJson(Map<String, dynamic> json) {
    return UtensilCreateRequest(
      name: json['name'] as String,
      iconPictureUrl: json['pic_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pic_url': iconPictureUrl,
    };
  }
}
