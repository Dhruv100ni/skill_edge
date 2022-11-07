// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuizModel {
  final String id;
  final String question;
  final String A;
  final String B;
  final String C;
  final String D;
  final String ans;
  QuizModel({
    required this.id,
    required this.question,
    required this.A,
    required this.B,
    required this.C,
    required this.D,
    required this.ans,
  });

  QuizModel copyWith({
    String? id,
    String? question,
    String? A,
    String? B,
    String? C,
    String? D,
    String? ans,
  }) {
    return QuizModel(
      id: id ?? this.id,
      question: question ?? this.question,
      A: A ?? this.A,
      B: B ?? this.B,
      C: C ?? this.C,
      D: D ?? this.D,
      ans: ans ?? this.ans,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'A': A,
      'B': B,
      'C': C,
      'D': D,
      'ans': ans,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map['id'] as String,
      question: map['question'] as String,
      A: map['A'] as String,
      B: map['B'] as String,
      C: map['C'] as String,
      D: map['D'] as String,
      ans: map['ans'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizModel(id: $id, question: $question, A: $A, B: $B, C: $C, D: $D, ans: $ans)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.question == question &&
      other.A == A &&
      other.B == B &&
      other.C == C &&
      other.D == D &&
      other.ans == ans;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      question.hashCode ^
      A.hashCode ^
      B.hashCode ^
      C.hashCode ^
      D.hashCode ^
      ans.hashCode;
  }
}
