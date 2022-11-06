// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String field;
  final String branch;
  final String image;
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.field,
    required this.branch,
    required this.image,
  });

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? field,
    String? branch,
    String? image,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      field: field ?? this.field,
      branch: branch ?? this.branch,
      image: image ?? this.image,
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
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      field: map['field'] as String,
      branch: map['branch'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(id: $id, title: $title, description: $description, field: $field, branch: $branch, image: $image)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.field == field &&
        other.branch == branch &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        field.hashCode ^
        branch.hashCode ^
        image.hashCode;
  }
}
