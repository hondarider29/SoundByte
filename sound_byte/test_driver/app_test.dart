// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('SoundByte', () {
    
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    Future<void> tap(SerializableFinder element) async {
      await driver.tap(element);
    }

    Future<void> type(SerializableFinder element, String text) async {
      await tap(element);
      await driver.enterText(text);
    }

    SerializableFinder findByKey(String key) {
      return find.byValueKey(key);
    }

    final email = findByKey('email');
    final pwd = findByKey('pass');

    test('Login Successfully', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.

      
      type(email, "dsann@calpoly.edu");
      type(pwd, "soccer");
      
      print("got here");
      
      final button = findByKey("login");
      tap(button);
      
      //expect(await findByKey("authentication_success"), isTrue,
      //    reason: "TEST KO: Authentication did not succeed.");
          


    });

  });
}
