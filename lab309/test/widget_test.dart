// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab309/main.dart';

void main() {
 
  test("Req1", () {

    expect(greet("David"), "Hello, David.");
        });

  test("Req2", () {

    expect(greet(null), "Hello, my friend.");
        });
  
  test("Req3", () {

    expect(greet("DAVID"), "HELLO DAVID!");
        });
  
  test("Req4", () {

    expect(greetList(["David", "Carlos"]), "Hello, David, and Carlos.");
        });
  
  test("Req5", () {

    expect(greetList(["David", "Carlos", "Rohan"]), "Hello, David, Carlos, and Rohan.");
        });

  test("Req6", () {

    expect(greetList2(["David", "Carlos", "ROHAN"]), "Hello, David, and Carlos. AND HELLO ROHAN!");
        });
  
  test("Req7", () {

    expect(greetCommas(["David", "Carlos, Rohan"]), "Hello, David, Carlos, and Rohan.");
        });

  test("Req8", () {

    expect(greetSlash(["David", "\"Carlos, Rohan\""]), "Hello, David, , Carlos, Rohan, and .");
        });
}
