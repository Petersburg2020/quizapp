import 'package:flutter/material.dart';
import 'package:quizapp/screens/screens.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: ChatScreenMobile(),
      desktop: ChatScreenDesktop(),
    );
  }
}

class ChatScreenMobile extends StatefulWidget {
  const ChatScreenMobile({Key key}) : super(key: key);

  @override
  _ChatScreenMobileState createState() => _ChatScreenMobileState();
}

class _ChatScreenMobileState extends State<ChatScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class ChatScreenDesktop extends StatefulWidget {
  const ChatScreenDesktop({Key key}) : super(key: key);

  @override
  _ChatScreenDesktopState createState() => _ChatScreenDesktopState();
}

class _ChatScreenDesktopState extends State<ChatScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

