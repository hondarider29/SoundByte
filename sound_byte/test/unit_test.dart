import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sound_byte/main.dart';
import 'package:sound_byte/helperClasses/messageEncrypter.dart';
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

  test('Testing new User.nullUser', () {
    User test = new User.nullUser();

    expect(test.userEmail, '');
    expect(test.userName, '');
    expect(test.userID, '');
    expect(test.friends, null);
    expect(test.chats, null);
  });

  test('Testing new User.full', () {
    List<String> friends = ["I", "have", "no", "firends"];
    List<String> chats = ["My", "self"];
    User test = new User.full('unittester01', 'unittester', 'unittest@1.non', friends, chats);

    expect(test.userEmail, 'unittest@1.non');
    expect(test.userName, 'unittester');
    expect(test.userID, 'unittester01');
    expect(test.friends, friends);
    expect(test.chats, chats);
  });

  test('Testing clearCurrentUser', () {
    User.currentUser = new User('unittester', 'unittest@1.non', 'unittester01');

    User.clearCurrentUser();

    expect(User.currentUser, new User.nullUser());
  });

  test('Testing new Song', () {
    SongItem s = new SongItem("Star Spangled Banner", "Francis Scott Key", "img1");

    expect(s.title, "Star Spangled Banner");
    expect(s.artist, "Francis Scott Key");
    expect(s.image, "img1");
  });

  test('Creating new MessageEncrypter Pair', () {
    final password1 = 'password';
    final password2 = 'pass1234';

    var m1 = new MessageEncrypter(password1);
    var m2 = new MessageEncrypter.forReceiver(
      password2, m1.textKey, m1.ivText);

    expect(m1.textKey, m2.textKey);
    expect(m1.passKey, isNot(m2.passKey));
    expect(m1.ivText, m2.ivText);
  });

  test('Encrypting a message', () {
    final password = 'password';
    final message = 'message';
    
    var encrypter = MessageEncrypter(password);
    var cipher = encrypter.encrypt(message);

    expect(encrypter.decrypt(cipher), message);
  });

  test('Sending a message', () {
    final password1 = 'password';
    final password2 = 'pass1234';
    final message = 'message';

    var encrypter = MessageEncrypter(password1);
    var decrypter = MessageEncrypter.forReceiver(
      password2, encrypter.textKey, encrypter.ivText);
    var cipher = encrypter.encrypt(message);
    var received = decrypter.decrypt(cipher);

    expect(message, received);    
  });

  test('Storing key data', () {
    final password = 'password';
    
    var m = MessageEncrypter(password);
    print(m.passkey.stretch(32).base64.length);
    print(m.passKey.length);
    var data = m.encodeData();
    var mRehyd = MessageEncrypter.rehydrate(password, data);

    expect(m.textKey, mRehyd.textKey);
    expect(m.passKey, mRehyd.passKey);
    expect(m.ivText, mRehyd.ivText);
  });
}
