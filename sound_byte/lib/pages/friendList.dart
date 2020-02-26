import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/userProfile.dart';
import 'package:sound_byte/pages/friendProfile.dart';
import 'package:sound_byte/pages/friendScreen.dart';


class FriendList extends StatelessWidget{
  
  User friend;
  String nameOfList;
  int friendsListId;
  int numberOfFriends;
  FriendList listOfFriends;

  FriendsList(int numberOfFriends, FriendList listOfFriends, String nameOfList, int friendsListId) {
    this.numberOfFriends = numberOfFriends;
    this.listOfFriends = listOfFriends;
    this.nameOfList = nameOfList;
    this.friendsListId = friendsListId;
  }

  Widget _buildFriendsList (User friend) {
    print(friend.username);
    print(friend.id);
    return Center (
      child: Container (
        width: 500.0,
        height: 70,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500.0),
        border: Border.all(
          color: Colors.red,
          width: 100.0
        ),
      ),
    )
    );
  }
}