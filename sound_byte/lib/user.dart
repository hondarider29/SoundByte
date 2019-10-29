class User
{
  String userID;
  
  User(String username, int id)
  {
    this.userID = username + "#" + id.toString();
  }

  int getUnquieNum()
  {
    List<String> parts = userID.split("#");
    return int.parse(parts[1]);
  }

  String getUserName()
  {
    List<String> parts = userID.split("#");
    return parts[0].substring(0, parts[0].length-2);
  }
}