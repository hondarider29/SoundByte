class User
{
  // UserIDs will be in the format userName#xxxx
  // Where xxxx is a 4 digit int
  String userID;
  
  User(String username, int id)
  {
    this.userID = username + "#" + id.toString();
  }

  // Returns only the 4 digit int
  int getUnquieNum()
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
  bool operator ==(Object other)
  {
    return other is User && this.userID == other.userID;
  }
}