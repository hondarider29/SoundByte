import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  // UserIDs will be a unique string
  String userID;
  String userName;
  String userEmail;
  // List of friends stored as userIDs
  List<String> friends;
  // List of Chats by string based ID
  List<String> chats;
  // Document Refrence for the user
  DocumentReference _reference;

  static User currentUser = User.nullUser(); 
  
  static void clearCurrentUser()
  {
    User.currentUser = new User.nullUser();
  }
  
  User(String username, String email, String id)
  {
    this.userID = id;
    this.userName = username;
    this.userEmail = email;
    friends = new List<String>();
    chats = new List<String>();
  }

  User.nullUser()
  {
    this.userID = '';
    this.userName = '';
    this.userEmail = '';
    this.friends = null;
    this.chats = null;
    this._reference = null;
  }

  User.full(String userID, String username, String userEmail, List<String> friends, List<String> chats) {
    this.userID = userID;
    this.userName = username;
    this.userEmail = userEmail;
    this.friends = friends;
    this.chats = chats;
  }

  static Future<User> userFromDatabase(String uID) async
  {
    User user;
    Completer<User> completer = new Completer();
    DocumentReference ref = Firestore.instance.collection('Users').document(uID);
    ref.get().then((documentSnapshot) {
      user = new User.full(uID, documentSnapshot.data['name'],
                                documentSnapshot.data['email'],
                                documentSnapshot.data['friends'].cast<String>().toList(),
                                documentSnapshot.data['chats'].cast<String>().toList());
      user._reference = ref;
      completer.complete(user); 
    });
    return completer.future;
  }

  bool checkFriend(String id)
  {
    return id == "1";
    // return this.friends.contains(id);
  }
  
  // Takes a User ID  and adds it to the friends list
  void addFriend(String id)
  {
    this.friends.add(id);
    this._reference.updateData({'friends': FieldValue.arrayUnion([id])});
  }

  // Takes a User ID and removes it from friends list
  void removeFriend(String id)
  {
    this.friends.remove(id);
    this._reference.updateData({'friends' : FieldValue.arrayRemove([id])});
  }

  // Takes a chat ID and adds it from the chats list
  void addChat(String id)
  {
    this.chats.add(id);
    this._reference.updateData({'chats' : FieldValue.arrayUnion([id])});
  }

  // Takes a chat ID and removes it from the chats list
  void removeChat(String id)
  {
    this.chats.remove(id);
    this._reference.updateData({'chats' : FieldValue.arrayRemove([id])});
  }

  // Updates the Document Refrence
  void updateDocRef()
  {
    this._reference = Firestore.instance.collection('User').document(this.userID);
  }

  @override
  bool operator ==(Object other) => other is User && this.userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}