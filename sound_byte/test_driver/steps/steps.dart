import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

/*
class LoginValidation extends GivenWithWorld<FlutterWorld> {

  @override
  Future<void> executeStep() async {
    String input1 = "test@test.com";
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('inputKeyString')); //in main
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('inputKeyString'), input1);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I expect the user enters email");

}

class PasswordValidation extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    String password = "test1234";

    await FlutterDriverUtils.tap(world.driver, find.byValueKey('passKeyString'));
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey('passKeyString'), password);

  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I expect the user enters password");

}

class LoginButton extends WhenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.tap(world.driver, find.byValueKey('button'));
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"user hits login button");

}

class Nav_Validation extends ThenWithWorld<FlutterWorld> {

  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    await FlutterDriverUtils.isPresent(find.byValueKey('nextScreenKey'), world.driver);

  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"user should land on next screen");

}
*/
