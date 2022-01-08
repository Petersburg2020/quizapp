import 'dart:convert';

import 'dart:core';

class Question {
  final String question;
  final String imageUrl;
  final int answer;
  bool isCorrect = false;
  final List<String> options;

  Question(
    this.question,
    this.imageUrl,
    this.answer,
    this.options,
  );

  factory Question.fromMap(Map<String, dynamic> questMap) => Question(
        questMap['question'],
        questMap['imageUrl'],
        questMap['answer'],
        questMap['options']
      );

  factory Question.fromJson(String jsonString) => Question.fromMap(json.decode(jsonString));

  Map<String, dynamic> toMap() {
    final jsonMap = Map<String, dynamic>();
    jsonMap['question'] = question;
    jsonMap['imageUrl'] = imageUrl;
    jsonMap['answer'] = answer;
    jsonMap['options'] = options;
    return jsonMap;
  }

  void chooseOption(int option) => isCorrect = option == answer;

  String toJson() => json.encode(toMap());

}
