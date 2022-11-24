// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompanyQuesModel {
  final String id;
  final String question;
  final String ans;
  CompanyQuesModel({
    required this.id,
    required this.question,
    required this.ans,
  });

  CompanyQuesModel copyWith({
    String? id,
    String? question,
    String? ans,
  }) {
    return CompanyQuesModel(
      id: id ?? this.id,
      question: question ?? this.question,
      ans: ans ?? this.ans,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'ans': ans,
    };
  }

  factory CompanyQuesModel.fromMap(Map<String, dynamic> map) {
    return CompanyQuesModel(
      id: map['id'] as String,
      question: map['question'] as String,
      ans: map['ans'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyQuesModel.fromJson(String source) => CompanyQuesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompanyQuesModel(id: $id, question: $question, ans: $ans)';

  @override
  bool operator ==(covariant CompanyQuesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.question == question &&
      other.ans == ans;
  }

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ ans.hashCode;
}
