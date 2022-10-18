// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArticleModel {
  final int id;
  final String title;
  final String tldr;
  final String content;
  final String image;

  ArticleModel(
    this.id,
    this.title,
    this.tldr,
    this.content,
    this.image,
  );

  ArticleModel copyWith({
    int? id,
    String? title,
    String? tldr,
    String? content,
    String? image,
  }) {
    return ArticleModel(
      id ?? this.id,
      title ?? this.title,
      tldr ?? this.tldr,
      content ?? this.content,
      image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'tldr': tldr,
      'content': content,
      'image': image,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      map['id'] as int,
      map['title'] as String,
      map['tldr'] as String,
      map['content'] as String,
      map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArticleModel(id: $id, title: $title, tldr: $tldr, content: $content, image: $image)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.tldr == tldr &&
        other.content == content &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        tldr.hashCode ^
        content.hashCode ^
        image.hashCode;
  }
}
