import 'dart:convert';

import 'dart:core';

class Question {
  final String question;
  final String imageUrl;
  final List<String> answers;

  Question(
    this.question,
    this.imageUrl,
    this.answers,
  );

  factory Question.fromMap(Map<String, dynamic> questMap) => Question(
        questMap['question'],
        questMap['imageUrl'],
        questMap['answers'],
      );

  factory Question.fromJson(String jsonString) => Question.fromMap(json.decode(jsonString));

  Map<String, dynamic> toMap() {
    final jsonMap = Map<String, dynamic>();
    jsonMap['question'] = question;
    jsonMap['imageUrl'] = imageUrl;
    jsonMap['answers'] = answers;
    return jsonMap;
  }

  String toJson() => json.encode(toMap());

}
