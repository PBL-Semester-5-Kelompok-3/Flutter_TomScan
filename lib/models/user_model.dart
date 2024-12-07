class User {
  final String id;
  final String email;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.name,
  });

  // Factory constructor untuk membuat objek User dari Map<String, dynamic>
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      name: map['name'],
      id: '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
