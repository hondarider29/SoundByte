// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'dart:async';
import 'package:test/test.dart';

void main() {
  group('SoundByte', () {
    
    FlutterDriver driver;
    final pwd = find.byValueKey('pass');
    final eml = find.byValueKey('mail');
    final button = find.byValueKey('login');

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    
    test('Login Successfully', () async {

      await driver.waitFor(eml);

      print("1");
      await driver.tap(eml);
      await driver.enterText("dsann@calpoly.edu");
      
      sleep(Duration(seconds: 3));
      
      print("2");
      await driver.tap(pwd);
      await driver.enterText("soccer");
      
      sleep(Duration(seconds: 2));
      
      await driver.tap(button);
      await driver.waitForAbsent(pwd);
      
    });

    /*
    test('Click On Friends Profile', () async {

      
    });
    */
    
  });
}
