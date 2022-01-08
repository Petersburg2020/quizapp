import 'package:quizapp/utils/models/models.dart';

class Quiz {
  final List<Subject> subjects;
  final List<Player> players;
  List<Question> _allQuestions;
  Map<String, Subject> _subjectMap;
  int _playerIndex;
  int _number;
  Difficulty _difficulty;

  Quiz(
    this.subjects,
    this.players,
  ) {
    final isTrue = update();
    print('Quiz Updated: $isTrue');
    _playerIndex = 1;
    _difficulty = Difficulty.Easy;
  }

  bool update() {
    _subjectMap = {};
    _allQuestions = [];
    _number = 1;
    subjects.forEach((s) {
      _subjectMap[s.subject] = s;
      _allQuestions.addAll(s.questions);
    });
    return size() > 0;
  }

  void setDifficulty(Difficulty difficulty) => _difficulty = difficulty;

  Difficulty getDifficulty() => _difficulty;

  void setPlayers(List<Player> players) {
    this.players.clear();
    this.players.addAll(players);
  }

  void nextPlayer() => _playerIndex = _playerIndex == 1 && players.length > 1 ? 2 : 1;

  Player get player => players.length > _playerIndex ? players[_playerIndex - 1] : null;

  int size() => subjects.length;

  Subject get(String subject) => _subjectMap[subject];

  Question getQuestion(int number) => _allQuestions[number - 1];

  int get totalQuestion => _allQuestions.length;

  String get questionCount => _allQuestions.length <= 9 ? '0${_allQuestions.length}' : '${_allQuestions.length}';

  void nextQuestion() => _number = _number < totalQuestion ? _number + 1 : _number;

  void previousQuestion() => _number = _number > 1 ? _number - 1 : _number;

  void setNumber(int number) => _number = number;

  Question get question => getQuestion(_number);

  String get questionNumber => _number <= 9 ? '0$_number' : '$_number';

  int get number => _number;

  QuizType getType() => players.length == 2 ? (players[1].type == PlayerType.Human ? QuizType.HumanVsHuman : QuizType.HumanVsComputer) : QuizType.SinglePlayer;
  /*{
    if(players.length == 2)
      if(players[1].type == PlayerType.Human)
        return QuizType.HumanVsHuman;
      else
        return QuizType.HumanVsComputer;
    return QuizType.SinglePlayer;
  }*/

  bool add(Subject subject) {
    if (subject != null) subjects.add(subject);
    return update();
  }

  bool contains(String subject) => _subjectMap.containsKey(subject);

  bool remove(String subject) =>
      contains(subject) ? subjects.remove(get(subject)) && update() : false;
}

enum QuizType {
  SinglePlayer, HumanVsComputer, HumanVsHuman
}

enum Difficulty {
  Easy, Medium, Hard
}
