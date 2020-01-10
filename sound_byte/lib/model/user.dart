import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class User
{
  // UserIDs will be a unique int
  int userID;
  String userName;
  String userEmail;
  // List of friends stored as userIDs
  List<String> friends;
  //List of Conversations by string based ID
  List<String> conversations;
  
  User(String username, String email, int id)
  {
    this.userID = id;
    this.userName = username;
    this.userEmail = email;
    friends = new List<String>();
    conversations = new List<String>();
  }

  User.full(int userID, String username, String userEmail, List<String> friends, List<String> conversations)
  {
    this.userID = userID;
    this.userName = username;
    this.userEmail = userEmail;
    this.friends = friends;
    this.conversations = conversations;
  }

  //TODO: edit so that it uses UID instead of email
  User userFromDatabase(int uID)
  {
    User user;
    Firestore.instance.collection('users').where('email', isEqualTo: userEmail).getDocuments()
      .then((documentSnapshot) => user = new User.full(uID, documentSnapshot.documents[0].data['userName']
                                                      documentSnapshot.documents[0].data['email'],
                                                      documentSnapshot.documents[0].data['friends'],
                                                      documentSnapshot.documents[0].data['conversations'])
        );
    return user;
  }

  @override
  bool operator ==(Object other) => other is User && this.userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
