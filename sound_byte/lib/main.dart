import 'package:flutter/material.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/root_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SoundByte',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(auth: Auth()));
  }
}
