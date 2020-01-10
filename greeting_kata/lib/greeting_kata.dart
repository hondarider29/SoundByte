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
  return "Hello, ${names[0]} and ${names[1]}.";
}
