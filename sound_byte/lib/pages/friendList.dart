import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/userProfile.dart';
import 'package:sound_byte/pages/friendProfile.dart';
import 'package:sound_byte/pages/friendScreen.dart';
import 'package:sound_byte/pages/user.dart';

class FriendList extends StatelessWidget{
  User user;
  List<String> user_friends;
  int number_of_friends;
  String user_id;

  FriendList (User user) {
    this.user = user;
    this.user_friends = user.friends;
    this.number_of_friends = user.friends.length();
    this.user_id = user.userId;
  }

  FriendList.nullFriendList() {
    this.user = new User("Test", 
                        "test@test.com", 
                        "Test");
    this.user_friends = new List<String>();
    this.number_of_friends = 0;
    this.user_id = "12345";
  }

  bool isNull () {
    return (user == null || user_friends == null);
  }

  void printFriendInfo () {
    for (int i = 0; i < user_friends.length(); i++) {
      return Text (
        user_friends.get(i).username
      );
    }
  }

  Widget _buildOneFriend () {
    return Center(
      child: Container(
        width: 650.0, //Needs floats Ints do not work
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: Colors.blue,
            width: 20
          )
        ),
        printFriendInfo()
      );
    );
  }

  Widget _buildFriendsListTopBar () {
    return Container(
      width: 650.0,
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.blue,
          width: 20
        )
      )
    )
  }
  
  Widget _buildFriendsListBottomBar () {
    return Container(
      width: 300.0,
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.black,
          width: 20
        )
      )
    );
  }

  Widget _buildFriendsList_test () {
    for (int i = 0; i < user_friends.length(); i++) {
      _buildFriendsListTopBar();
      _buildFriendsListBottomBar();
      _buildOneFriend();
    }
  } 
}
