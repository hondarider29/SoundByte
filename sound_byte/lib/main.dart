import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:sound_byte/loginScreen.dart';
=======
import 'package:sound_byte/friendScreen.dart';
import 'package:sound_byte/homePage.dart';
>>>>>>> added a 2 new pages and imported firestore stuff

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound Byte',
      home: PageView(
        children: <Widget>[
<<<<<<< HEAD
          LoginScreen(),
          /* HomePage(),
          ChatScreen(),
=======
          FriendScreen(),
          HomePage(),
>>>>>>> added a 2 new pages and imported firestore stuff
          Container(
            color: Colors.green,
          ),*/
        ],
      ),
    );
  }

  bool testFunction() {
    return true;
  }
}