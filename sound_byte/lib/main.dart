import 'package:flutter/material.dart';
import 'package:sound_byte/chatScreen.dart';
import 'package:sound_byte/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound Byte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageView(
        children: <Widget>[
          HomePage(),
          ChatScreen(),
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
