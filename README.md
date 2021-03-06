# SoundByte

SoundByte is a music livestreaming and sharing app. It is not currently available on any app distribution platforms.

## Features

At full release, SoundByte will have the following features:

- The ability to listen to music.
- The ability to livestream music.
- The ability to send and view messages with friends.
- The ability to send and listen to short clips of music with friends.

## Requirements

- Install the [Dart]( https://dart.dev/get-dart ) and [Flutter SDK]( https://flutter.dev/docs/get-started/install ), as well as your code editor of choice.

- Either an iOS/Android emulator, or a physical iOS/Android device.

## Technical Details

SoundByte uses Flutter, an open-source app development SDK for the Dart language, and is designed to run on both iOS and Android devices. We are using Google Firebase for all of our database needs.

## Roadmap

See [current sprint](https://github.com/hondarider29/SoundByte/projects/8).

## Coding Style

https://dart.dev/guides/language/effective-dart/style.

## Testing Strategy Document

Testing strategy document located [here](https://docs.google.com/document/d/1T2xsMfm-x3glku9qY-0on-asgXoOdzL7I0qZY4TWYU4/edit?usp=sharing). 

## Continuous Integration

Continuous integration is performed by [TravisCI](https://travis-ci.com/hondarider29/SoundByte/).

## Static Code Analysis

All static code analysis is done using the built-in Flutter analyzer, which can be run using ```flutter analyze```, and is output to the file ```static_analysis_report.txt``` which can be found at https://github.com/hondarider29/SoundByte/blob/master/static_analyisis_report.txt.


## Acceptance Testing

Flutter's form of acceptance testing is integration testing. A flutter integration test involves a flutter driver controlling the application and navigating through the application checking for errors and mistakes. Our Acceptance Tests are located in the 'test_driver' folder in a file 'app_test.dart' which can be found [here] (https://github.com/hondarider29/SoundByte/blob/master/sound_byte/test_driver/app_test.dart). To run these tests run the following command from the command line, "flutter drive --target=test_driver/app.dart".

## Unit Tests

Our unit tests test almost every portion of the code that either do not have any communication with the Firebase/Firestore database or don't have any Widget Component. The Unit Tests can be found [here] (https://github.com/hondarider29/SoundByte/blob/master/sound_byte/test/unit_test.dart).

## Getting Started
- To get started, make sure to download a text editor or an IDE that you are comfortable with such as VS Code. 
- Next, there needs to be the installation of Dart and Flutter. Each can be installed individually. However installing the Flutter SDK automatically install Dart on the user's machine. Links to download the Dart and Flutter SDK can be found in the Requirements section of the README. 
- Once clicked on the install Flutter link, the user should chose for what operating system to install the framework and follow the steps and run the commands on that page. 
- The user should then clone the repository using "git clone https://github.com/hondarider29/SoundByte.git" which will then create a clone of the repository on the user's machine.
- The user should then enter the folder and run the command  "flutter doctor" to check for dependencies and install the appropriate dependencies.
- The user should then run the command "flutter run" which would then start the flutter framework and compile the code and cause the flutter machine to start running.
- At this point the user should open up the simulator whether from Android or IOS using their simulators respectively by running the command open -a simulator. 

## Link to the Slides Presentation
https://docs.google.com/presentation/d/1d9COpIdtbxXAYIcxBjw95o3L9wDbs25LA99Z2isxOwQ/edit#slide=id.p

## Authors

- [Carlos Ayala](github.com/cayalame) (cayalame)
- [Rye Cassan](github.com/hondarider29) (hondarider29)
- [Garrett O'Keefe](GMOkeefe) (GMOkeefe)
- [David Sann](github.com/sannd22) (sannd22)
- [Joe Soboleski](github.com/joesobo) (joesobo)
- [Rohan Ramani](github.com/rramani1230) (rramani1230)
