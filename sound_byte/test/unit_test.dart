import 'package:flutter_test/flutter_test.dart';
import 'package:sound_byte/model/user.dart';
import 'package:sound_byte/pages/Songs.dart';
import 'package:sound_byte/pages/musicPlayer.dart';

/* We are unable to test any method that makes a call to the database
*  as the database requires an app in order to authenticate and connect.
*  The unit tester is not considered commplete aplication and firebase
*  refuses the connection.
*/

/* We have 8 testable funtions in user.dart of which 6 are tested,
*   hash was not conidered needed to tested as it isn't used, and 
*   for getFriendName we can't populate the private map it uses from the unit tester
*/

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

  test('Testing checkFriend', () {
    List<String> friends = ['randomId'];
    User test = new User.full('unittester01', 'unittester', 'unittest@1.non', friends, null);

    expect(test.checkFriend('randomId'), true);
    expect(test.checkFriend('notRandomId'), false);
  });

  test('Testing user equality', () {
    User test1 = new User.full('unittester01', 'unittester', 'unittest@1.non', null, null);
    User test2 = new User.full('unittester01', 'unittesterNew', 'unittest@1.com', null, null);
    User test3 = new User.full('unittester02', 'unittesterNew', 'unittest@1.com', null, null);

    expect(test1 == test1, true);
    expect(test1 == test3, false);
    expect(test2 == test3, false);
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
