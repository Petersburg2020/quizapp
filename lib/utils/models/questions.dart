import 'dart:convert';
import 'package:quizapp/utils/utils.dart';

class Questions {
  List<Subject> subjects = [];
  List<Question> questions = [];
  Map<String, Subject> _subjects = {};

  Quiz _quiz;

  Questions() {
    _update();
  }

  void _update() {
    final jsonText = '{"questions": [' +
    '{"question": "What is 48,879 in hexadecimal?", "subject": "mathematics", "imageUrl": "", "answer": 1, "options": ["0x18C1", "0xBEEF", "0xDEAD", "0x12D591"]},' +
    '{"question": "What is 65 times 52?", "subject": "mathematics", "imageUrl": "", "answer": 3, "options": ["117", "3120", "3380", "3520"]},' +
    '{"question": "How hot is the surface of the sun?", "subject": "general", "imageUrl": "", "answer": 1, "options": ["1,233 K", "5,778 K", "12,130 K", "101,300 K"]},' +
    '{"question": "What is the scientific name 0f a butterfly?", "subject": "science", "imageUrl": "images/butterfly.jpg", "answer": 3, "options": ["Apis", "Coleoptera", "Formicidae", "Rhopalocera"]},' +
    '{"question": "What is the capital of Spain?", "subject": "general", "imageUrl": "images/spain.jpeg", "answer": 2, "options": ["Berlin", "Madrid", "Barcelona", "San Juan"]},' +
    '{"question": "What is 70 degrees Fahrenheit in Celsius?", "subject": "science", "imageUrl": "images/thermometer.jpeg", "answer": 4, "options": ["18.8889", "158", "21.1111", "20"]},' +
    '{"question": "How tall is Mount Everest?", "subject": "general", "imageUrl": "images/everest.jpeg", "answer": 3, "options": ["6,683 ft (2,037 m)", "7,918 ft (2,413 m)", "19,341 ft (5,895 m)", "29,029 ft (8,847 m)"]},' +
    '{"question": "How far is the moon from Earth?", "subject": "general", "imageUrl": "images/moon_earth.jpeg", "answer": 2, "options": ["7,918 miles (12,742 km)", "86,681 miles (139,822 km)", "238,400 miles (384,400 km)", "35,980,000 miles (57,910,00 km)"]}]}';
  
    // print('Json Text: ' + jsonText);
    final decoded = json.decode(jsonText);
    List<dynamic> questions = decoded['questions'];
    Map<String, List<Question>> _allQuestions = {};

    questions.forEach((question) {
      String subject = question['subject'];
      String quest = question['question'];
      String imageUrl = question['imageUrl'];
      int answer = question['answer'];
      List<dynamic> opts = question['options'];
      List<String> options = [];
      opts.forEach((option) => options.add(option));

      Question q = Question(quest, imageUrl, answer, options);
      this.questions.add(q);

      if (_allQuestions[subject] == null)
        _allQuestions[subject] = [q];
      else
        _allQuestions[subject].add(q);
    });

    _allQuestions.forEach(
        (subject, questions) => subjects.add(Subject(subject, questions)));
    subjects.forEach((e) => _subjects[e.subject] = e);
    _quiz = Quiz(subjects, []);
  }

  Subject getSubject(String subject) => _subjects[subject];

  Quiz getQuiz() => _quiz;
}

Questions questions = Questions();

Quiz quiz = questions.getQuiz();

Subject mathematics = questions.getSubject('mathematics');

Future<void> load() async {

}
