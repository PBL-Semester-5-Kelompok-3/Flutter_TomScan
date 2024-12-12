import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InformatifsModel extends Equatable {
  final int id;
  final String title;
  final String type;
  final String content;
  final String imageUrl;

  const InformatifsModel({
    required this.id,
    required this.title,
    required this.type,
    required this.content,
    required this.imageUrl,
  });

  factory InformatifsModel.fromJson(Map<String, dynamic> json) {
    return InformatifsModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      content: json['content'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'content': content,
      'image_url': imageUrl,
    };
  }

  InformatifsModel copyWith({
    int? id,
    String? title,
    String? type,
    String? content,
    String? imageUrl,
  }) {
    return InformatifsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, title, type, content, imageUrl];
}

class ArticleCardModel extends Equatable {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const ArticleCardModel({
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });

  @override
  List<Object?> get props => [imageUrl, title, onTap];
}

class EducationCardModel extends Equatable {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const EducationCardModel({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  List<Object?> get props => [icon, title, onTap];
}
