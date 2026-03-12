class User {
  String? userId;
  String? username;
  String? email;
  String? password;
  String? profilePicture;

  User({
    this.userId,
    this.username,
    this.email,
    this.password,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      profilePicture: json['pic_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'id': userId,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (profilePicture != null) 'pic_url': profilePicture,
    };
  }
}

class UserUpdateRequest {
  String? username;
  String? email;
  String? profilePicture;

  UserUpdateRequest({
    this.username,
    this.email,
    this.profilePicture,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) {
    return UserUpdateRequest(
      username: json['username'] as String?,
      email: json['email'] as String?,
      profilePicture: json['pic_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (profilePicture != null) 'pic_url': profilePicture,
    };
  }
}