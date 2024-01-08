import 'package:example_of_implementing/example_of_implementing.dart' as example_of_implementing;

class AnotherClass {
  int myField = 42;
  void myMethod() => print(myField);
}

class SomeClass implements AnotherClass {
  @override
  int myField = 18;

  @override
  void myMethod() => print('Hello');

}

void main(List<String> arguments) {
  final someClass = SomeClass();
  print(someClass.myField);
  someClass.myMethod();
}
