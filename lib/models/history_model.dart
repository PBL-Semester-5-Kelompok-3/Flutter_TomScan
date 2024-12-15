class History {
  final int id;
  final int idUser;
  final int idDisease;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  History({
    required this.id,
    required this.idUser,
    required this.idDisease,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      idUser: json['id_user'],
      idDisease: json['id_disease'],
      imagePath: json['image_path'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'id_disease': idDisease,
      'image_path': imagePath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
