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
    final userProf = find.byValueKey('userProfile');
    final backProfile = find.byValueKey('backProfile');
    final friendProf = find.byValueKey('friendProf');
    final backFriendProfile = find.byValueKey('backFriendProfile');

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

      print("Enter Email");
      await driver.tap(eml);
      await driver.enterText("dsann@calpoly.edu");
      
      sleep(Duration(seconds: 3));
      
      print("Enter Password");
      await driver.tap(pwd);
      await driver.enterText("soccer");
      
      sleep(Duration(seconds: 2));
      
      await driver.tap(button);
      await driver.waitForAbsent(pwd);
      
    });

    test('Enter/Leave User Profile Page', () async {
      sleep(Duration(seconds: 2));
      await driver.tap(userProf);
      print("Entering User Profile");
      sleep(Duration(seconds: 2));
      await driver.tap(backProfile);
      print("Leaving user profile page");
      sleep(Duration(seconds: 2));
    });

    /*
    test('Enter/Leave Friend Profile Page', () async {

      await driver.tap(friendProf);
      print("Entering Friend Profile");
      sleep(Duration(seconds: 2));
      await driver.tap(backFriendProfile);
      print("Leaving Friend profile page");
      sleep(Duration(seconds: 2));
    });
    */


    
    
  });
}
