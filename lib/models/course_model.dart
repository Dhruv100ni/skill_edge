// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseModel {
  final int id;
  final String title;
  final String description;
  final String field;
  final String branch;
  final String image;
  final List<Map> chapters;
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.field,
    required this.branch,
    required this.image,
    required this.chapters,
  });

  CourseModel copyWith({
    int? id,
    String? title,
    String? description,
    String? field,
    String? branch,
    String? image,
    List<Map>? chapters,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      field: field ?? this.field,
      branch: branch ?? this.branch,
      image: image ?? this.image,
      chapters: chapters ?? this.chapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'field': field,
      'branch': branch,
      'image': image,
      'chapters': chapters,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      field: map['field'] as String,
      branch: map['branch'] as String,
      image: map['image'] as String,
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
    return 'CourseModel(id: $id, title: $title, description: $description, field: $field, branch: $branch, image: $image, chapters: $chapters)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.field == field &&
        other.branch == branch &&
        other.image == image &&
        listEquals(other.chapters, chapters);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        field.hashCode ^
        branch.hashCode ^
        image.hashCode ^
        chapters.hashCode;
  }
}
