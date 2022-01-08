import 'dart:convert';
import 'package:quizapp/utils/models/models.dart';

class Subject {
  final List<Question> questions;
  final String subject;

  Subject(
    this.subject,
    this.questions,
  );

  Question get(int number) => questions[number - 1];

  factory Subject.fromList(String subject, List<String> questions) {
    List<Question> questionList = [];
    questions.forEach((question) {
      questionList.add(Question.fromJson(question));
    });
    return Subject(subject, questionList);
  }

  factory Subject.fromJson(String subject, String jsonString) {
    final decoded = json.decode(jsonString);

    List<dynamic> list = decoded['questions'];
    List<Question> questions = [];
    list.forEach((question) {
      questions.add(Question.fromMap(question));
    });
    return Subject(subject, questions);
  }
}
