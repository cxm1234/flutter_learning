import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: Center(
          child: buildRow(),
        ),
      ),
    );
  }

  Widget buildRow() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(child: Image.asset('images/pic1.jpg')),
        Expanded(flex: 4, child: Image.asset('images/pic2.jpg')),
        Expanded(flex: 2, child: Image.asset('images/pic3.jpg')),
      ]);
}


