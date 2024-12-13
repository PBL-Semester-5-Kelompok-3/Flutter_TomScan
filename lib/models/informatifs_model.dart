import 'dart:convert';

class Informative {
  final int id;
  final String title;
  final String type;
  final String content;
  final String image;
  final DateTime createdAt;

  Informative({
    required this.id,
    required this.title,
    required this.type,
    required this.content,
    required this.image,
    required this.createdAt,
  });

  factory Informative.fromJson(Map<String, dynamic> json) {
    return Informative(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      content: json['content'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class PestAndDisease {
  final int id;
  final String name;
  final String description;
  final String warning;
  final String genus;
  final String scientificName;
  final String aliases;
  final String symptoms;
  final List<String> solutions;
  final String source;

  PestAndDisease({
    required this.id,
    required this.name,
    required this.description,
    required this.warning,
    required this.genus,
    required this.scientificName,
    required this.aliases,
    required this.symptoms,
    required this.solutions,
    required this.source,
  });

  factory PestAndDisease.fromJson(Map<String, dynamic> json) {
    return PestAndDisease(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      warning: json['warning'],
      genus: json['genus'],
      scientificName: json['scientific_name'],
      aliases: json['aliases'],
      symptoms: json['symptoms'],
      solutions: List<String>.from(jsonDecode(json['solutions'])),
      source: json['source'],
    );
  }
}
