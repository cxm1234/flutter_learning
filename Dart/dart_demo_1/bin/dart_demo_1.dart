import 'dart:math';

import 'package:dart_demo_1/dart_demo_1.dart' as dart_demo_1;

void main() async {
  print('Compute pi using the Monte Carlo method.');
  await for (final estimate in computePi().take(100)) {
    print('π = $estimate');
  }
}

Stream<double> computePi({int batch = 100000}) async* {
  var total = 0;
  var count = 0;
  while (true) {
    final points = generateRandom().take(batch);
    final inside = points.where((element) => element.isInsideUnitCircle);

    total += batch;
    count += inside.length;
    final ratio = count / total;
    yield ratio * 4;
  }
}

Iterable<Point> generateRandom([int? seed]) sync* {
  final random  = Random(seed);
  while (true) {
    yield Point(random.nextDouble(), random.nextDouble());
  }
}

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  bool get isInsideUnitCircle => x * x + y * y <= 1;
}