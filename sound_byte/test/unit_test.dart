import 'package:flutter_test/flutter_test.dart';
import 'package:sound_byte/model/user.dart';
import 'package:sound_byte/pages/Songs.dart';
import 'package:sound_byte/pages/musicPlayer.dart';

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

  test('Testing the other branch for User.full', () {
    User test = new User.full('unittester01', 'unittester', 'unittest@1.non', null, null);

    expect(test.userEmail, 'unittest@1.non');
    expect(test.userName, 'unittester');
    expect(test.userID, 'unittester01');
    expect(test.friends, new List<String>());
    expect(test.chats, new List<String>());
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
  
  test('Testing Music player', () {
    MusicPlayer m = MusicPlayer("Star", "USA", "img1");
    
    expect(m.title, "Star");
    expect(m.artist, "USA");
    expect(m.image, "img1");
  });

}
