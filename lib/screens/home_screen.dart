import 'package:flutter/material.dart';
import 'package:quizapp/widgets/widgets.dart';

import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      /*appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),*/
      body: Container(
        color: Colors.black87,
        child: Center(
          child: MultiColoredText(
            text: 'Quiz',
            width: width - 20,
            color: Colors.white,
            radius: 8.0,
            fontSize: 24.0,
            onTap: () => goToScreen(context, QuestionScreen()),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            backgroundColor: Colors.green,
            alignment: TextAlignment.center,
          ),
        ),
      ),
      extendBodyBehindAppBar: false,
    );
  }
}
