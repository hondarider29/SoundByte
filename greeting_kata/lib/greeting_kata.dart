int calculate() {
  return 6 * 7;
}

String greet(String name) {
  if (name == null)
  {
    return "Hello, my friend.";
  }
  else if (isUppercase(name))
  {
    return "HELLO $name!";
  }
  return "Hello, $name.";
}

@override
String greet(String[] names) {
  if (names.length == 0)
  {
    return greet();
  }
  String[] lowers = [];
  String[] uppers = [];
  for (String name on names)
  {
    if (name.contains(', ') && !(name[0] == '"' && name[name.length - 1] == '"'))
    {
      for (String name2 in name.split(", "))
      {
        if (isUppercase(name))
        {
          uppers.add(name);
        }
        else
        {
          lowers.add(name);
        }
      }
    }
    else if (isUppercase(name))
    {
      if (name[0] == '"' && name[name.length - 1] == '"')
      {
        name = name.replaceAll('"', "");
      }
      uppers.add(name);
    }
    else
    {
      if (name[0] == '"' && name[name.length - 1] == '"')
      {
        name = name.replaceAll('"', "");
      }
      lowers.add(name);
    }
  }

  String res;
  if (lowers.length == 1)
  {
    res = greet(lowers[0]);
    if (uppers.length > 0)
    {
      res += loopUppers(uppers);
    }
    return res;
  }

  if (lowers.length == 2)
  {
    res = "Hello, ${names[0]} and ${names[1]}.";
    if (uppers.length > 0)
    {
      res += loopUppers(uppers);
    }
    return res;
  }

  return loopLowers(lowers) + loopUppers(uppers);
}

String loopUppers(String[] names)
{
  String res = " AND"
  for (String name in names)
  {
    if (name != names[names.length - 1])
    {
      res += " $name";
    }
    else if (name.length = 1)
    {
      res += " $name!";
    }
    else
    {
      res += " AND $name!";
    }
  }
  return res;
}

String loopLowers(String[] names)
{
  String res = "Hello";
  for (String name in names)
  {
    if (name != names[names.length - 1])
    {
      res += ", $name";
    }
    else
    {
      res += ", and $name.";
    }
  }
  return res
}
