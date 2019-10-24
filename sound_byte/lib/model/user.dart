import 'package:intl/intl.dart';

class User
{
  // UserIDs will be in the format userName#xxxx
  // Where xxxx is a 4 digit int
  String userID;
  var formatter = new NumberFormat("0000", "en_US");
  
  User(String username, int id)
  {
    this.userID = username + "#"  + this.formatter.format(id);
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
    User temp = new User("JackSkellington", 1031);
    users.add(temp);

    temp = new User("SpookyScarySkeleton", 1031);
    users.add(temp);

    temp = new User("Dev1", 0001);
    users.add(temp);

    temp = new User("Dev2", 0002);
    users.add(temp);
  }
}
