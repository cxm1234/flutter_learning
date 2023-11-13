import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2, 
          children: List.generate(
            100, 
            (index) => 
              Center(
                child: Text(
                  'Item $index', 
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
            )
          ),
        ),
      ),
    );
  }
}
