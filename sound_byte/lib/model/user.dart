import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  // UserIDs will be a unique string
  String userID;
  String userName;
  String userEmail;
  // List of friends stored as userIDs
  List<String> friends;
  //List of Conversations by string based ID
  List<String> conversations;

  static User currentUser = null;

  static User instance(String uID)
  {
    if (User.currentUser == null)
    {
      User.currentUser = userFromDatabase(uID);
    }

    return User.currentUser;
  }

  static void clearCurrentUser()
  {
    User.currentUser = null;
  }
  
  User(String username, String email, String id)
  {
    this.userID = id;
    this.userName = username;
    this.userEmail = email;
    friends = new List<String>();
    conversations = new List<String>();
  }

  User.full(String userID, String username, String userEmail, List<String> friends, List<String> conversations)
  {
    this.userID = userID;
    this.userName = username;
    this.userEmail = userEmail;
    this.friends = friends;
    this.conversations = conversations;
  }

  static User userFromDatabase(String uID)
  {
    User user;
    Firestore.instance.collection('users').document(uID).get().then((documentSnapshot)
                          => user = new User.full(uID, documentSnapshot.data['userName'],
                                                      documentSnapshot.data['email'],
                                                      documentSnapshot.data['friends'],
                                                      documentSnapshot.data['conversations'])
        );
    return user;
  }

  @override
  bool operator ==(Object other) => other is User && this.userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
