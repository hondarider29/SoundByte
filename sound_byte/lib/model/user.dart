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

  // Fuction to initialze the Dev Users
  static void initDevUsers(List<User> users)
  {
    User temp = new User("JackSkellington", "jackskellington@gmail.com", 1031);
    users.add(temp);

    temp = new User("SpookyScarySkeleton", "spook@hotmail.com", 1031);
    users.add(temp);

    temp = new User("Dev1", "dev@no-reply.aol.com", 0001);
    users.add(temp);

    temp = new User("Dev2", "dev@no-reply.yahoo.com", 0002);
    users.add(temp);
  }
}
