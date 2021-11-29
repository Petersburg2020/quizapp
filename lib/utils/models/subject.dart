import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizapp/utils/models/models.dart';

class Subject {
  final List<Question> questions;
  final String subject;

  Subject(
    this.questions,
    this.subject,
  );

  Question get(int number) => questions[number - 1];

  factory Subject.fromList(String subject, List<String> questions) {
    List<Question> questionList = [];
    questions.forEach((question) {
      questionList.add(Question.fromJson(question));
    });
    return Subject(questionList, subject);
  }

  factory Subject.fromFile(String subject, String jsonFile) {
    
  }

  factory Subject.fromJson(String subject, String jsonString) {
    List<dynamic> list = json.decode(jsonString);
    List<Question> questions = [];
    list.forEach((question) {
      questions.add(Question.fromMap(question));
    });
    return Subject(
      questions,
      subject,
    );
  }

}
