import 'package:flutter/material.dart';
import 'package:sound_byte/chatScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      home: PageView(
        children: <Widget> [
          ChatScreen(),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}