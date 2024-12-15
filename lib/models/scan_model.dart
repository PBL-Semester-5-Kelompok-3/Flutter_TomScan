// scan_model.dart
class ScanModel {
  final String disease;
  final List<Schedule> schedule;
  final List<Solution> solutions;
  final List<Pest> pest;

  ScanModel({
    required this.disease,
    required this.schedule,
    required this.solutions,
    required this.pest,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      disease: json['disease'],
      schedule:
          (json['schedule'] as List).map((e) => Schedule.fromJson(e)).toList(),
      solutions:
          (json['solutions'] as List).map((e) => Solution.fromJson(e)).toList(),
      pest: (json['pest'] as List).map((e) => Pest.fromJson(e)).toList(),
    );
  }
}

class Schedule {
  final String time;
  final String description;

  Schedule({required this.time, required this.description});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'],
      description: json['description'],
    );
  }
}

class Solution {
  final String title;
  final String description;

  Solution({required this.title, required this.description});

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      title: json['title'],
      description: json['description'],
    );
  }
}

class Pest {
  final String name;

  Pest({required this.name});

  factory Pest.fromJson(Map<String, dynamic> json) {
    return Pest(
      name: json['name'],
    );
  }
}
