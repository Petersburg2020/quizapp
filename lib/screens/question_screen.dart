import 'package:flutter/material.dart';
import 'package:quizapp/screens/screens.dart';
import 'package:quizapp/utils/utils.dart';
import 'package:quizapp/widgets/widgets.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key key, this.players = const []}) : super(key: key);

  final List<Player> players;

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Questions questions;
  bool selectedA;
  bool selectedB;
  bool selectedC;
  bool selectedD;
  Quiz quiz;

  @override
  void initState() {
    questions = Questions();
    quiz = questions.getQuiz();
    quiz.setPlayers(widget.players);
    _deselectAll();
    super.initState();
  }

  void _deselectAll() {
    selectedA = false;
    selectedB = false;
    selectedC = false;
    selectedD = false;
  }

  int getSelectedOption() {
    if (selectedA)
      return 1;
    else if (selectedB)
      return 2;
    else if (selectedC)
      return 3;
    else if (selectedD) return 4;
    return 0;
  }

  Widget _buildOption(int index, double width, Question q, bool selected) =>
      Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: OptionButton(
          text: q.options[index - 1],
          width: width * 0.9,
          fontSize: 18.0,
          isSelected: selected,
          onTap: (button, selected) => setState(() {
            switch (index) {
              case 1:
                _deselectAll();
                selectedA = true;
                break;

              case 2:
                _deselectAll();
                selectedB = true;
                break;

              case 3:
                _deselectAll();
                selectedC = true;
                break;

              case 4:
                _deselectAll();
                selectedD = true;
                break;
            }
          }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Petersburgz Quiz Game',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Container(
        color: Colors.black87,
        width: width,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    MultiColoredText(
                      text: 'Mathematics Quiz',
                      fontSize: 24.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      width: width * 0.9,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    MultiColoredText(
                      text:
                          'Question ${quiz.questionNumber}/${quiz.questionCount}',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      width: width * 0.9,
                      subTexts: [
                        TextColor(
                          'Question ${quiz.questionNumber}/${quiz.questionCount}',
                          '/${quiz.questionCount}',
                          fontSize: 24.0,
                          fontWeight: FontWeight.normal,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Line(length: width * 0.9),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.9,
                child: Center(
                  child: Column(
                    children: [
                      quiz.question.hasImage()
                          ? Container(
                              height: height / 5,
                              width: width * 0.8,
                              child: Image.asset(
                                '${quiz.question.imageUrl}',
                                fit: BoxFit.fill,
                              ),
                            )
                          : SizedBox(
                              height: 0.0,
                            ),
                      Image(
                        image: AssetImage('${quiz.question.imageUrl}'),
                        height: height / 5,
                        width: width * 0.8,
                      ),
                      Text(
                        quiz.question.question,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: width * 0.9,
                child: Column(
                  children: [
                    _buildOption(1, width, quiz.question, selectedA),
                    _buildOption(2, width, quiz.question, selectedB),
                    _buildOption(3, width, quiz.question, selectedC),
                    _buildOption(4, width, quiz.question, selectedD),
                  ],
                ),
              ),
              Container(
                width: width * 0.9,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Quit Quiz');
                            goToScreen(context, HomeScreen());
                          },
                          child: Container(
                            width: (width * 0.9 * 2) / 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.power_settings_new_rounded,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                                Text(
                                  'Quit Quiz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print('Next Question');
                              final question = quiz.question;
                              final player = quiz.player;

                              question.isCorrect = false;
                              int option = getSelectedOption();
                              question.chooseOption(option);

                              if (player != null && question.isCorrect)
                                player.setScore(player.score + 1);

                              if (quiz.number < quiz.totalQuestion) {
                                quiz.setNumber(quiz.number + 1);
                                _deselectAll();
                              } else {
                                goToScreen(context, HomeScreen());
                              }
                            });
                          },
                          child: Container(
                            width: (width * 0.9 * 2) / 5,
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
