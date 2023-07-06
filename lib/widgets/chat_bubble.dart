import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    required this.message,
    super.key,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({
    required this.message,
    super.key,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50)),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
