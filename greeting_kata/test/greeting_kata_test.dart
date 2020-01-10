import 'package:greeting_kata/greeting_kata.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });

  test('req1', () {
    expect(greet("Joe"), "Hello, Joe.");
  });

  test('req2', () {
    expect(greet(), "Hello, my friend.");
  });

  test('req3', () {
    expect(greet("JOE"), "HELLO JOE!");
  });

  test('req4', () {
    expect(greet(["Joe", "Rye"]), "Hello, Joe and Rye.");
  });

  test('req5', () {
    expect(greet(["Joe", "Rye", "Garrett"]), "Hello, Joe, Rye, and Garrett.");
  });

  test('req6', () {
    expect(greet(["JOE", "Rye", "Garrett"]), "Hello, Rye and Garrett. AND HELLO JOE!");
  });

  test('req7', () {
    expect(greet(["Joe", "Rye, Garrett"]), "Hello, Joe, Rye, and Garrett.");
  });

  test('req8', () {
    expect(greet(["Joe", "\"Rye, Garrett\""]), "Hello, Joe and Rye, Garrett.");
  });
}
