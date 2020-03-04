import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sound_byte/main.dart';
import 'package:sound_byte/model/user.dart';
import 'package:sound_byte/pages/Songs.dart';

void main() {
  test('Testing tests', () {

    expect(true, true);
  });

  test('Testing new User', () {
    User test = new User('unittester', 'unittest@1.non', 'unittester01');

    expect(test.userEmail, 'unittest@1.non');
    expect(test.userName, 'unittester');
    expect(test.userID, 'unittester01');
    expect(test.friends, new List<String>());
    expect(test.chats, new List<String>());
  });

  test('Testing new Song', () {
    SongItem s = new SongItem("Star Spangled Banner", "Francis Scott Key", "img1");

    expect(s.title, "Star Spangled Banner");
    expect(s.artist, "Francis Scott Key");
    expect(s.image, "img1");
  });

  
}
