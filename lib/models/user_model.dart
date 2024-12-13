//user_model.dart
class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? token;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        token: json['token'],
      );
  UserModel copyWith({
    String? username,
    String? email,
    String? password,
  }) =>
      UserModel(
        id: id,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        token: token,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'token': token,
      };
}
