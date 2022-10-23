import 'dart:convert';

class ArticleModel {
  final int id;     // id
  final String title;     // title
  final String tldr;      // tldr
  final String content;   // content
  final String image;
  final String rating;   // image
  
  ArticleModel(
    this.id,
    this.title,
    this.tldr,
    this.content,
    this.image,
    this.rating
  );

  ArticleModel copyWith({
    int? id,
    String? title,
    String? tldr,
    String? content,
    String? image,
    String? rating,
  }) {
    return ArticleModel(
      id ?? this.id,
      title ?? this.title,
      tldr ?? this.tldr,
      content ?? this.content,
      image ?? this.image,
      rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'tldr': tldr,
      'content': content,
      'image': image,
      'rating': rating,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      map['id'] as int,
      map['title'] as String,
      map['tldr'] as String,
      map['content'] as String,
      map['image'] as String,
      map['rating'] as String,
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
