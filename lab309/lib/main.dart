import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

greet(String s) {
  if (s != null) {
    if (isUppercase(s)) {
      return "HELLO " + s + "!";
    }
    return "Hello, " + s + ".";
  } 
  return "Hello, my friend.";
}

greetList(List<String> names) {
  int size = names.length;
  String fin = "Hello, ";
  for (int i = 0; i < size - 1; i ++) {
    fin += names[i] + ", ";
  }
  fin += "and " + names[size - 1] + ".";
  return fin;
}

greetList2(List<String> names) {
  int size = names.length;
  String fin = "Hello, ";
  String fin1 = " AND HELLO ";
  List<String> shout = new List<String>();
  List<String> noShout = new List<String>();

  for (int i = 0; i < size; i++) {
    if (isUppercase(names[i])) {
      shout.add(names[i]);
    } else {
      noShout.add(names[i]);
    }
  }

  int size1 = noShout.length;
  for (int i = 0; i < size1 - 1; i ++) {
    fin += noShout[i] + ", ";
  }
  fin += "and " + noShout[size1 - 1] + ".";

  int size2 = shout.length;
  for (int i = 0; i < size2 - 1; i ++) {
    fin1 += shout[i] + ", ";
  }
  fin1 += shout[size2 - 1];
  return fin + fin1 + "!";
}

greetCommas(List<String> names) {
  int size = names.length;
  List<String> nam = new List<String>();
  for (int i = 0; i < size; i ++) {
    if (names[i].contains(",")) {

      nam += names[i].split(", ");
    } else {
      nam.add(names[i]);
    }
  }
  return greetList(nam);
}

greetSlash(List<String> names) {
  int size = names.length;
  List<String> nam = new List<String>();
  for (int i = 0; i < size; i ++) {
    if (names[i].contains("\"")) {

      nam += names[i].split("\"");
    } else {
      nam.add(names[i]);
    }
  }
  return greetList(nam);
}
