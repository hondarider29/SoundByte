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
    Firestore.instance.collection('users').document(uID).get().then((documentSnapshot)
                          => user = new User.full(uID, documentSnapshot.data['name'],
                                                      documentSnapshot.data['email'],
                                                      documentSnapshot.data['friends'],
                                                      documentSnapshot.data['chats'])
        );
    return user;
  }

  @override
  bool operator ==(Object other) => other is User && this.userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}

// class User
// {
//   // UserIDs will be in the format userName#xxxx
//   // Where xxxx is a 4 digit int
//   String userID;
//   var formatter = new NumberFormat("0000", "en_US");
  
//   User(String username, int id)
//   {
//     //this.userID = username "#" this.formatter.format(id);
//   }

//   // Returns only the 4 digit int
//   int getUniqueNum()
//   {
//     List<String> parts = userID.split("#");
//     return int.parse(parts[1]);
//   }

//   // Returns only the userName
//   String getUserName()
//   {
//     List<String> parts = userID.split("#");
//     return parts[0].substring(0, parts[0].length-2);
//   }

//   @override
//   bool operator ==(Object other) => other is User && this.userID == other.userID;

//   @override
//   int get hashCode => userID.hashCode;

//   // Fuction to initialze the Dev Users
//   static void initDevUsers(List<User> users)
//   {
//     User temp = new User("JackSkellington", 1031);
//     users.add(temp);

//     temp = new User("SpookyScarySkeleton", 1031);
//     users.add(temp);

//     temp = new User("Dev1", 0001);
//     users.add(temp);

//     temp = new User("Dev2", 0002);
//     users.add(temp);
//   }
// }
