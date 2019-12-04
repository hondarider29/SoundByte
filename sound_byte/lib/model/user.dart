import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class User
{
  // UserIDs will be in the format userName#xxxx
  // Where xxxx is a 4 digit int
  String userID;
  String userEmail;
  // List of friends stored as userIDs
  List<String> friends;
  //List of Conversations by string based ID
  List<String> conversations;
  var formatter = new NumberFormat("0000", "en_US");
  
  User(String username, String email, int id)
  {
    this.userID = username + "#"  + this.formatter.format(id);
    this.userEmail = email;
  }

  User.full(String userID, String userEmail, List<String> friends, List<String> conversations)
  {
    this.userID = userID;
    this.userEmail = userEmail;
    this.friends = friends;
    this.conversations = conversations;
  }

  User userFromDatabase(String userEmail)
  {
    User user;
    Firestore.instance.collection('users').where('email', isEqualTo: userEmail).getDocuments()
      .then((documentSnapshot) => user = new User.full(documentSnapshot.documents[0].data['userID'],
                                                      documentSnapshot.documents[0].data['email'],
                                                      documentSnapshot.documents[0].data['friends'],
                                                      documentSnapshot.documents[0].data['conversations'])
        );
    return user;
  }

  // Returns only the 4 digit int
  int getUniqueNum()
  {
    List<String> parts = userID.split("#");
    return int.parse(parts[1]);
  }

  // Returns only the userName
  String getUserName()
  {
    List<String> parts = userID.split("#");
    return parts[0].substring(0, parts[0].length-2);
  }

  @override
  bool operator ==(Object other) => other is User && this.userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
