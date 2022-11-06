// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChapterModel {
  final String id;
  final String title;
  ChapterModel({
    required this.id,
    required this.title,
  });

  ChapterModel copyWith({
    String? id,
    String? title,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterModel.fromJson(String source) =>
      ChapterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChapterModel(id: $id, title: $title)';

  @override
  bool operator ==(covariant ChapterModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
