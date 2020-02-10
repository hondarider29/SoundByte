import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  // UserIDs will be a unique string
  String userID;
  String userName;
  String userEmail;
  // List of friends stored as userIDs
  List<String> friends;
  //List of Chats by string based ID
  List<String> chats;

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
    chats = new List<String>();
  }

  User.full(String userID, String username, String userEmail, List<String> friends, List<String> chats)
  {
    this.userID = userID;
    this.userName = username;
    this.userEmail = userEmail;
    this.friends = friends;
    this.chats = chats;
  }

  static User userFromDatabase(String uID)
  {
    User user;
    Firestore.instance.collection('Users').document(uID).get().then((documentSnapshot)
                          => user = new User.full(uID, documentSnapshot.data['name'],
                                                      documentSnapshot.data['email'],
                                                      documentSnapshot.data['friends'],
                                                      documentSnapshot.data['chats'])
        );
    return user;
  }

  void addFriend(String id)
  {
    this.friends.add(id);
    userDataAddFriend(id);
  }

  void userDataAddFriend(String id)
  {
    var ref = Firestore.instance.collection('Users').document(this.userID);

    ref.updateData({'friends': FieldValue.arrayUnion([id])});
  }

  @override
  bool operator ==(Object other) => other is User && this.userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
