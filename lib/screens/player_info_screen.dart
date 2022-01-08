import 'package:flutter/material.dart';

class PlayerInfoScreen extends StatefulWidget {
  const PlayerInfoScreen({Key key}) : super(key: key);

  @override
  _PlayerInfoScreenState createState() => _PlayerInfoScreenState();
}

class _PlayerInfoScreenState extends State<PlayerInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
