import 'package:mixins_demo/mixins_demo.dart' as mixins_demo;

abstract class Animal {
  bool isAlive = true;
  void eat();
  void move();

  @override 
  String toString() {
    return "I'm a $runtimeType";
  }
}

mixin EggLayer {
  void layEggs() {
    print('Plop plop');
  }
}

mixin Flyer {
  void fly() {
    print('Swoosh swoosh');
  }
}

abstract class Bird {
  void fly();
  void layEggs();
}

class Robin extends Bird with EggLayer, Flyer {}

class Platypus extends Animal with EggLayer {
  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }
}

extension on String {
  String get encoded {
    return _code(1);
  }
  String get decoded {
    return _code(-1);
  }

  String _code(int step) {
    final output = StringBuffer();
    for (final codePoint in runes) {
      output.writeCharCode(codePoint + step);
    }
    return output.toString();
  }
}

// class Platypus extends 

void main(List<String> arguments) {
  // final robin = Robin();
  // robin.fly();
  final platypus = Platypus();
  final robin = Robin();

  platypus.layEggs();
  robin.layEggs();
}
