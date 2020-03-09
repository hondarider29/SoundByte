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
  Map<String, String> _idToName;
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
    this.friends = new List<String>();
    this._idToName = new Map<String, String>();
    this.chats = new List<String>();
    this._reference = null;
  }

  User.nullUser()
  {
    this.userID = '';
    this.userName = '';
    this.userEmail = '';
    this.friends = null;
    this._idToName = null;
    this.chats = null;
    this._reference = null;
  }

  User.full(String userID, String username, String userEmail, List<String> friends, List<String> chats) {
    this.userID = userID;
    this.userName = username;
    this.userEmail = userEmail;
    if (friends == null)
    {
      this.friends = new List();
    }
    else
    {
      this.friends = friends;
    }
    this._idToName = new Map();
    if (chats == null)
    {
      this.chats = new List();
    }
    else
    {
      this.chats = chats;
    }
  }

  static Future<User> userFromDatabase(String uID) async
  {
    User user;
    Completer<User> completer = new Completer();
    DocumentReference ref = Firestore.instance.collection('Users').document(uID);
    ref.get().then((documentSnapshot) async
    {
      user = new User.full(uID, documentSnapshot.data['name'],
                                documentSnapshot.data['email'],
                                documentSnapshot.data['friends'].cast<String>().toList(),
                                documentSnapshot.data['chats'].cast<String>().toList());
      user._reference = ref;
      await user._fillMap();
      completer.complete(user); 
    });
    return completer.future;
  }

  Future<Map<String, String>> _fillMap() async
  {
    String name;
    Completer<Map<String, String>> completer = new Completer();
    for(String friend in this.friends)
    {
      name = await _userNamefromUserID(friend);
      this._idToName.putIfAbsent(friend, () => name);
    }
    completer.complete(this._idToName);
    return completer.future;
  }

  Future<String> _userNamefromUserID(String uID) async
  {
    String name;
    Completer<String> completer = new Completer();
    Firestore.instance.collection('Users').document(uID).get().then((documentSnapshot)
    {
      name = documentSnapshot.data['name'];
      completer.complete(name);
    });
    return completer.future;
  }

  String getFriendName(String uid)
  {
    return this._idToName[uid];
  }

  bool checkFriend(String id)
  {
    return this.friends.contains(id);
  }
  
  // Takes a User ID  and adds it to the friends list
  void addFriend(String id)
  {
    this.friends.add(id);
    this._reference.updateData({'friends': FieldValue.arrayUnion([id])});
    this._fillMap();
  }

  // Takes a User ID and removes it from friends list
  void removeFriend(String id)
  {
    this.friends.remove(id);
    this._reference.updateData({'friends' : FieldValue.arrayRemove([id])});
    this._idToName.remove(id);
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
