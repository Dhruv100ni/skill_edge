// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseModel {
  final int id;
  final String title;
  final String description;
  final List<Map> chapters;
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.chapters,
  });

  CourseModel copyWith({
    int? id,
    String? title,
    String? description,
    List<Map>? chapters,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      chapters: chapters ?? this.chapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'chapters': chapters,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      chapters: List<Map>.from(
        (map['chapters'] as List<dynamic>).map<Map>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(id: $id, title: $title, description: $description, chapters: $chapters)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.chapters, chapters);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        chapters.hashCode;
  }
}
