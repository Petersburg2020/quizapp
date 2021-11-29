import 'package:quizapp/utils/models/models.dart';

class Quiz {
  final List<Question> questions;

  Quiz(this.questions);


  int size() => questions.length;
  Question get(int number) => questions[number - 1];

}