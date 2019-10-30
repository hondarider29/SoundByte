import 'package:flutter/material.dart';
import 'package:sound_byte/friendScreen.dart';
import 'package:sound_byte/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound Byte',
      home: PageView(
        children: <Widget>[
          FriendScreen(),
          HomePage(),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  bool testFunction() {
    return true;
  }
}
