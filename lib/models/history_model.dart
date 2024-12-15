class History {
  final int id;
  final int idUser;
  final int idDisease;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Disease disease;
  final List<Schedule> schedule;
  final List<Solution> solutions;
  final List<Pest> pest;

  History({
    required this.id,
    required this.idUser,
    required this.idDisease,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.disease,
    required this.schedule,
    required this.solutions,
    required this.pest,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['history']['id'],
      idUser: json['history']['id_user'],
      idDisease: json['history']['id_disease'],
      imagePath: json['history']['image_path'],
      createdAt: DateTime.parse(json['history']['created_at']),
      updatedAt: DateTime.parse(json['history']['updated_at']),
      user: User.fromJson(json['history']['user']),
      disease: Disease.fromJson(json['history']['disease']),
      schedule: (json['schedule'] as List)
          .map((scheduleJson) => Schedule.fromJson(scheduleJson))
          .toList(),
      solutions: (json['solutions'] as List)
          .map((solutionJson) => Solution.fromJson(solutionJson))
          .toList(),
      pest: (json['pest'] as List)
          .map((pestJson) => Pest.fromJson(pestJson))
          .toList(),
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
      'user': user.toJson(),
      'disease': disease.toJson(),
      'schedule': schedule.map((e) => e.toJson()).toList(),
      'solutions': solutions.map((e) => e.toJson()).toList(),
      'pest': pest.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String? profilePicture;
  final String email;

  User({
    required this.id,
    required this.username,
    this.profilePicture,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      profilePicture: json['profile_picture'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_picture': profilePicture,
      'email': email,
    };
  }
}

class Disease {
  final int id;
  final String name;

  Disease({required this.id, required this.name});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Schedule {
  final int id;
  final String description;
  final int idDisease;

  Schedule({
    required this.id,
    required this.description,
    required this.idDisease,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      description: json['keterangan'],
      idDisease: json['id_disease'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'keterangan': description,
      'id_disease': idDisease,
    };
  }
}

class Solution {
  final int id;
  final String title;
  final String description;
  final int idDisease;

  Solution({
    required this.id,
    required this.title,
    required this.description,
    required this.idDisease,
  });

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      id: json['id'],
      title: json['title'],
      description: json['keterangan_solution'],
      idDisease: json['id_disease'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'keterangan_solution': description,
      'id_disease': idDisease,
    };
  }
}

class Pest {
  final int id;
  final String name;
  final int idDisease;

  Pest({
    required this.id,
    required this.name,
    required this.idDisease,
  });

  factory Pest.fromJson(Map<String, dynamic> json) {
    return Pest(
      id: json['id'],
      name: json['name'],
      idDisease: json['id_disease'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'id_disease': idDisease,
    };
  }
}
