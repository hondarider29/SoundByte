// Imports the Flutter Driver API.
// Command to run driver:  "flutter drive --target=test_driver/app.dart"


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
    final logout = find.byValueKey('logOut');
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
      await driver.enterText("test@test.com");
      
      sleep(Duration(seconds: 3));
      
      print("Enter Password");
      await driver.tap(pwd);
      await driver.enterText("123456");
      
      sleep(Duration(seconds: 2));
      
      await driver.tap(button);
      await driver.waitForAbsent(pwd);
      
    });

    test('Logout', () async {
      sleep(Duration(seconds: 2));
      print("Attempting Log Out");
      await driver.tap(logout);
      await driver.waitForAbsent(logout);
      print("Sucessfully Logged Out");
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
