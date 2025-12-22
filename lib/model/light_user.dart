class LightUser {
  final String id;
  final String username;
  final String? profilePictureUrl;

  LightUser({
    required this.id,
    required this.username,
    this.profilePictureUrl,
  });

  factory LightUser.fromJson(Map<String, dynamic> json) {
    return LightUser(
      id: json['id'] as String,
      username: json['username'] as String,
      profilePictureUrl: json['profile_pic'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_pic': profilePictureUrl,
    };
  }
}
