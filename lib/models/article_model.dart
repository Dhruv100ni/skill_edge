// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArticleModel {
  final String id; // id
  final String courseID;
  final String title; // title
  final String tldr; // tldr
  final String content; // content
  final String image;
  final String rating; // image
  ArticleModel({
    required this.id,
    required this.courseID,
    required this.title,
    required this.tldr,
    required this.content,
    required this.image,
    required this.rating,
  });

  ArticleModel copyWith({
    String? id,
    String? courseID,
    String? title,
    String? tldr,
    String? content,
    String? image,
    String? rating,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      courseID: courseID ?? this.courseID,
      title: title ?? this.title,
      tldr: tldr ?? this.tldr,
      content: content ?? this.content,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseID': courseID,
      'title': title,
      'tldr': tldr,
      'content': content,
      'image': image,
      'rating': rating,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] as String,
      courseID: map['courseID'] as String,
      title: map['title'] as String,
      tldr: map['tldr'] as String,
      content: map['content'] as String,
      image: map['image'] as String,
      rating: map['rating'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArticleModel(id: $id, courseID: $courseID, title: $title, tldr: $tldr, content: $content, image: $image, rating: $rating)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.courseID == courseID &&
        other.title == title &&
        other.tldr == tldr &&
        other.content == content &&
        other.image == image &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        courseID.hashCode ^
        title.hashCode ^
        tldr.hashCode ^
        content.hashCode ^
        image.hashCode ^
        rating.hashCode;
  }
}
