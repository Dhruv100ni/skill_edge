// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChapterModel {
  final int id;
  final String title;
  final List<Map> videos;
  ChapterModel({
    required this.id,
    required this.title,
    required this.videos,
  });

  ChapterModel copyWith({
    int? id,
    String? title,
    List<Map>? videos,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      title: title ?? this.title,
      videos: videos ?? this.videos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'videos': videos,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'] as int,
      title: map['title'] as String,
      videos: List<Map>.from(
        (map['videos'] as List<dynamic>).map<Map>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterModel.fromJson(String source) =>
      ChapterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChapterModel(id: $id, title: $title, videos: $videos)';

  @override
  bool operator ==(covariant ChapterModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.videos, videos);
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ videos.hashCode;
}
