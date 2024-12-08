class SignUpFormModel {
  final String? username;
  final String? email;
  final String? password;

  SignUpFormModel({
    this.username,
    this.email,
    this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    }..removeWhere((key, value) => value == null);
  }
}
