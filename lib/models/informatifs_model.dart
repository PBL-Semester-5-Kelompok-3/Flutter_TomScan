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
