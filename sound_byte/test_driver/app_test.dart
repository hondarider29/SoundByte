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
    final homePage = find.byValueKey('homePage');
    final profilePage = find.byValueKey('profilePage');
    final musicSearch = find.byValueKey("musicSearch");
    final playerPage = find.byValueKey('playerPage');
    final singleSong = find.byValueKey('Always');
    final singleBackButton = find.byValueKey('singleBackButton');

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

    test('Login Again', () async {

      await driver.waitFor(eml);
      await driver.tap(eml);
      await driver.enterText("test@test.com");
      
      sleep(Duration(seconds: 3));
  
      await driver.tap(pwd);
      await driver.enterText("123456");
      
      sleep(Duration(seconds: 2));
      
      await driver.tap(button);
      await driver.waitForAbsent(pwd);
      
    });

    test('Visit Profile Page and Return to Home', () async {
      await driver.waitFor(profilePage);
      await driver.tap(profilePage);

      print("Entering Profile Page");
      
      sleep(Duration(seconds: 3));

      await driver.waitFor(homePage);
      await driver.tap(homePage);

      print("Returning to Home Screen");
      sleep(Duration(seconds: 2));
    });

    test('Visit MusicList Page', () async {
      await driver.waitFor(playerPage);
      sleep(Duration(seconds: 1));
      await driver.tap(playerPage);

      print("Entering Music Player");
      
      sleep(Duration(seconds: 3));
    });

    test('Search for Music on Music List', () async {
      await driver.waitFor(musicSearch);
      sleep(Duration(seconds: 2));
      
      await driver.tap(musicSearch);
      await driver.enterText("Search for Music");
      print("Searching Music List");
      sleep(Duration(seconds: 3));
    });

    test('Viewing Individual Song on Player', () async {
      await driver.waitFor(singleSong);
      sleep(Duration(seconds: 1));
      await driver.tap(find.text("Always"));
  
      sleep(Duration(seconds: 5));
    });

    test('Return to Home Screen', () async {

      await driver.waitFor(singleBackButton);
      sleep(Duration(seconds: 1));
      await driver.tap(singleBackButton);
      sleep(Duration(seconds: 1));

      await driver.waitFor(homePage);
      await driver.tap(homePage);

      print("Returning to Home Screen");
      sleep(Duration(seconds: 2));
    });

  });
}
